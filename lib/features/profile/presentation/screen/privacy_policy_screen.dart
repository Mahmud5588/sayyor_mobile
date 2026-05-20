import 'package:flutter/material.dart';
import 'package:sayyor/core/l10n/app_localizations.dart';
import 'package:sayyor/core/themes/app_sizes.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.profilePrivacyTitle,
          style: theme.textTheme.headlineSmall,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: AppSizes.padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PolicyBlock(
              title: '1. Ma\'lumotlarni yig\'ish',
              body:
                  'Ro\'yxatdan o\'tishda telefon raqam, ism va profil ma\'lumotlari saqlanadi. Bu ma\'lumotlar xizmat ko\'rsatishni tashkil etish uchun ishlatiladi.',
            ),
            AppSizes.gH12,
            _PolicyBlock(
              title: '2. Ma\'lumotlardan foydalanish',
              body:
                  'Buyurtmalarni boshqarish, mijoz va usta o\'rtasidagi aloqani tashkil qilish hamda to\'lovlarni xavfsiz yuritish uchun foydalaniladi.',
            ),
            AppSizes.gH12,
            _PolicyBlock(
              title: '3. Uchinchi tomon xizmatlari',
              body:
                  'Xabarnomalar, geolokatsiya va to\'lov integratsiyalari uchun ishonchli xizmatlardan foydalaniladi. Faqat zarur ma\'lumotlar uzatiladi.',
            ),
            AppSizes.gH12,
            _PolicyBlock(
              title: '4. Foydalanuvchi huquqlari',
              body:
                  'Profil ma\'lumotlarini yangilash, noto\'g\'ri ma\'lumotlarni tuzatish va qo\'llab-quvvatlashga murojaat yuborish huquqiga egasiz.',
            ),
          ],
        ),
      ),
    );
  }
}

class _PolicyBlock extends StatelessWidget {
  final String title;
  final String body;

  const _PolicyBlock({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: AppSizes.padding16,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppSizes.borderRadius16,
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          AppSizes.gH8,
          Text(body, style: theme.textTheme.bodyMedium?.copyWith(height: 1.45)),
        ],
      ),
    );
  }
}
