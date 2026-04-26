import 'package:flutter/material.dart';
import 'package:sayyor/core/l10n/app_localizations.dart';

class AppAsyncStateView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String actionLabel;
  final VoidCallback? onAction;
  final bool showProgress;

  const AppAsyncStateView({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel = '',
    this.onAction,
    this.showProgress = false,
  });

  factory AppAsyncStateView.loading(AppLocalizations l10n) {
    return AppAsyncStateView(
      icon: Icons.hourglass_empty_rounded,
      title: l10n.stateLoadingTitle,
      subtitle: l10n.stateLoadingSubtitle,
      showProgress: true,
    );
  }

  factory AppAsyncStateView.empty({
    required AppLocalizations l10n,
    required String subtitle,
  }) {
    return AppAsyncStateView(
      icon: Icons.inbox_outlined,
      title: l10n.stateEmptyTitle,
      subtitle: subtitle,
    );
  }

  factory AppAsyncStateView.error({
    required AppLocalizations l10n,
    required String subtitle,
    required VoidCallback onRetry,
  }) {
    return AppAsyncStateView(
      icon: Icons.error_outline_rounded,
      title: l10n.errorTitle,
      subtitle: subtitle,
      actionLabel: l10n.retryButton,
      onAction: onRetry,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.18),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.06),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Icon(icon, color: theme.colorScheme.primary, size: 30),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
                if (showProgress) ...[
                  const SizedBox(height: 20),
                  const SizedBox(
                    height: 28,
                    width: 28,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  ),
                ],
                if (onAction != null) ...[
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: onAction,
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text(actionLabel),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
