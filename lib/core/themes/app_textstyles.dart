import 'package:flutter/material.dart';

sealed class AppTextStyles {
  AppTextStyles._();

  // Font sizes (based on Figma typography system)
  static const double textXs = 12;
  static const double textSm = 14;
  static const double textBase = 16;
  static const double textLg = 18;
  static const double textXl = 20;
  static const double text2xl = 24;
  static const double text3xl = 30;
  static const double text4xl = 36;

  // Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight normal = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Core styles
  static const TextStyle body = TextStyle(
    fontSize: textBase,
    fontWeight: normal,
    height: 1.5,
  );

  static const TextStyle bodySm = TextStyle(
    fontSize: textSm,
    fontWeight: normal,
    height: 1.5,
  );

  static const TextStyle caption = TextStyle(
    fontSize: textXs,
    fontWeight: normal,
    height: 1.4,
  );

  static const TextStyle h1 = TextStyle(
    fontSize: text2xl,
    fontWeight: medium,
    height: 1.4,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: textXl,
    fontWeight: medium,
    height: 1.4,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: textLg,
    fontWeight: medium,
    height: 1.4,
  );

  static const TextStyle hero = TextStyle(
    fontSize: text4xl,
    fontWeight: bold,
    height: 1.2,
  );

  static TextTheme textTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: hero.copyWith(color: colorScheme.onSurface),
      headlineLarge: h1.copyWith(color: colorScheme.onSurface),
      headlineMedium: h2.copyWith(color: colorScheme.onSurface),
      headlineSmall: h3.copyWith(color: colorScheme.onSurface),
      bodyLarge: body.copyWith(color: colorScheme.onSurface),
      bodyMedium: bodySm.copyWith(color: colorScheme.onSurface),
      bodySmall: caption.copyWith(color: colorScheme.onSurfaceVariant),
      labelLarge: body.copyWith(color: colorScheme.onPrimary),
    );
  }
}
