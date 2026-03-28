import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockmanagement/src/core/theme/app_colors.dart';

class AppTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    // 🔥 Big titles (Screen title)
    headlineLarge: GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),

    // Section title
    titleLarge: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),

    // Card / product name
    titleMedium: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),

    // Normal text
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    ),

    // Small text / hint
    labelMedium: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    ),

    // 🔥 IMPORTANT: Quantity numbers
    displaySmall: GoogleFonts.inter(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
  );
}
