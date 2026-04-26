import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayyor/core/l10n/app_localizations.dart';
import 'package:sayyor/core/storage/localstorage.dart';
import 'package:sayyor/core/themes/app_themes.dart';
import 'package:sayyor/features/profile/presentation/bloc/locale/state.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit(sl<LocalStorage>())),
        BlocProvider(create: (context) => LocaleCubit(sl<LocalStorage>())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (builderContext, child) {
          final themeMode = builderContext.watch<ThemeCubit>().state;
          final locale = builderContext.watch<LocaleCubit>().state;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: themeMode,
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
