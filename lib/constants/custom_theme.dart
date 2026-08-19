import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

final class CustomTheme {
  CustomTheme._();
  static const MaterialColor kToDark = MaterialColor(
    0xFF6674E8, 
    <int, Color>{
      50: Color(0xFF6674E8),
      100: Color(0xFF6674E8),
      200: Color(0xFF6674E8),
      300: Color(0xFF6674E8),
      400: Color(0xFF6674E8),
      500: Color(0xFF6674E8),
      600: Color(0xFF6674E8),
      700: Color(0xFF6674E8),
      800: Color(0xFF6674E8),
      900: Color(0xFF6674E8),
    },
  );
  static ThemeData get mainTheme {
    return ThemeData(
      primaryColor: AppColors.allPrimaryColor,
      primarySwatch: CustomTheme.kToDark,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: GoogleFonts.openSans().fontFamily,
      textTheme: GoogleFonts.openSansTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.allPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontFamily: GoogleFonts.openSans().fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
