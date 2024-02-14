import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColor {
  AppColor._();

  static const Color darkGreen = Color(0xFF17794F);
  static const Color desaturatedGreen = Color(0xFF7E9A77);
  static const Color accentGreen = Color(0xFF43C3A1);
  static const Color lightAccentGreen = Color(0xFFC8F4E8);
  static const Color backgroundGreen = Color(0xFF64AF89);
  static const Divider mainDivider = Divider(
    color: AppColor.accentGreen,
    height: 2,
  );
  static const Shadow mainShadow = Shadow(
    blurRadius: 10,
    // shadow blur
    color: AppColor.desaturatedGreen,
    // shadow color
    offset: Offset(
      2,
      4,
    ), // how much shadow will be shown
  );

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
