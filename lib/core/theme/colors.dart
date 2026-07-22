import 'package:flutter/material.dart';

/// Palette de couleurs « FORÊT TROPICALE PREMIUM 3D »
class AppColors {
  AppColors._();

  // === VERT TROPICAL PREMIUM & JUNGLE ===
  static const Color jungleDark = Color(0xFF071B12);      // Fond très sombre teinté forêt
  static const Color jungleDeep = Color(0xFF0D2A1C);      // Vert forêt profond
  static const Color emeraldDark = Color(0xFF13402B);    // Vert émeraude sombre
  static const Color emeraldPrimary = Color(0xFF1B5E3A); // Vert jungle principal
  static const Color leafGreen = Color(0xFF2E8B57);      // Vert feuille tropicale
  static const Color tropicalGreen = Color(0xFF3CB371);  // Vert tropical vif
  static const Color appleGreen = Color(0xFF76FF03);     // Vert pomme lumineux (Accent)
  static const Color mintSubtle = Color(0xFFA7F3D0);     // Vert menthe doux pour textes/icônes

  // === DORE VEGETAL & TONS NATURELS ===
  static const Color goldAccent = Color(0xFFFFD700);
  static const Color goldSubtle = Color(0xFFD4AF37);
  static const Color sandLight = Color(0xFFF5F2EB);
  static const Color creamBase = Color(0xFFFAFAEF);
  static const Color offWhite = Color(0xFFF0F7F4);

  // === GLASSMORPHISM & EFFETS 3D ===
  static const Color glassSurfaceDark = Color(0x3D13402B);  // Verre émeraude nocturne
  static const Color glassSurfaceLight = Color(0x40FFFFFF); // Verre clair
  static const Color glassBorderDark = Color(0x4D76FF03);   // Bordure néon vert pomme
  static const Color glassBorderLight = Color(0x603CB371);  // Bordure vert tropical

  // === STATUTS & IA ===
  static const Color success = Color(0xFF00E676);
  static const Color warning = Color(0xFFFFAB00);
  static const Color error = Color(0xFFFF3D00);
  static const Color info = Color(0xFF00B0FF);
  static const Color aiGlow = Color(0xFF00E5FF);

  // === TEXTES ===
  static const Color textPrimary = Color(0xFFF0F7F4);
  static const Color textSecondary = Color(0xFFA7F3D0);
  static const Color textMuted = Color(0xFF6B9080);
  static const Color textDark = Color(0xFF071B12);

  // === DÉGRADÉS PREMIUM 3D ===
  static const LinearGradient tropicalNightGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF04100B),
      Color(0xFF0A2217),
      Color(0xFF0F3624),
      Color(0xFF071B12),
    ],
  );

  static const LinearGradient tropicalClearingGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFE8F5E9),
      Color(0xFFC8E6C9),
      Color(0xFFA5D6A7),
      Color(0xFFE8F5E9),
    ],
  );

  static const LinearGradient appleGreenButtonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFB2FF59),
      Color(0xFF76FF03),
      Color(0xFF64DD17),
    ],
  );

  static const LinearGradient emeraldButtonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2E8B57),
      Color(0xFF1B5E3A),
      Color(0xFF0D2A1C),
    ],
  );
}
