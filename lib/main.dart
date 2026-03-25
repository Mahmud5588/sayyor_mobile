import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sayyor/core/di/service_locator.dart' as di;
import 'package:sayyor/features/authentification/presentation/bloc/auth_bloc.dart';
import 'package:sayyor/sayyor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await MobileAds.instance.initialize();
  await di.init();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('uz'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('uz'),
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => di.sl<AuthBloc>())],
        child: const SayyorApp(),
      ),
    ),
  );
}
