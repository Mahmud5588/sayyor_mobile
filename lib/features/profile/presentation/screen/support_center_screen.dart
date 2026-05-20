import 'package:flutter/material.dart';
import 'package:sayyor/core/l10n/app_localizations.dart';
import 'package:sayyor/core/themes/app_sizes.dart';

class SupportCenterScreen extends StatelessWidget {
  const SupportCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.profileSupportTitle,
          style: theme.textTheme.headlineSmall,
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: AppSizes.padding16,
        children: [
          Container(
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
                  'Sizga yordam beramiz',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppSizes.gH8,
                Text(
                  '24/7 qo\'llab-quvvatlash xizmati orqali murojaatingizni yuboring.',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          AppSizes.gH12,
          _SupportItem(
            icon: Icons.chat_bubble_outline_rounded,
            title: 'Onlayn chat',
            subtitle: 'Operator bilan yozishma boshlash',
          ),
          AppSizes.gH12,
          _SupportItem(
            icon: Icons.call_outlined,
            title: '+998 71 200 00 00',
            subtitle: 'Qo\'ng\'iroq orqali bog\'lanish',
          ),
          AppSizes.gH12,
          _SupportItem(
            icon: Icons.email_outlined,
            title: 'support@sayyor.uz',
            subtitle: 'Email orqali murojaat yuborish',
          ),
        ],
      ),
    );
  }
}

class _SupportItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SupportItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: AppSizes.borderRadius16),
      tileColor: theme.colorScheme.surface,
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Icon(icon, color: theme.colorScheme.onPrimaryContainer),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () {},
    );
  }
}
