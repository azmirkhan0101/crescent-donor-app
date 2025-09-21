import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Theme extension for easy access to custom colors and theme utilities
extension AppContextThemeExtension on BuildContext {
  /// Get the current theme's ColorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Check if the current theme is dark
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Check if the current theme is light
  bool get isLightMode => Theme.of(this).brightness == Brightness.light;
}

/// Extension on ColorScheme for semantic color access
extension ColorSchemeExtension on ColorScheme {
  /// Get success color
  Color get success => brightness == Brightness.light
      ? AppColors.success
      : const Color(0xFF81C784);

  /// Get success container color
  Color get successContainer => brightness == Brightness.light
      ? AppColors.successContainer
      : const Color(0xFF2E7D32);

  /// Get warning color
  Color get warning => brightness == Brightness.light
      ? AppColors.warning
      : const Color(0xFFFFB74D);

  /// Get warning container color
  Color get warningContainer => brightness == Brightness.light
      ? AppColors.warningContainer
      : const Color(0xFFE65100);

  /// Get info color
  Color get info =>
      brightness == Brightness.light ? AppColors.info : const Color(0xFF64B5F6);

  /// Get info container color
  Color get infoContainer => brightness == Brightness.light
      ? AppColors.infoContainer
      : const Color(0xFF1565C0);
}

/// Spacing constants following Material Design 3 guidelines
class AppSpacing {
  AppSpacing._();

  // Base spacing unit (4dp)
  static const double unit = 4.0;

  // Spacing scale
  static const double xs = unit; // 4dp
  static const double sm = unit * 2; // 8dp
  static const double md = unit * 3; // 12dp
  static const double lg = unit * 4; // 16dp
  static const double xl = unit * 6; // 24dp
  static const double xxl = unit * 8; // 32dp
  static const double xxxl = unit * 12; // 48dp

  // Semantic spacing
  static const double cardPadding = lg; // 16dp
  static const double screenPadding = lg; // 16dp
  static const double sectionSpacing = xl; // 24dp
  static const double componentSpacing = md; // 12dp
  static const double elementSpacing = sm; // 8dp
}

/// Border radius constants following the design system
class AppRadius {
  AppRadius._();

  // Border radius scale
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;

  // Semantic radius
  static const double button = md; // 12dp - From Figma
  static const double card = lg; // 16dp - From Figma
  static const double modal = xl; // 24dp - From Figma
  static const double input = md; // 12dp - From Figma
  static const double chip = sm; // 8dp
  static const double circular = 100.0; // Fully circular
}

/// Elevation constants following Material Design 3
class AppElevation {
  AppElevation._();

  static const double none = 0.0;
  static const double xs = 1.0;
  static const double sm = 2.0;
  static const double md = 4.0;
  static const double lg = 6.0;
  static const double xl = 8.0;
  static const double xxl = 12.0;
  static const double xxxl = 16.0;

  // Semantic elevation
  static const double card = none; // Flat design from Figma
  static const double modal = lg; // 6dp
  static const double fab = lg; // 6dp
  static const double appBar = none; // Flat design
  static const double bottomSheet = xl; // 8dp
}

/// Animation duration constants
class AppDuration {
  AppDuration._();

  // Material motion system durations
  static const Duration instant = Duration(milliseconds: 0);
  static const Duration fast = Duration(milliseconds: 100);
  static const Duration normal = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 300);
  static const Duration slower = Duration(milliseconds: 500);

  // Semantic durations
  static const Duration button = fast; // Button press
  static const Duration transition = normal; // Page transitions
  static const Duration modal = normal; // Modal animations
  static const Duration fab = normal; // FAB animations
}

/// Animation curve constants
class AppCurves {
  AppCurves._();

  // Material motion system curves
  static const Curve standardCurve = Curves.easeInOut;
  static const Curve decelerateCurve = Curves.easeOut;
  static const Curve accelerateCurve = Curves.easeIn;
  static const Curve sharpCurve = Curves.linear;

  // Semantic curves
  static const Curve button = standardCurve;
  static const Curve transition = standardCurve;
  static const Curve modal = decelerateCurve;
  static const Curve fab = standardCurve;
}

/// Breakpoint constants for responsive design
class AppBreakpoints {
  AppBreakpoints._();

  // Material Design breakpoints
  static const double mobile = 480;
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double largeDesktop = 1440;

  /// Check if current width is mobile
  static bool isMobile(double width) => width < tablet;

  /// Check if current width is tablet
  static bool isTablet(double width) => width >= tablet && width < desktop;

  /// Check if current width is desktop
  static bool isDesktop(double width) => width >= desktop;

  /// Get responsive value based on screen width
  static T responsive<T>({
    required double width,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (width >= AppBreakpoints.desktop) {
      return desktop ?? tablet ?? mobile;
    } else if (width >= AppBreakpoints.tablet) {
      return tablet ?? mobile;
    }
    return mobile;
  }
}

/// Typography utilities
class AppTypography {
  AppTypography._();

  // Font families
  static const String primaryFont = 'FamiljenGrotesk';
  static const String secondaryFont = 'InterDisplay';

  // Font weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  // Letter spacing
  static const double tightSpacing = -0.25;
  static const double normalSpacing = 0.0;
  static const double wideSpacing = 0.5;
}

/// Shadow utilities
class AppShadows {
  AppShadows._();

  /// Subtle shadow for cards
  static List<BoxShadow> get card => [
    BoxShadow(
      color: AppColors.shadow,
      offset: const Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  /// Elevated shadow for modals
  static List<BoxShadow> get modal => [
    BoxShadow(
      color: AppColors.shadow,
      offset: const Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];

  /// Floating action button shadow
  static List<BoxShadow> get fab => [
    BoxShadow(
      color: AppColors.shadow,
      offset: const Offset(0, 6),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];

  /// Small shadow for buttons
  static List<BoxShadow> get button => [
    BoxShadow(
      color: AppColors.shadow,
      offset: const Offset(0, 1),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];
}
