import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sayyor/core/routes/app_router.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/themes/app_textstyles.dart';

class AuthSuccessArgs {
  final String name;
  final String role;

  const AuthSuccessArgs({required this.name, required this.role});
}

class AuthSuccessScreen extends StatelessWidget {
  final AuthSuccessArgs args;

  const AuthSuccessScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const Icon(
                Icons.check_circle,
                size: AppSizes.iconXl,
                color: Colors.green,
              ),
              const SizedBox(height: AppSizes.lg),
              Text('auth_success_title'.tr(), style: AppTextStyles.h1),
              const SizedBox(height: AppSizes.sm),
              Text(
                'auth_success_subtitle'.tr(args: [args.name, args.role]),
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySm,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: AppSizes.buttonHeight,
                child: FilledButton(
                  onPressed: () => context.go(AppRoutes.home),
                  child: Text('continue'.tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
