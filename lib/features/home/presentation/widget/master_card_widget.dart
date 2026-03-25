import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayyor/core/themes/app_sizes.dart';

class MasterCardWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String profession;
  final String location;
  final double rating;
  final int reviewsCount;
  final String priceRange;
  final bool isBusy;
  final VoidCallback? onTap;
  final VoidCallback? onChatTap;

  const MasterCardWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.profession,
    required this.location,
    required this.rating,
    required this.reviewsCount,
    required this.priceRange,
    required this.isBusy,
    this.onTap,
    this.onChatTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: AppSizes.borderRadius16,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppSizes.w16,
          vertical: AppSizes.h8,
        ),
        padding: AppSizes.padding12,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: AppSizes.borderRadius16,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.05),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
          border: AppSizes.borderAll(
            color: theme.colorScheme.outline.withOpacity(0.3),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: AppSizes.borderRadius12,
              child: Image.network(
                imageUrl,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80.w,
                  height: 80.h,
                  color: theme.colorScheme.surfaceVariant,
                  child: Icon(
                    Icons.person,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 32.sp,
                  ),
                ),
              ),
            ),
            AppSizes.gW16,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      IconButton(
                        onPressed: onChatTap,
                        icon: Icon(
                          Icons.chat_bubble_outline,
                          color: theme.colorScheme.primary,
                          size: 22.sp,
                        ),
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.w8,
                      vertical: AppSizes.h4,
                    ),
                    decoration: BoxDecoration(
                      color: isBusy
                          ? Colors.red.withOpacity(0.12)
                          : Colors.green.withOpacity(0.14),
                      borderRadius: AppSizes.borderRadius8,
                    ),
                    child: Text(
                      isBusy ? "Band" : "Band emas",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isBusy ? Colors.red : Colors.green,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  AppSizes.gH4,

                  Text(
                    profession,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  AppSizes.gH4,

                  Row(
                    children: [
                      Icon(
                        Icons.payments_outlined,
                        color: theme.colorScheme.primary,
                        size: 16.sp,
                      ),
                      AppSizes.gW4,
                      Text(
                        priceRange,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  AppSizes.gH8,

                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 18.sp,
                      ),
                      AppSizes.gW4,
                      Text(
                        "$rating ($reviewsCount)",
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSizes.gW12,
                      Icon(
                        Icons.location_on,
                        color: theme.colorScheme.outline,
                        size: 14.sp,
                      ),
                      AppSizes.gW4,
                      Expanded(
                        child: Text(
                          location,
                          style: theme.textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
