import 'dart:ui';

sealed class AppColors {
  AppColors._();

  // Primary -
  static const Color kPrimaryColor = Color(0xFFFF8C42);
  static const Color kPrimaryDark = Color(0xFFE6762E);
  static const Color kPrimaryLight = Color(0xFFFFB385);
  static const Color kPrimaryContainer = Color(0xFFFFE5D4);

  // Secondary
  static const Color kSecondaryColor = Color(0xFF2B2D42);
  static const Color kSecondaryContainer = Color(0xFFEDF2F4);

  // Background & Surface
  static const Color kWhite = Color(0xFFFFFFFF);
  static const Color kLightBg = Color(0xFFF8F9FA);
  static const Color kDarkBg = Color(0xFF121212);
  static const Color kDarkSurface = Color(0xFF1E1E1E);

  // Neutral / Grayscale
  static const Color kGray900 = Color(0xFF1A1A1A);
  static const Color kGray600 = Color(0xFF757575);
  static const Color kGray300 = Color(0xFFD1D1D1);
  static const Color kGray100 = Color(0xFFF5F5F5);

  // Status
  static const Color kError = Color(0xFFE63946);
  static const Color kSuccess = Color(0xFF2A9D8F);

  // Gradients
  static const List<Color> orangeGradient = [
    Color(0xFFFF8C42),
    Color(0xFFFF5733),
  ];
}