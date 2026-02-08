import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sayyor/core/routes/app_router.dart';
import 'package:sayyor/core/storage/onboarding_storage.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/themes/app_textstyles.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late OnboardingStorage _onboardingStorage;

  @override
  void initState() {
    super.initState();
    
    _onboardingStorage = OnboardingStorage();
  }

  
  
  
  Future<void> _startApp() async {
    
    await _onboardingStorage.setOnboarded(true);

    
    if (mounted) {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.search,
                  size: AppSizes.iconLg,
                  color: colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: AppSizes.lg),
              Text(
                'onboarding_title'.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.h1.copyWith(color: colorScheme.onSurface),
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                'onboarding_subtitle'.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: AppSizes.buttonHeight,
                child: FilledButton(
                  
                  onPressed: _startApp,
                  child: Text(
                    'start'.tr(),
                    style: AppTextStyles.body.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
