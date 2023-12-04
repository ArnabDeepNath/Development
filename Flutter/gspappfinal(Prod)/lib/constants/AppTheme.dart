import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspappfinal/constants/AppColor.dart';

class AppFonts {
  static TextStyle Header1({
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.bold,
    Color color = const Color(0xFF000000),
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle Subtitle({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w700,
    Color color = const Color(0xFF000000),
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle SubtitleColor({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w700,
    Color color = AppColors.primaryColor,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle Subtitle2({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w600,
    Color color = const Color(0xFF000000),
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // Add more font styles as needed
  // static TextStyle myCustomFontStyle() { ... }
}
