import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayyor/core/l10n/app_localizations.dart';
import 'package:sayyor/core/themes/app_sizes.dart';

class JobRequestDetailScreen extends StatelessWidget {
  final String userName;
  final String userAvatar;
  final String title;
  final String description;
  final String priceRange;
  final List<String> images;

  const JobRequestDetailScreen({
    super.key,
    required this.userName,
    required this.userAvatar,
    required this.title,
    required this.description,
    required this.priceRange,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.homeRequestDetailTitle)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: AppSizes.padding16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24.r,
                        backgroundImage: NetworkImage(userAvatar),
                      ),
                      AppSizes.gW12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              l10n.homeRequestCustomerLabel,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppSizes.gH16,
                  Text(
                    title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSizes.gH8,
                  Container(
                    padding: AppSizes.padding12,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer.withValues(
                        alpha: 0.35,
                      ),
                      borderRadius: AppSizes.borderRadius12,
                    ),
                    child: Text(
                      priceRange,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  AppSizes.gH16,
                  Text(
                    description,
                    style: theme.textTheme.bodyLarge?.copyWith(height: 1.45),
                  ),
                  AppSizes.gH20,
                  if (images.isNotEmpty) ...[
                    Text(
                      l10n.homeRequestImagesTitle,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSizes.gH12,
                    SizedBox(
                      height: 130.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        separatorBuilder: (_, __) => AppSizes.gW12,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: AppSizes.borderRadius12,
                            child: Image.network(
                              images[index],
                              width: 170.w,
                              height: 130.h,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Container(
            padding: AppSizes.padding16,
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showBidBottomSheet(context, theme);
                  },
                  icon: Icon(Icons.local_offer_outlined, size: 20.sp),
                  label: Text(l10n.homeRequestBidButton),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBidBottomSheet(BuildContext context, ThemeData theme) {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: AppSizes.w16,
            right: AppSizes.w16,
            top: AppSizes.h20,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppSizes.h20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.homeRequestBidSheetTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSizes.gH12,
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: l10n.homeRequestBidPriceHint,
                  prefixIcon: Icon(Icons.payments_outlined, size: 20.sp),
                  border: OutlineInputBorder(
                    borderRadius: AppSizes.borderRadius12,
                  ),
                ),
              ),
              AppSizes.gH12,
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: l10n.homeRequestBidCommentHint,
                  border: OutlineInputBorder(
                    borderRadius: AppSizes.borderRadius12,
                  ),
                ),
              ),
              AppSizes.gH16,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(l10n.homeRequestBidSend),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
