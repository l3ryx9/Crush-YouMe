import 'package:flutter/material.dart';
import 'colors.dart';

/// Configuration du thème global de l'application
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => _buildTheme(Brightness.light);
  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final bgDark = AppColors.jungleDark;
    final bgLight = AppColors.creamBase;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: isDark ? bgDark : bgLight,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.appleGreen,
        onPrimary: AppColors.jungleDark,
        secondary: AppColors.tropicalGreen,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        surface: isDark ? AppColors.emeraldDark : Colors.white,
        onSurface: isDark ? AppColors.textPrimary : AppColors.textDark,
      ),
      fontFamily: 'Lato',
      textTheme: _buildTextTheme(isDark),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Playfair',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : AppColors.emeraldDark,
          letterSpacing: 1.5,
        ),
        iconTheme: IconThemeData(color: isDark ? AppColors.appleGreen : AppColors.emeraldDark),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.jungleDeep.withOpacity(0.7) : Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.leafGreen.withOpacity(0.4), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: AppColors.emeraldPrimary.withOpacity(0.5), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.appleGreen, width: 2.5),
        ),
        labelStyle: TextStyle(color: isDark ? AppColors.mintSubtle : AppColors.emeraldPrimary),
        hintStyle: TextStyle(color: (isDark ? AppColors.mintSubtle : AppColors.textMuted).withOpacity(0.6)),
      ),
      cardTheme: CardTheme(
        color: isDark ? AppColors.emeraldDark.withOpacity(0.8) : Colors.white.withOpacity(0.85),
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: AppColors.appleGreen.withOpacity(0.3), width: 1),
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme(bool isDark) {
    final primaryColor = isDark ? AppColors.textPrimary : AppColors.textDark;
    return TextTheme(
      displayLarge: TextStyle(fontFamily: 'Playfair', color: primaryColor, fontSize: 44, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(fontFamily: 'Playfair', color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontFamily: 'Lato', color: primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontFamily: 'Lato', color: primaryColor, fontSize: 16),
      bodyMedium: TextStyle(fontFamily: 'Lato', color: primaryColor, fontSize: 14),
      labelLarge: const TextStyle(fontFamily: 'Lato', color: AppColors.appleGreen, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2),
    );
  }
}
