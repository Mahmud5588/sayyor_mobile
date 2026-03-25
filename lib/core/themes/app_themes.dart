import 'package:flutter/material.dart';
import 'package:sayyor/core/themes/app_colors.dart';
import 'package:sayyor/core/themes/app_textstyles.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.kPrimaryColor, // Apelsin
      onPrimary: AppColors.kWhite, // Oq
      primaryContainer: AppColors.kPrimaryContainer,
      onPrimaryContainer: AppColors.kPrimaryDark,
      secondary: AppColors.kSecondaryColor,
      onSecondary: AppColors.kWhite,
      surface: AppColors.kWhite,
      onSurface: AppColors.kGray900,
      error: AppColors.kError,
      onError: AppColors.kWhite,
      outline: AppColors.kGray300,
    ),

    // Elevated Buttonlar uchun maxsus mavzu
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        // Orqa fon rangini apelsin qilish (M3)
        backgroundColor: WidgetStateProperty.all(AppColors.kPrimaryColor),
        // Matn va belgi rangini oq qilish (M3)
        foregroundColor: WidgetStateProperty.all(AppColors.kWhite),
        // Matn uslubini o'rnatish
        textStyle: WidgetStateProperty.all(AppTextStyles.labelLarge),
        // Burchaklarni bir oz yumshatish
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    ),

    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.kGray900),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: AppColors.kGray900),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: AppColors.kGray900),

      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: AppColors.kGray900),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: AppColors.kGray900),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: AppColors.kGray900),

      titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.kGray900),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: AppColors.kGray900),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: AppColors.kGray900),

      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.kGray900),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.kGray600),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.kGray600),

      labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.kGray900),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: AppColors.kGray600),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.kGray600),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.kPrimaryColor, // Apelsin
      onPrimary: AppColors.kWhite, // Oq
      secondary: AppColors.kPrimaryLight,
      onSecondary: AppColors.kGray900,
      surface: AppColors.kDarkSurface,
      onSurface: AppColors.kWhite,
      error: AppColors.kError,
      onError: AppColors.kWhite,
      outline: AppColors.kGray600,
    ),

    // Elevated Buttonlar uchun maxsus mavzu
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        // Orqa fon rangini apelsin qilish (M3)
        backgroundColor: WidgetStateProperty.all(AppColors.kPrimaryColor),
        // Matn va belgi rangini oq qilish (M3)
        foregroundColor: WidgetStateProperty.all(AppColors.kWhite),
        // Matn uslubini o'rnatish
        textStyle: WidgetStateProperty.all(AppTextStyles.labelLarge),
        // Burchaklarni bir oz yumshatish
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    ),

    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: AppColors.kWhite),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: AppColors.kWhite),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: AppColors.kWhite),

      headlineLarge: AppTextStyles.headlineLarge.copyWith(color: AppColors.kWhite),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(color: AppColors.kWhite),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(color: AppColors.kWhite),

      titleLarge: AppTextStyles.titleLarge.copyWith(color: AppColors.kWhite),
      titleMedium: AppTextStyles.titleMedium.copyWith(color: AppColors.kWhite),
      titleSmall: AppTextStyles.titleSmall.copyWith(color: AppColors.kWhite),

      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: AppColors.kWhite),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: AppColors.kGray300),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: AppColors.kGray300),

      labelLarge: AppTextStyles.labelLarge.copyWith(color: AppColors.kWhite),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: AppColors.kGray300),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: AppColors.kGray300),
    ),
  );
}