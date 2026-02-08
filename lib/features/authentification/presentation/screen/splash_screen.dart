import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sayyor/core/routes/app_router.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/themes/app_textstyles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.go(AppRoutes.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.handyman_rounded,
                  size: AppSizes.iconXl,
                  color: colorScheme.onPrimary,
                ),
                const SizedBox(height: AppSizes.md),
                Text(
                  'splash_title'.tr(),
                  style: AppTextStyles.hero.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: AppSizes.sm),
                Text(
                  'splash_subtitle'.tr(),
                  style: AppTextStyles.body.copyWith(
                    color: colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
