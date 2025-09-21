import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Material Design 3 ColorScheme configurations for the app
class AppColorScheme {
  // Private constructor to prevent instantiation
  AppColorScheme._();

  /// Light theme color scheme following Material Design 3 principles
  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,

    // Primary colors
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: AppColors.onPrimaryContainer,

    // Secondary colors
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    secondaryContainer: AppColors.secondaryContainer,
    onSecondaryContainer: AppColors.onSecondaryContainer,

    // Tertiary colors (using variations of secondary for cohesion)
    tertiary: AppColors.textTertiary,
    onTertiary: AppColors.textOnDark,
    tertiaryContainer: Color(0xFFE8EFEE),
    onTertiaryContainer: Color(0xFF1C2422),

    // Error colors
    error: AppColors.error,
    onError: AppColors.onError,
    errorContainer: AppColors.errorContainer,
    onErrorContainer: AppColors.onErrorContainer,

    // Surface colors
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    surfaceVariant: AppColors.surfaceVariant,
    onSurfaceVariant: AppColors.onSurfaceVariant,

    // Outline colors
    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,

    // Shadow and scrim
    shadow: AppColors.shadow,
    scrim: AppColors.scrim,

    // Inverse colors for high contrast elements
    inverseSurface: AppColors.secondary,
    onInverseSurface: AppColors.surface,
    inversePrimary: Color(0xFF9FE652),

    // Surface tints and containers
    surfaceTint: AppColors.primary,
  );

  /// Dark theme color scheme following Material Design 3 principles
  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,

    // Primary colors (adjusted for dark theme)
    primary: Color(0xFF9FE652), // Slightly muted primary for dark
    onPrimary: Color(0xFF1A2E1A),
    primaryContainer: Color(0xFF2A4A2A),
    onPrimaryContainer: Color(0xFFD1FF43),

    // Secondary colors
    secondary: Color(0xFFE1E3E1),
    onSecondary: Color(0xFF2F312F),
    secondaryContainer: Color(0xFF454845),
    onSecondaryContainer: Color(0xFFFDFDF9),

    // Tertiary colors
    tertiary: Color(0xFFBBC7C6),
    onTertiary: Color(0xFF263332),
    tertiaryContainer: Color(0xFF3C4948),
    onTertiaryContainer: Color(0xFFD7E3E2),

    // Error colors (adjusted for dark theme)
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),

    // Surface colors (dark theme surfaces)
    surface: Color(0xFF121212),
    onSurface: Color(0xFFE6E1E5),
    surfaceVariant: Color(0xFF1E1E1E),
    onSurfaceVariant: Color(0xFFC7C5CA),

    // Outline colors (adjusted for dark theme)
    outline: Color(0xFF918F94),
    outlineVariant: Color(0xFF48464C),

    // Shadow and scrim
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),

    // Inverse colors
    inverseSurface: Color(0xFFE6E1E5),
    onInverseSurface: Color(0xFF313033),
    inversePrimary: AppColors.primary,

    // Surface tints and containers
    surfaceTint: Color(0xFF9FE652),
  );

  /// High contrast light theme for accessibility
  static const ColorScheme lightHighContrast = ColorScheme(
    brightness: Brightness.light,

    // Primary colors with higher contrast
    primary: Color(0xFF8BC34A), // Darker primary for better contrast
    onPrimary: Color(0xFF000000),
    primaryContainer: Color(0xFFE8FF9A),
    onPrimaryContainer: Color(0xFF000000),

    // Secondary colors with higher contrast
    secondary: Color(0xFF000000),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFF606060),
    onSecondaryContainer: Color(0xFFFFFFFF),

    // Tertiary colors
    tertiary: Color(0xFF2E4D3E),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFB8E6D0),
    onTertiaryContainer: Color(0xFF000000),

    // Error colors with higher contrast
    error: Color(0xFF8C1D18),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF000000),

    // Surface colors
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF000000),
    surfaceVariant: Color(0xFFF0F0F0),
    onSurfaceVariant: Color(0xFF000000),

    // Outline colors with higher contrast
    outline: Color(0xFF000000),
    outlineVariant: Color(0xFF606060),

    // Shadow and scrim
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),

    // Inverse colors
    inverseSurface: Color(0xFF000000),
    onInverseSurface: Color(0xFFFFFFFF),
    inversePrimary: Color(0xFFD1FF43),

    // Surface tints and containers
    surfaceTint: Color(0xFF8BC34A),
  );

  /// High contrast dark theme for accessibility
  static const ColorScheme darkHighContrast = ColorScheme(
    brightness: Brightness.dark,

    // Primary colors with higher contrast
    primary: Color(0xFFE8FF9A),
    onPrimary: Color(0xFF000000),
    primaryContainer: Color(0xFF4A7C59),
    onPrimaryContainer: Color(0xFFFFFFFF),

    // Secondary colors with higher contrast
    secondary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF000000),
    secondaryContainer: Color(0xFF808080),
    onSecondaryContainer: Color(0xFFFFFFFF),

    // Tertiary colors
    tertiary: Color(0xFFD7E3E2),
    onTertiary: Color(0xFF000000),
    tertiaryContainer: Color(0xFF5C6F6D),
    onTertiaryContainer: Color(0xFFFFFFFF),

    // Error colors with higher contrast
    error: Color(0xFFFFE6E1),
    onError: Color(0xFF000000),
    errorContainer: Color(0xFFCC0000),
    onErrorContainer: Color(0xFFFFFFFF),

    // Surface colors
    surface: Color(0xFF000000),
    onSurface: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFF121212),
    onSurfaceVariant: Color(0xFFFFFFFF),

    // Outline colors with higher contrast
    outline: Color(0xFFFFFFFF),
    outlineVariant: Color(0xFFA0A0A0),

    // Shadow and scrim
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),

    // Inverse colors
    inverseSurface: Color(0xFFFFFFFF),
    onInverseSurface: Color(0xFF000000),
    inversePrimary: Color(0xFF4A7C59),

    // Surface tints and containers
    surfaceTint: Color(0xFFE8FF9A),
  );
}
