import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sayyor/core/themes/app_sizes.dart';
import 'package:sayyor/core/themes/app_textstyles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home'.tr())),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('welcome'.tr(), style: AppTextStyles.h1),
              const SizedBox(height: AppSizes.md),
              Text('home_subtitle'.tr(), style: AppTextStyles.body),
              const SizedBox(height: AppSizes.xl),
              // TODO: Home page content
              const Expanded(
                child: Center(child: Text('🏠 Home Page - Coming Soon')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
