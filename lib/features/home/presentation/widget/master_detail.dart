import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_sizes.dart';

class PortfolioItem {
  final String imageUrl;
  final String description;

  PortfolioItem({required this.imageUrl, required this.description});
}

class MasterDetailModel {
  final String id;
  final String name;
  final String avatarUrl;
  final String profession;
  final int age;
  final int experienceYears; // Tajriba
  final double rating;
  final int completedJobs; // Bajarilgan ishlar soni
  final String location;
  final String priceRange;
  final String about; // O'zi haqida
  final List<PortfolioItem> portfolio; // Qilingan ishlar

  MasterDetailModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.profession,
    required this.age,
    required this.experienceYears,
    required this.rating,
    required this.completedJobs,
    required this.location,
    required this.priceRange,
    required this.about,
    required this.portfolio,
  });
}


class MasterDetailScreen extends StatelessWidget {
  final MasterDetailModel master;

  const MasterDetailScreen({super.key, required this.master});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      // Orqaga qaytish va ulashish (Share) tugmalari bilan AppBar
      appBar: AppBar(
        title: Text("Usta profili", style: theme.textTheme.titleLarge),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {}, // Ulashish funksiyasi
            icon: Icon(Icons.share_outlined, color: theme.colorScheme.primary),
          ),
          IconButton(
            onPressed: () {}, // Saqlanganlarga (Yoqtirganlarga) qo'shish
            icon: Icon(Icons.favorite_border_rounded, color: theme.colorScheme.primary),
          ),
        ],
      ),

      // Asosiy qism va eng pastda "Xabar yozish" tugmasi
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: AppSizes.padding16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. TEPADAGI ASOSIY MA'LUMOT (Avatar, Ism, Kasb, Yosh, Tajriba)
                  _buildHeaderSection(theme),
                  AppSizes.gH24,

                  // 2. STATISTIKA (Reyting, Buyurtmalar)
                  _buildStatsRow(theme),
                  AppSizes.gH24,

                  // 3. O'ZI HAQIDA VA NARX
                  _buildAboutAndPriceSection(theme),
                  AppSizes.gH24,

                  // 4. QILINGAN ISHLAR (PORTFEL) - Ketma-ket rasm va matn
                  Text("Bajarilgan ishlar", style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                  AppSizes.gH12,
                  _buildPortfolioSection(theme),
                ],
              ),
            ),
          ),

          // 5. PASTKI QAT'IY (FIXED) TUGMA - Doim ko'rinib turadi
          _buildBottomActionButton(context, theme),
        ],
      ),
    );
  }

  // --- WIDGET QURUVCHILAR ---

  // 1. Asosiy Header (Rasm va Ism)
  Widget _buildHeaderSection(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        ClipRRect(
          borderRadius: AppSizes.borderRadius16,
          child: Image.network(
            master.avatarUrl,
            width: 100.w,
            height: 100.w,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(
              width: 100.w,
              height: 100.w,
              color: theme.colorScheme.surfaceVariant,
              child: Icon(Icons.person, size: 40.sp, color: theme.colorScheme.outline),
            ),
          ),
        ),
        AppSizes.gW16,

        // Ma'lumotlar
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                master.name,
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              AppSizes.gH4,
              Text(
                master.profession,
                style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary),
              ),
              AppSizes.gH8,

              // Yosh va Tajriba chiplari
              Row(
                children: [
                  _buildSmallChip(theme, Icons.cake_outlined, "${master.age} yosh"),
                  AppSizes.gW8,
                  _buildSmallChip(theme, Icons.work_history_outlined, "${master.experienceYears} yil tajriba"),
                ],
              ),
              AppSizes.gH8,

              // Lokatsiya
              Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 16.sp, color: theme.colorScheme.outline),
                  AppSizes.gW4,
                  Expanded(
                    child: Text(
                      master.location,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
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
    );
  }

  // Kichik ma'lumot chiplari (Yosh, Tajriba)
  Widget _buildSmallChip(ThemeData theme, IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.w8, vertical: AppSizes.h4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant?.withOpacity(0.5),
        borderRadius: AppSizes.borderRadius8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: theme.colorScheme.onSurfaceVariant),
          AppSizes.gW4,
          Text(text, style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  // 2. Statistika (Reyting, Buyurtmalar soni)
  Widget _buildStatsRow(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(theme, Icons.star_rounded, Colors.amber, master.rating.toString(), "Reyting"),
        ),
        AppSizes.gW12,
        Expanded(
          child: _buildStatCard(theme, Icons.task_alt_rounded, theme.colorScheme.primary, master.completedJobs.toString(), "Bajarilgan ishlar"),
        ),
      ],
    );
  }

  Widget _buildStatCard(ThemeData theme, IconData icon, Color iconColor, String value, String label) {
    return Container(
      padding: AppSizes.padding12,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: AppSizes.borderAll(color: theme.colorScheme.outline.withOpacity(0.2)),
        borderRadius: AppSizes.borderRadius16,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 20.sp),
              AppSizes.gW4,
              Text(value, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          AppSizes.gH4,
          Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline)),
        ],
      ),
    );
  }

  // 3. O'zi haqida va Narx oralig'i
  Widget _buildAboutAndPriceSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Narx bloki
        Container(
          width: double.infinity,
          padding: AppSizes.padding16,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withOpacity(0.3),
            borderRadius: AppSizes.borderRadius12,
          ),
          child: Row(
            children: [
              Icon(Icons.payments_outlined, color: theme.colorScheme.primary, size: 24.sp),
              AppSizes.gW12,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Xizmat narxi (Taxminiy)", style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onPrimaryContainer)),
                  Text(
                    master.priceRange,
                    style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        AppSizes.gH16,

        // O'zi haqida
        Text("Mutaxassis haqida", style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        AppSizes.gH8,
        Text(
          master.about,
          style: theme.textTheme.bodyMedium?.copyWith(height: 1.5, color: theme.colorScheme.onSurface.withOpacity(0.8)),
        ),
      ],
    );
  }

  // 4. Portfel (Qilingan ishlar ro'yxati)
  Widget _buildPortfolioSection(ThemeData theme) {
    if (master.portfolio.isEmpty) {
      return Text("Hozircha portfelga ishlar joylanmagan.", style: theme.textTheme.bodyMedium);
    }

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(), // Tashqi scroll ishlashi uchun buni o'chirib qo'yamiz
      shrinkWrap: true, // Ro'yxat o'ziga kerakli joyni olishi uchun
      itemCount: master.portfolio.length,
      separatorBuilder: (context, index) => AppSizes.gH16,
      itemBuilder: (context, index) {
        final item = master.portfolio[index];
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: AppSizes.borderRadius16,
            border: AppSizes.borderAll(color: theme.colorScheme.outline.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.03),
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rasm qismi
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: Image.network(
                  item.imageUrl,
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              ),
              // Ta'rif qismi
              Padding(
                padding: AppSizes.padding16,
                child: Text(
                  item.description,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 5. Pastki "Chat" tugmasi
  Widget _buildBottomActionButton(BuildContext context, ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(AppSizes.w16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10.r,
            offset: Offset(0, -4.h), // Tepaga qarab soya
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: ChatDetailScreen ga o'tish
            },
            icon: Icon(Icons.chat_bubble_outline, size: 24.sp),
            label: const Text("Xabar yozish"),
          ),
        ),
      ),
    );
  }
}