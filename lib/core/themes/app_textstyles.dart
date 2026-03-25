import 'package:flutter/material.dart';

sealed class AppTextStyles {
  AppTextStyles._();

  // Asosiy shrift nomini shu yerda kiritib ketishingiz mumkin (masalan, Google Fonts'dan 'Inter' yoki 'Roboto')
  static const String fontFamily = 'Inter';

  // ---------------- DISPLAY (Juda katta sarlavhalar, masalan Onboarding uchun) ----------------
  static TextStyle get displayLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 57,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
  );
  static TextStyle get displayMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 45,
    fontWeight: FontWeight.w700,
  );
  static TextStyle get displaySmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );

  // ---------------- HEADLINE (Oyna sarlavhalari uchun) ----------------
  static TextStyle get headlineLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );
  static TextStyle get headlineMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );
  static TextStyle get headlineSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  // ---------------- TITLE (Card, Dialog yoki List elementlarining sarlavhalari) ----------------
  static TextStyle get titleLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );
  static TextStyle get titleMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );
  static TextStyle get titleSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  // ---------------- BODY (Asosiy o'qiladigan matnlar, maqolalar, izohlar) ----------------
  static TextStyle get bodyLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );
  static TextStyle get bodyMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );
  static TextStyle get bodySmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  // ---------------- LABEL (Tugmalar ichidagi yozuvlar, juda kichik izohlar) ----------------
  static TextStyle get labelLarge => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
  static TextStyle get labelMedium => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
  static TextStyle get labelSmall => TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
}
