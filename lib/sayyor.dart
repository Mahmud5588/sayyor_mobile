import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sayyor/core/di/service_locator.dart' as di;
import 'package:sayyor/core/routes/app_router.dart';
import 'package:sayyor/core/storage/token_storage.dart';
import 'package:sayyor/core/themes/app_textstyles.dart';

class SayyorApp extends StatefulWidget {
  const SayyorApp({super.key});

  @override
  State<SayyorApp> createState() => _SayyorAppState();
}

class _SayyorAppState extends State<SayyorApp> {
  @override
  Widget build(BuildContext context) {
    final tokenStorage = di.sl<TokenStorage>();
    final router = AppRouter.createRouter(tokenStorage);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepOrange,
      brightness: Brightness.light,
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: ThemeData(
        colorScheme: colorScheme,
        textTheme: AppTextStyles.textTheme(colorScheme),
      ),
    );
  }
}
