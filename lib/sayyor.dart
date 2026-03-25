import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sayyor/core/storage/localstorage.dart';
import 'package:sayyor/core/themes/app_themes.dart';
import 'package:sayyor/features/others/screen/splash.dart';
import 'package:sayyor/features/profile/presentation/bloc/theme/state.dart';

import 'core/di/service_locator.dart';

class SayyorApp extends StatefulWidget {
  const SayyorApp({super.key});

  @override
  State<SayyorApp> createState() => _SayyorAppState();
}

class _SayyorAppState extends State<SayyorApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(sl<LocalStorage>()),
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, child) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode: themeMode,
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
