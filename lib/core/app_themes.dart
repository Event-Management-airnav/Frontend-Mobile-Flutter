import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    useMaterial3:  true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.surface,
    // TODO add more
  );
}