import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sayyor/core/storage/onboarding_storage.dart';
import 'package:sayyor/core/storage/token_storage.dart';
import 'package:sayyor/features/authentification/presentation/screen/auth_success_screen.dart';
import 'package:sayyor/features/authentification/presentation/screen/login_screen.dart';
import 'package:sayyor/features/authentification/presentation/screen/onboarding_screen.dart';
import 'package:sayyor/features/authentification/presentation/screen/otp_screen.dart';
import 'package:sayyor/features/authentification/presentation/screen/register_screen.dart';
import 'package:sayyor/features/authentification/presentation/screen/splash_screen.dart';
import 'package:sayyor/features/home/presentation/screen/home_screen.dart';

sealed class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String authSuccess = '/auth-success';
  static const String home = '/home';
}

class AppRouter {
  AppRouter._();
  
  static Future<String?> _redirect(
    BuildContext context,
    GoRouterState state,
    TokenStorage tokenStorage,
  ) async {
    final String currentPath = state.matchedLocation;
    final String? token = await tokenStorage.getAccessToken();
    final bool isLoggedIn = token != null && token.isNotEmpty;
    final bool isOnboarded = await OnboardingStorage().isOnboarded();
    if (currentPath == AppRoutes.splash) {
      return null; 
    }
    if (isLoggedIn) {
      if (currentPath == AppRoutes.onboarding ||
          currentPath == AppRoutes.login ||
          currentPath == AppRoutes.register) {
        return AppRoutes.home; 
      }
      
      return null;
    }
    
    else {
      
      if (currentPath == AppRoutes.home) {
        
        if (isOnboarded) {
          return AppRoutes.login; 
        } else {
          
          return AppRoutes.onboarding; 
        }
      }
      
      return null;
    }
  }

  static GoRouter createRouter(TokenStorage tokenStorage) {
    return GoRouter(
      initialLocation: AppRoutes.splash,

      
      redirect: (context, state) => _redirect(context, state, tokenStorage),

      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AppRoutes.onboarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: AppRoutes.login,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: AppRoutes.register,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: AppRoutes.otp,
          builder: (context, state) {
            final args = state.extra as OtpArgs;
            return OtpScreen(args: args);
          },
        ),
        GoRoute(
          path: AppRoutes.authSuccess,
          builder: (context, state) {
            final args = state.extra as AuthSuccessArgs;
            return AuthSuccessScreen(args: args);
          },
        ),
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(child: Text(state.error?.toString() ?? 'Unknown error')),
      ),
    );
  }
}
