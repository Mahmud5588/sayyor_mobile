import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayyor/core/di/service_locator.dart';
import 'package:sayyor/core/l10n/app_localizations.dart';
import 'package:sayyor/core/themes/app_colors.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/widgets/app_async_state_view.dart';
import 'package:sayyor/features/chat/presentation/screen/chat_detail_screen.dart';
import 'package:sayyor/features/profile/data/my_orders_mock_repository.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  late Future<MyOrdersFeedData> _ordersFuture;
  String? _loadedLocaleKey;

  final MyOrdersMockRepository _repository = sl<MyOrdersMockRepository>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final localeKey = Localizations.localeOf(context).toLanguageTag();
    if (_loadedLocaleKey != localeKey) {
      _loadedLocaleKey = localeKey;
      _ordersFuture = _repository.loadOrders(AppLocalizations.of(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.profileOrdersTitle,
          style: theme.textTheme.headlineSmall,
        ),
        centerTitle: false,
      ),
      body: FutureBuilder<MyOrdersFeedData>(
        future: _ordersFuture,
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

          final data = snapshot.data;
          if (data == null) {
            return AppAsyncStateView.empty(
              l10n: l10n,
              subtitle: l10n.myOrdersEmptySubtitle,
            );
          }

          if (data.activeOrders.isEmpty && data.completedOrders.isEmpty) {
            return AppAsyncStateView.empty(
              l10n: l10n,
              subtitle: l10n.myOrdersEmptySubtitle,
            );
          }

          return ListView(
            padding: AppSizes.padding16,
            children: [
              if (data.activeOrders.isNotEmpty) ...[
                _buildSectionHeader(theme, l10n.myOrdersActiveSection),
                AppSizes.gH12,
                ...data.activeOrders.map(
                  (order) => Padding(
                    padding: EdgeInsets.only(bottom: AppSizes.h16),
                    child: _MyOrderCard(
                      order: order,
                      l10n: l10n,
                      onChatTap: () => _openChat(order),
                      onReviewTap: () => _editReview(order),
                    ),
                  ),
                ),
                AppSizes.gH8,
              ],
              if (data.completedOrders.isNotEmpty) ...[
                _buildSectionHeader(theme, l10n.myOrdersCompletedSection),
                AppSizes.gH12,
                ...data.completedOrders.map(
                  (order) => Padding(
                    padding: EdgeInsets.only(bottom: AppSizes.h16),
                    child: _MyOrderCard(
                      order: order,
                      l10n: l10n,
                      onChatTap: () => _openChat(order),
                      onReviewTap: () => _editReview(order),
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  void _openChat(MyOrderData order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatDetailScreen(
          masterName: order.masterName,
          imageUrl: order.masterAvatarUrl,
          isNewChat: false,
        ),
      ),
    );
  }

  void _editReview(MyOrderData order) async {
    final result = await showModalBottomSheet<_ReviewDraft>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return _ReviewEditorSheet(
          l10n: AppLocalizations.of(sheetContext),
          initialRating: order.review?.rating ?? 5,
          initialText: order.review?.text ?? '',
        );
      },
    );

    if (!mounted || result == null) {
      return;
    }

    setState(() {
      final current = _ordersFuture;
      _ordersFuture = current.then((feed) {
        final updatedCompleted = feed.completedOrders.map((item) {
          if (item.id != order.id) {
            return item;
          }
          return item.copyWith(
            review: MyOrderReviewData(rating: result.rating, text: result.text),
          );
        }).toList();

        final updatedActive = feed.activeOrders.map((item) {
          if (item.id != order.id) {
            return item;
          }
          return item.copyWith(
            review: MyOrderReviewData(rating: result.rating, text: result.text),
          );
        }).toList();

        return MyOrdersFeedData(
          activeOrders: updatedActive,
          completedOrders: updatedCompleted,
        );
      });
    });
  }
}

class _MyOrderCard extends StatelessWidget {
  final MyOrderData order;
  final AppLocalizations l10n;
  final VoidCallback onChatTap;
  final VoidCallback onReviewTap;

  const _MyOrderCard({
    required this.order,
    required this.l10n,
    required this.onChatTap,
    required this.onReviewTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final review = order.review;

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
                radius: 24.r,
                backgroundImage: NetworkImage(order.masterAvatarUrl),
              ),
              AppSizes.gW12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            order.masterName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (order.isMine)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.w8,
                              vertical: AppSizes.h4,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: AppSizes.borderRadius12,
                            ),
                            child: Text(
                              l10n.myOrdersYourOrder,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                      ],
                    ),
                    AppSizes.gH4,
                    Text(
                      '${l10n.myOrdersServiceLabel}: ${order.serviceTitle}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    AppSizes.gH4,
                    Text(
                      '${l10n.myOrdersLocationLabel}: ${order.location}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onChatTap,
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: theme.colorScheme.primary,
                ),
                tooltip: l10n.myOrdersChatLabel,
              ),
            ],
          ),
          AppSizes.gH12,
          Row(
            children: [
              Expanded(
                child: _InfoPill(
                  label: l10n.myOrdersMasterLabel,
                  value: order.masterName,
                ),
              ),
              AppSizes.gW8,
              Expanded(
                child: _InfoPill(
                  label: l10n.myOrdersPriceLabel,
                  value: order.price,
                ),
              ),
            ],
          ),
          AppSizes.gH12,
          Row(
            children: [
              Icon(
                order.isCompleted
                    ? Icons.check_circle_rounded
                    : Icons.schedule_rounded,
                color: order.isCompleted
                    ? AppColors.kSuccess
                    : theme.colorScheme.primary,
                size: 18.sp,
              ),
              AppSizes.gW8,
              Text(
                order.isCompleted
                    ? l10n.myOrdersStatusCompleted
                    : l10n.myOrdersStatusInProgress,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Text(
                '${l10n.myOrdersDateLabel}: ${order.completedOn}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
          AppSizes.gH16,
          Container(
            width: double.infinity,
            padding: AppSizes.padding12,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.45,
              ),
              borderRadius: AppSizes.borderRadius16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      l10n.myOrdersReviewTitle,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: onReviewTap,
                      icon: Icon(
                        review == null
                            ? Icons.rate_review_outlined
                            : Icons.edit_outlined,
                        size: 18.sp,
                      ),
                      label: Text(
                        review == null
                            ? l10n.myOrdersReviewWrite
                            : l10n.myOrdersReviewEdit,
                      ),
                    ),
                  ],
                ),
                if (review != null) ...[
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < review.rating.round()
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        color: Colors.amber,
                        size: 18.sp,
                      ),
                    ),
                  ),
                  AppSizes.gH8,
                  Text(
                    review.text,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
                  ),
                ] else ...[
                  Text(
                    l10n.myOrdersNoReviewText,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final String label;
  final String value;

  const _InfoPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: AppSizes.padding12,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.4),
        borderRadius: AppSizes.borderRadius16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          AppSizes.gH4,
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewDraft {
  final double rating;
  final String text;

  const _ReviewDraft({required this.rating, required this.text});
}

class _ReviewEditorSheet extends StatefulWidget {
  final AppLocalizations l10n;
  final double initialRating;
  final String initialText;

  const _ReviewEditorSheet({
    required this.l10n,
    required this.initialRating,
    required this.initialText,
  });

  @override
  State<_ReviewEditorSheet> createState() => _ReviewEditorSheetState();
}

class _ReviewEditorSheetState extends State<_ReviewEditorSheet> {
  late double _rating;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: AppSizes.w16,
        right: AppSizes.w16,
        top: AppSizes.h8,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSizes.h16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.l10n.myOrdersReviewEdit,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          AppSizes.gH12,
          Row(
            children: List.generate(5, (index) {
              final active = index < _rating.round();
              return IconButton(
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                  });
                },
                icon: Icon(
                  active ? Icons.star_rounded : Icons.star_border_rounded,
                  color: Colors.amber,
                ),
              );
            }),
          ),
          AppSizes.gH8,
          TextField(
            controller: _controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: widget.l10n.myOrdersReviewPlaceholder,
              border: OutlineInputBorder(borderRadius: AppSizes.borderRadius16),
            ),
          ),
          AppSizes.gH16,
          Row(
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(widget.l10n.myOrdersCancel),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    _ReviewDraft(
                      rating: _rating,
                      text: _controller.text.trim(),
                    ),
                  );
                },
                child: Text(widget.l10n.myOrdersSaveReview),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
