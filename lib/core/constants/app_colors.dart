import 'package:flutter/material.dart';

/// AppColors — High-contrast, warm, aging-vision optimized color palette.
abstract class AppColors {
  // Primary Calm Teal Palette
  static const Color primary = Color(0xFF006A67);
  static const Color primaryContainer = Color(0xFF9CF1EC);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF00201F);

  // Secondary Warm Amber Palette
  static const Color secondary = Color(0xFF8B5000);
  static const Color secondaryContainer = Color(0xFFFFDCC1);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF2C1600);

  // Background & Surfaces (Soft, anti-glare warm cream)
  static const Color background = Color(0xFFFFF8F0);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF4EFEA);
  static const Color onBackground = Color(0xFF1E293B);
  static const Color onSurface = Color(0xFF0F172A);

  // Safety & Emergency Red
  static const Color emergency = Color(0xFFD32F2F);
  static const Color emergencyContainer = Color(0xFFFFDAD6);
  static const Color onEmergency = Color(0xFFFFFFFF);

  // Status & Affirmation Green
  static const Color success = Color(0xFF2E7D32);
  static const Color successContainer = Color(0xFFC8E6C9);

  // High Contrast Outline & Card Shadows
  static const Color outline = Color(0xFF64748B);
  static const Color cardShadow = Color(0x1A000000);
}
