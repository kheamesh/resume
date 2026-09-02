import 'package:flutter/material.dart';

class AppColors {
  // Primary Luxury Gold Palette
  static const Color gold = Color(0xFFE2B13C);
  static const Color goldAccent = Color(0xFFC5A059);
  
  // Dark Theme Palette
  static const Color darkBg = Color(0xFF030303);
  static const Color darkCard = Color(0xFF0D0D0D);
  static const Color darkText = Color(0xFFF2F2F2);
  static const Color darkMutedText = Color(0xFF888888);
  static const Color darkBorder = Color(0xFF1A1A1A);
  
  // Light Theme Palette
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF0F172A);
  static const Color lightMutedText = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // Background Accents
  static const Color lightAccent = Color(0xFFE2E8F0);
  static const Color darkAccent = Color(0xFF1A1A1A);

  // Gradient
  static const LinearGradient goldGradient = LinearGradient(
    colors: [gold, goldAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
