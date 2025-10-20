import 'package:flutter/material.dart';

/// App color palette based on Figma design system
/// Following Material Design 3 color token structure
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // === PRIMARY COLORS ===
  /// Primary brand color - Bright yellow/lime green from buttons
  static const Color primary = Color(0xFFD1FF43); // rgb(209, 255, 67)

  /// Primary container - Lighter version of primary
  static const Color primaryContainer = Color(0xFFE8FF9A);

  /// On primary - Text/icons on primary color
  static const Color onPrimary = Color(
    0xFF000C0B,
  ); // Dark text on bright background

  /// On primary container - Text/icons on primary container
  static const Color onPrimaryContainer = Color(0xFF1A2E2A);

  // === SECONDARY COLORS ===
  /// Secondary color - Complementary to primary
  static const Color secondary = Color(
    0xFF000C0B,
  ); // rgb(0, 12, 11) - Dark text

  /// Secondary container
  static const Color secondaryContainer = Color(0xFF4A5654);

  /// On secondary - Text/icons on secondary color
  static const Color onSecondary = Color(0xFFFFFFFF);

  /// On secondary container
  static const Color onSecondaryContainer = Color(0xFFE1E3E1);

  // === SURFACE COLORS ===
  /// Main surface background
  static const Color surface = Color(0xFFFFFFFF); // rgb(255, 255, 255)

  /// Surface variant - Slightly different surface
  static const Color surfaceVariant = Color(0xFFF7F7F7); // rgb(247, 247, 247)

  /// Surface container - Cards and elevated surfaces
  static const Color surfaceContainer = Color(0xFFF5F4F6); // rgb(245, 244, 246)

  /// Surface container high - Higher elevation surfaces
  static const Color surfaceContainerHigh = Color(
    0xFFEBE9EC,
  ); // rgb(235, 233, 236)

  /// On surface - Text/icons on surface
  static const Color onSurface = Color(0xFF171717); // rgb(23, 23, 23)

  /// On surface variant - Secondary text
  static const Color onSurfaceVariant = Color(0xFF808080); // rgb(128, 128, 128)

  // === OUTLINE COLORS ===
  /// Primary outline color
  static const Color outline = Color(0xFFE4E4E4); // rgb(228, 228, 228)

  /// Variant outline color
  static const Color outlineVariant = Color(0xFFEDEDED); // rgb(237, 237, 237)

  // === ERROR COLORS ===
  /// Error color
  static const Color error = Color(0xFFB3261E);

  /// Error container
  static const Color errorContainer = Color(0xFFF9DEDC);

  /// On error
  static const Color onError = Color(0xFFFFFFFF);

  /// On error container
  static const Color onErrorContainer = Color(0xFF410E0B);

  // === TEXT COLORS ===
  /// Primary text color
  static const Color textPrimary = Color(0xFF171717); // rgb(23, 23, 23)

  /// Secondary text color
  static const Color textSecondary = Color(0xFF808080); // rgb(128, 128, 128)

  /// Tertiary text color
  static const Color textTertiary = Color(0xFF515A59); // rgb(81, 90, 89)

  /// Text on dark backgrounds
  static const Color textOnDark = Color(0xFFFFFFFF);

  // === SEMANTIC COLORS ===
  /// Success color
  static const Color success = Color(0xFF4CAF50);

  /// Success container
  static const Color successContainer = Color(0xFFE8F5E8);

  /// Warning color
  static const Color warning = Color(0xFFFF9800);

  /// Warning container
  static const Color warningContainer = Color(0xFFFFF3E0);

  /// Info color
  static const Color info = Color(0xFF2196F3);

  /// Info container
  static const Color infoContainer = Color(0xFFE3F2FD);

  // === SPECIAL COLORS ===
  /// Background overlay for modals
  static const Color overlay = Color(0x80000000); // 50% black

  /// Transparent color
  static const Color transparent = Color(0x00000000);

  /// Shadow color
  static const Color shadow = Color(0x1A000000); // 10% black

  /// Scrim color for modals
  static const Color scrim = Color(0x66000000); // 40% black

  // === BRAND SPECIFIC COLORS ===
  /// Red dot indicator
  static const Color redIndicator = Color(0xFFFF0000);

  /// Home indicator
  static const Color homeIndicator = Color(0xFF000000);

  /// Star rating color
  static const Color starRating = Color(0xFFFFD700);

  // === GRADIENT COLORS ===
  /// Primary gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFD1FF43), // Primary
      Color(0xFFA8E63D), // Slightly darker
    ],
  );

  /// Surface gradient for cards
  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFFFFFF), Color(0xFFFAFAFA)],
  );
}
