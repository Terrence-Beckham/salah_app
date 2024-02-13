import 'package:flutter/widgets.dart';

class AppColor {
  AppColor._();

  static const Color darkGreen = Color(0xFF17794F);
  static const Color desaturatedGreen = Color(0xFF7E9A77);
  static const Color accentGreen = Color(0xFF43C3A1);
  static const Color lightAccentGreen = Color(0xFFC8F4E8);

  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xffff9a9e),
      Color(0xfffad0c4),
      Color(0xfffad0c4),
    ],
  );
}