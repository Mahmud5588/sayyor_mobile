import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

sealed class AppSizes {
  AppSizes._();

  // Responsive Height Values (base: 390x844 design)
  static double h4 = 4.h;
  static double h8 = 8.h;
  static double h12 = 12.h;
  static double h16 = 16.h;
  static double h20 = 20.h;
  static double h24 = 24.h;
  static double h28 = 28.h;
  static double h32 = 32.h;
  static double h40 = 40.h;
  static double h48 = 48.h;
  static double h56 = 56.h;
  static double h64 = 64.h;

  // Responsive Width Values
  static double w4 = 4.w;
  static double w8 = 8.w;
  static double w12 = 12.w;
  static double w16 = 16.w;
  static double w20 = 20.w;
  static double w24 = 24.w;
  static double w28 = 28.w;
  static double w32 = 32.w;
  static double w40 = 40.w;
  static double w48 = 48.w;
  static double w56 = 56.w;
  static double w64 = 64.w;

  // Responsive Padding Values
  static EdgeInsets padding4 = EdgeInsets.all(4.w);
  static EdgeInsets padding8 = EdgeInsets.all(8.w);
  static EdgeInsets padding12 = EdgeInsets.all(12.w);
  static EdgeInsets padding16 = EdgeInsets.all(16.w);
  static EdgeInsets padding20 = EdgeInsets.all(20.w);
  static EdgeInsets padding24 = EdgeInsets.all(24.w);
  static EdgeInsets padding28 = EdgeInsets.all(28.w);
  static EdgeInsets padding32 = EdgeInsets.all(32.w);

  static EdgeInsets paddingH8 = EdgeInsets.symmetric(horizontal: 8.w);
  static EdgeInsets paddingH12 = EdgeInsets.symmetric(horizontal: 12.w);
  static EdgeInsets paddingH16 = EdgeInsets.symmetric(horizontal: 16.w);
  static EdgeInsets paddingH20 = EdgeInsets.symmetric(horizontal: 20.w);
  static EdgeInsets paddingH24 = EdgeInsets.symmetric(horizontal: 24.w);
  static EdgeInsets paddingH28 = EdgeInsets.symmetric(horizontal: 28.w);
  static EdgeInsets paddingH32 = EdgeInsets.symmetric(horizontal: 32.w);

  static EdgeInsets paddingV8 = EdgeInsets.symmetric(vertical: 8.h);
  static EdgeInsets paddingV12 = EdgeInsets.symmetric(vertical: 12.h);
  static EdgeInsets paddingV16 = EdgeInsets.symmetric(vertical: 16.h);
  static EdgeInsets paddingV20 = EdgeInsets.symmetric(vertical: 20.h);
  static EdgeInsets paddingV24 = EdgeInsets.symmetric(vertical: 24.h);
  static EdgeInsets paddingV28 = EdgeInsets.symmetric(vertical: 28.h);
  static EdgeInsets paddingV32 = EdgeInsets.symmetric(vertical: 32.h);

  // Responsive SizedBox Helpers (Height)
  static SizedBox get gH4 => SizedBox(height: h4);
  static SizedBox get gH8 => SizedBox(height: h8);
  static SizedBox get gH12 => SizedBox(height: h12);
  static SizedBox get gH16 => SizedBox(height: h16);
  static SizedBox get gH20 => SizedBox(height: h20);
  static SizedBox get gH24 => SizedBox(height: h24);
  static SizedBox get gH28 => SizedBox(height: h28);
  static SizedBox get gH32 => SizedBox(height: h32);

  // Responsive SizedBox Helpers (Width)
  static SizedBox get gW4 => SizedBox(width: w4);
  static SizedBox get gW8 => SizedBox(width: w8);
  static SizedBox get gW12 => SizedBox(width: w12);
  static SizedBox get gW16 => SizedBox(width: w16);
  static SizedBox get gW20 => SizedBox(width: w20);
  static SizedBox get gW24 => SizedBox(width: w24);
  static SizedBox get gW32 => SizedBox(width: w32);

  // Responsive BorderRadius Values
  static BorderRadius borderRadius4 = BorderRadius.all(Radius.circular(4.r));
  static BorderRadius borderRadius8 = BorderRadius.all(Radius.circular(8.r));
  static BorderRadius borderRadius12 = BorderRadius.all(Radius.circular(12.r));
  static BorderRadius borderRadius16 = BorderRadius.all(Radius.circular(16.r));
  static BorderRadius borderRadius20 = BorderRadius.all(Radius.circular(20.r));
  static BorderRadius borderRadius24 = BorderRadius.all(Radius.circular(24.r));
  static BorderRadius borderRadius28 = BorderRadius.all(Radius.circular(28.r));
  static BorderRadius borderRadius32 = BorderRadius.all(Radius.circular(32.r));

  // Border helpers
  static Border borderAll({
    Color color = const Color(0xFFE0E0E0),
    double width = 1,
  }) {
    return Border.all(color: color, width: width);
  }
}
