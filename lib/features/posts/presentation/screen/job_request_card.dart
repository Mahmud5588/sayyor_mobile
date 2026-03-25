import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/themes/app_colors.dart';

class JobRequestCard extends StatelessWidget {
  final String userName;
  final String userAvatar;
  final String title;
  final String description;
  final String priceRange;
  final String timeAgo;
  final List<String> images; // Muammo rasmlari
  final VoidCallback? onTap;
  final VoidCallback? onBidTap;

  const JobRequestCard({
    super.key,
    required this.userName,
    required this.userAvatar,
    required this.title,
    required this.description,
    required this.priceRange,
    required this.timeAgo,
    required this.images,
    this.onTap,
    this.onBidTap,
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
        padding: AppSizes.padding16,
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
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. MIJOZ MA'LUMOTLARI VA VAQT
            Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundImage: NetworkImage(userAvatar),
                ),
                AppSizes.gW12,
                Expanded(
                  child: Text(
                    userName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  timeAgo,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
            AppSizes.gH12,
            _buildDivider(theme),
            AppSizes.gH12,

            // 2. MUAMMO SARLAVHASI VA TAVSIFI
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSizes.gH8,
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.8),
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            AppSizes.gH16,

            // 3. RASMLAR GALEREYASI (Agar rasm bo'lsa)
            if (images.isNotEmpty) ...[
              SizedBox(
                height: 70.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  separatorBuilder: (context, index) => AppSizes.gW8,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: AppSizes.borderRadius8,
                      child: Image.network(
                        images[index],
                        width: 70.h,
                        height: 70.h,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              AppSizes.gH16,
            ],

            // 4. NARX VA TAKLIF TUGMASI
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Narx
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.w12,
                      vertical: AppSizes.h8,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer.withOpacity(
                        0.5,
                      ),
                      borderRadius: AppSizes.borderRadius8,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.payments_outlined,
                          color: theme.colorScheme.primary,
                          size: 18.sp,
                        ),
                        AppSizes.gW8,
                        Expanded(
                          child: Text(
                            priceRange,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Taklif yuborish tugmasi
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onBidTap,
                    icon: Icon(Icons.local_offer_outlined, size: 18.sp),
                    label: const Text("Taklif yuborish"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(0, 40.h), // Tugma balandligi
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.w8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(ThemeData theme) {
    return Divider(
      height: 1,
      thickness: 1,
      color: theme.colorScheme.outline.withOpacity(0.1),
    );
  }
}
