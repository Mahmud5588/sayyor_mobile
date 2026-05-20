import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayyor/core/di/service_locator.dart';
import 'package:sayyor/core/l10n/app_localizations.dart';
import 'package:sayyor/core/themes/app_colors.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/widgets/app_async_state_view.dart';
import 'package:sayyor/features/chat/presentation/screen/chat_detail_screen.dart';
import 'package:sayyor/features/profile/data/saved_masters_mock_repository.dart';

class SavedMastersScreen extends StatefulWidget {
  const SavedMastersScreen({super.key});

  @override
  State<SavedMastersScreen> createState() => _SavedMastersScreenState();
}

class _SavedMastersScreenState extends State<SavedMastersScreen> {
  late Future<List<SavedMasterData>> _mastersFuture;
  String? _loadedLocaleKey;
  final Set<String> _removedMasterIds = <String>{};

  final SavedMastersMockRepository _repository =
      sl<SavedMastersMockRepository>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localeKey = Localizations.localeOf(context).toLanguageTag();
    if (_loadedLocaleKey != localeKey) {
      _loadedLocaleKey = localeKey;
      _mastersFuture = _repository.loadSavedMasters(
        AppLocalizations.of(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.profileSavedMastersTitle,
          style: theme.textTheme.headlineSmall,
        ),
        centerTitle: false,
      ),
      body: FutureBuilder<List<SavedMasterData>>(
        future: _mastersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return AppAsyncStateView.loading(l10n);
          }

          if (snapshot.hasError) {
            return AppAsyncStateView.error(
              l10n: l10n,
              subtitle: l10n.stateErrorSubtitle,
              onRetry: () {
                setState(() {
                  _loadedLocaleKey = null;
                });
                didChangeDependencies();
              },
            );
          }

          final data = snapshot.data ?? <SavedMasterData>[];
          final masters = data
              .where((master) => !_removedMasterIds.contains(master.id))
              .toList();

          if (masters.isEmpty) {
            return AppAsyncStateView.empty(
              l10n: l10n,
              subtitle: l10n.stateEmptySubtitle,
            );
          }

          return ListView.separated(
            padding: AppSizes.padding16,
            itemBuilder: (context, index) {
              final master = masters[index];
              return _SavedMasterCard(
                master: master,
                l10n: l10n,
                onChatTap: () => _openChat(master),
                onToggleSaved: () => _toggleSaved(master),
              );
            },
            separatorBuilder: (_, __) => AppSizes.gH12,
            itemCount: masters.length,
          );
        },
      ),
    );
  }

  void _openChat(SavedMasterData master) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatDetailScreen(
          masterName: master.name,
          imageUrl: master.avatarUrl,
          isNewChat: false,
        ),
      ),
    );
  }

  void _toggleSaved(SavedMasterData master) {
    setState(() {
      _removedMasterIds.add(master.id);
    });
  }
}

class _SavedMasterCard extends StatelessWidget {
  final SavedMasterData master;
  final AppLocalizations l10n;
  final VoidCallback onChatTap;
  final VoidCallback onToggleSaved;

  const _SavedMasterCard({
    required this.master,
    required this.l10n,
    required this.onChatTap,
    required this.onToggleSaved,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: AppSizes.padding16,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppSizes.borderRadius20,
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.16),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundImage: NetworkImage(master.avatarUrl),
              ),
              AppSizes.gW12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      master.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    AppSizes.gH4,
                    Text(
                      master.specialty,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    AppSizes.gH4,
                    Text(
                      '${l10n.myOrdersLocationLabel}: ${master.location}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onToggleSaved,
                icon: const Icon(
                  Icons.favorite_rounded,
                  color: AppColors.kError,
                ),
              ),
            ],
          ),
          AppSizes.gH12,
          Wrap(
            spacing: AppSizes.w8,
            runSpacing: AppSizes.h8,
            children: [
              _StatPill(
                icon: Icons.star_rounded,
                iconColor: Colors.amber,
                label: l10n.homeMasterRatingLabel,
                value: master.rating.toStringAsFixed(1),
              ),
              _StatPill(
                icon: Icons.verified_rounded,
                iconColor: AppColors.kSuccess,
                label: l10n.homeMasterCompletedJobsLabel,
                value: master.completedJobs.toString(),
              ),
              _StatPill(
                icon: Icons.work_outline_rounded,
                iconColor: theme.colorScheme.primary,
                label: l10n.homeMasterExperienceSuffix,
                value: master.experienceYears.toString(),
              ),
            ],
          ),
          AppSizes.gH12,
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: AppSizes.padding12,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withValues(
                      alpha: 0.4,
                    ),
                    borderRadius: AppSizes.borderRadius16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.myOrdersPriceLabel,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      AppSizes.gH4,
                      Text(
                        master.startingPrice,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSizes.gW8,
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w12,
                  vertical: AppSizes.h8,
                ),
                decoration: BoxDecoration(
                  color: master.isAvailable
                      ? AppColors.kSuccess.withValues(alpha: 0.1)
                      : theme.colorScheme.errorContainer.withValues(alpha: 0.4),
                  borderRadius: AppSizes.borderRadius12,
                ),
                child: Text(
                  master.isAvailable
                      ? l10n.homeMasterFree
                      : l10n.homeMasterBusy,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: master.isAvailable
                        ? AppColors.kSuccess
                        : theme.colorScheme.onErrorContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          AppSizes.gH12,
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onChatTap,
              icon: const Icon(Icons.chat_bubble_outline_rounded),
              label: Text(l10n.homeMasterChatButton),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _StatPill({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.w8,
        vertical: AppSizes.h8,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.45,
        ),
        borderRadius: AppSizes.borderRadius12,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: iconColor),
          AppSizes.gW8,
          Text(
            '$value · $label',
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
