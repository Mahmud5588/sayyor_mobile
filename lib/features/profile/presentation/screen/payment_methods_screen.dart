import 'package:flutter/material.dart';
import 'package:sayyor/core/l10n/app_localizations.dart';
import 'package:sayyor/core/themes/app_sizes.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.profilePaymentMethodsTitle,
          style: theme.textTheme.headlineSmall,
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: AppSizes.padding16,
        children: [
          _PaymentCard(
            icon: Icons.credit_card_rounded,
            title: 'UzCard •••• 4421',
            subtitle: 'Asosiy karta',
            trailing: const _DefaultBadge(),
          ),
          AppSizes.gH12,
          _PaymentCard(
            icon: Icons.account_balance_wallet_rounded,
            title: 'Humo •••• 9012',
            subtitle: 'Onlayn to\'lovlar uchun',
          ),
          AppSizes.gH12,
          _PaymentCard(
            icon: Icons.payments_outlined,
            title: 'Naqd to\'lov',
            subtitle: 'Buyurtma yakunlangach to\'lash',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add_rounded),
        label: const Text('Karta qo\'shish'),
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;

  const _PaymentCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: AppSizes.padding16,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: AppSizes.borderRadius16,
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.16),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Icon(icon, color: theme.colorScheme.onPrimaryContainer),
          ),
          AppSizes.gW12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppSizes.gH4,
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          trailing ??
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.outline,
              ),
        ],
      ),
    );
  }
}

class _DefaultBadge extends StatelessWidget {
  const _DefaultBadge();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: AppSizes.padding8,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: AppSizes.borderRadius12,
      ),
      child: Text(
        'Asosiy',
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
