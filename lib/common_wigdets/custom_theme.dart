import 'package:flutter/material.dart';

import '../helpers/di.dart';
import '../constants/app_colors.dart'; // import AppColors to use brand colors if needed

class CustomThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? dark : light;

  CustomThemeProvider() {
    _loadThemeFromPrefs();
  }

  void toggleTheme(bool isDark) async {
    if (_isDarkMode != isDark) {
      _isDarkMode = isDark;
      notifyListeners();
      await _saveThemeToPrefs();
    }
  }

  Future<void> _loadThemeFromPrefs() async {
    _isDarkMode = appData.read('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> _saveThemeToPrefs() async {
    await appData.write('isDarkMode', _isDarkMode);
  }

  // 🔹 Define premium light theme
  final ThemeData light = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    primaryColor: AppColors.allPrimaryColor, 
    scaffoldBackgroundColor: const Color(0xFFFAF9F6), // Soft warm off-white (premium feel)
    cardColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: AppColors.allPrimaryColor,
      secondary: AppColors.allPrimaryColor,
      surface: Colors.white,
      background: const Color(0xFFFAF9F6),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black87,
      elevation: 0,
      centerTitle: true, // centered title for premium look
      iconTheme: IconThemeData(color: Colors.black87),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0, // we will use custom BoxShadows in containers, or a very subtle card elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // very rounded corners
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 20, // drop shadow
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.allPrimaryColor,
      unselectedItemColor: Colors.black38,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
  );

  // 🔹 Define premium dark theme
  final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    primaryColor: AppColors.allPrimaryColor, 
    scaffoldBackgroundColor: const Color(0xFF0F172A), // Slate 900
    cardColor: const Color(0xFF1E293B), // Slate 800
    canvasColor: const Color(0xFF0F172A),
    colorScheme: ColorScheme.dark(
      primary: AppColors.allPrimaryColor,
      secondary: AppColors.allPrimaryColor,
      surface: const Color(0xFF1E293B),
      background: const Color(0xFF0F172A),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFF8FAFC)), // Slate 50
      bodyMedium: TextStyle(color: Color(0xFFCBD5E1)), // Slate 300
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFF94A3B8), // Slate 400
    ),
    dividerColor: const Color(0xFF334155), // Slate 700
    cardTheme: CardThemeData(
      color: const Color(0xFF1E293B),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E293B),
      elevation: 20,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.allPrimaryColor,
      unselectedItemColor: Color(0xFF94A3B8),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
  );
}
