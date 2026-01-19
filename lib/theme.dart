import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Paleta minimalista profesional - blanco y negro
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFFFFFFF);
  static const ink = Color(0xFF0A0A0A);
  static const muted = Color(0xFF6B6B6B);
  static const border = Color(0xFFE8E8E8);
  static const accent = Color(0xFF0A0A0A);
  static const accentSoft = Color(0xFFF5F5F5);
  static const whatsapp = Color(0xFF25D366);
}

ThemeData buildLightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: GoogleFonts.interTextTheme().apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.ink,
      secondary: AppColors.ink,
      surface: AppColors.surface,
      onSurface: AppColors.ink,
    ),
  );
}
