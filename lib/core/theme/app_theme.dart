import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color_scheme.dart';

/// Material Design 3 ThemeData configurations for the app
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  /// Light theme configuration
  static ThemeData get light => _buildTheme(
    colorScheme: AppColorScheme.light,
    brightness: Brightness.light,
  );

  /// Dark theme configuration
  static ThemeData get dark => _buildTheme(
    colorScheme: AppColorScheme.dark,
    brightness: Brightness.dark,
  );

  /// High contrast light theme for accessibility
  static ThemeData get lightHighContrast => _buildTheme(
    colorScheme: AppColorScheme.lightHighContrast,
    brightness: Brightness.light,
  );

  /// High contrast dark theme for accessibility
  static ThemeData get darkHighContrast => _buildTheme(
    colorScheme: AppColorScheme.darkHighContrast,
    brightness: Brightness.dark,
  );

  /// Builds a complete ThemeData with all component themes
  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Brightness brightness,
  }) {
    final bool isDark = brightness == Brightness.dark;

    return ThemeData(
      // Core theme configuration
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: brightness,

      // Visual density for different platforms
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // Typography theme
      textTheme: _buildTextTheme(colorScheme),

      // Primary text theme for components
      primaryTextTheme: _buildTextTheme(colorScheme),

      // App bar theme
      appBarTheme: _buildAppBarTheme(colorScheme, isDark),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(colorScheme),

      // Navigation bar theme (Material 3)
      navigationBarTheme: _buildNavigationBarTheme(colorScheme),

      // Card theme
      cardTheme: _buildCardTheme(colorScheme),

      // Elevated button theme
      elevatedButtonTheme: _buildElevatedButtonTheme(colorScheme),

      // Filled button theme
      filledButtonTheme: _buildFilledButtonTheme(colorScheme),

      // Outlined button theme
      outlinedButtonTheme: _buildOutlinedButtonTheme(colorScheme),

      // Text button theme
      textButtonTheme: _buildTextButtonTheme(colorScheme),

      // Input decoration theme
      inputDecorationTheme: _buildInputDecorationTheme(colorScheme),

      // Floating action button theme
      floatingActionButtonTheme: _buildFABTheme(colorScheme),

      // Chip theme
      chipTheme: _buildChipTheme(colorScheme),

      // Dialog theme
      dialogTheme: _buildDialogTheme(colorScheme),

      // Bottom sheet theme
      bottomSheetTheme: _buildBottomSheetTheme(colorScheme),

      // Tab bar theme
      tabBarTheme: _buildTabBarTheme(colorScheme),

      // List tile theme
      listTileTheme: _buildListTileTheme(colorScheme),

      // Divider theme
      dividerTheme: _buildDividerTheme(colorScheme),

      // Switch theme
      switchTheme: _buildSwitchTheme(colorScheme),

      // Checkbox theme
      checkboxTheme: _buildCheckboxTheme(colorScheme),

      // Radio theme
      radioTheme: _buildRadioTheme(colorScheme),

      // Slider theme
      sliderTheme: _buildSliderTheme(colorScheme),

      // Progress indicator theme
      progressIndicatorTheme: _buildProgressIndicatorTheme(colorScheme),

      // Snack bar theme
      snackBarTheme: _buildSnackBarTheme(colorScheme),

      // Scaffold background color
      scaffoldBackgroundColor: colorScheme.surface,

      // Splash color
      splashColor: colorScheme.primary.withOpacity(0.12),
      highlightColor: colorScheme.primary.withOpacity(0.08),

      // Focus color
      focusColor: colorScheme.primary.withOpacity(0.12),
      hoverColor: colorScheme.primary.withOpacity(0.08),

      // Icon theme
      iconTheme: IconThemeData(color: colorScheme.onSurface, size: 24.0),
      primaryIconTheme: IconThemeData(color: colorScheme.onPrimary, size: 24.0),
    );
  }

  /// Builds the text theme based on the Figma design
  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      // Display styles (largest text)
      displayLarge: TextStyle(
        fontFamily: 'FamiljenGrotesk',
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: colorScheme.onSurface,
        height: 1.12,
      ),
      displayMedium: TextStyle(
        fontFamily: 'FamiljenGrotesk',
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: colorScheme.onSurface,
        height: 1.16,
      ),
      displaySmall: TextStyle(
        fontFamily: 'FamiljenGrotesk',
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: colorScheme.onSurface,
        height: 1.22,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontFamily: 'FamiljenGrotesk',
        fontSize: 32,
        fontWeight: FontWeight.w700, // Bold from Figma
        letterSpacing: 0,
        color: colorScheme.onSurface,
        height: 1.25, // 40px / 32px from Figma
      ),
      headlineMedium: TextStyle(
        fontFamily: 'FamiljenGrotesk',
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: colorScheme.onSurface,
        height: 1.29,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'FamiljenGrotesk',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: colorScheme.onSurface,
        height: 1.33,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontFamily: 'FamiljenGrotesk',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: colorScheme.onSurface,
        height: 1.27,
      ),
      titleMedium: TextStyle(
        fontFamily: 'FamiljenGrotesk',
        fontSize: 16,
        fontWeight: FontWeight.w700, // Bold from Figma
        letterSpacing: 0.15,
        color: colorScheme.onSurface,
        height: 1.25, // 20px / 16px from Figma
      ),
      titleSmall: TextStyle(
        fontFamily: 'FamiljenGrotesk',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: colorScheme.onSurface,
        height: 1.43,
      ),

      // Label styles (buttons, captions)
      labelLarge: TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: colorScheme.onSurface,
        height: 1.43,
      ),
      labelMedium: TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
        height: 1.33,
      ),
      labelSmall: TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
        height: 1.45,
      ),

      // Body styles (regular text)
      bodyLarge: TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: colorScheme.onSurface,
        height: 1.29, // 18px / 14px from Figma
      ),
      bodySmall: TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: colorScheme.onSurfaceVariant,
        height: 1.33,
      ),
    );
  }

  /// Builds the AppBar theme
  static AppBarTheme _buildAppBarTheme(ColorScheme colorScheme, bool isDark) {
    return AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleSpacing: 16,
      systemOverlayStyle: isDark
          ? SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.transparent,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
            ),
      titleTextStyle: TextStyle(
        fontFamily: 'FamiljenGrotesk',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurface, size: 24),
      actionsIconTheme: IconThemeData(color: colorScheme.onSurface, size: 24),
    );
  }

  /// Builds the bottom navigation bar theme
  static BottomNavigationBarThemeData _buildBottomNavigationBarTheme(
    ColorScheme colorScheme,
  ) {
    return BottomNavigationBarThemeData(
      backgroundColor: colorScheme.surface,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: const TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  /// Builds the navigation bar theme (Material 3)
  static NavigationBarThemeData _buildNavigationBarTheme(
    ColorScheme colorScheme,
  ) {
    return NavigationBarThemeData(
      backgroundColor: colorScheme.surface,
      indicatorColor: colorScheme.secondaryContainer,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            fontFamily: 'InterDisplay',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          );
        }
        return TextStyle(
          fontFamily: 'InterDisplay',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurfaceVariant,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(
            color: colorScheme.onSecondaryContainer,
            size: 24,
          );
        }
        return IconThemeData(color: colorScheme.onSurfaceVariant, size: 24);
      }),
    );
  }

  /// Builds the card theme
  static CardThemeData _buildCardTheme(ColorScheme colorScheme) {
    return CardThemeData(
      color: colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // From Figma design
        side: BorderSide(color: colorScheme.outline, width: 1),
      ),
      margin: const EdgeInsets.all(0),
    );
  }

  /// Builds the elevated button theme
  static ElevatedButtonThemeData _buildElevatedButtonTheme(
    ColorScheme colorScheme,
  ) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(0, 52), // From Figma design
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // From Figma design
        ),
        textStyle: const TextStyle(
          fontFamily: 'InterDisplay',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  /// Builds the filled button theme
  static FilledButtonThemeData _buildFilledButtonTheme(
    ColorScheme colorScheme,
  ) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(0, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: 'InterDisplay',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  /// Builds the outlined button theme
  static OutlinedButtonThemeData _buildOutlinedButtonTheme(
    ColorScheme colorScheme,
  ) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.secondary,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(0, 52),
        side: BorderSide(color: colorScheme.secondary, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: 'InterDisplay',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  /// Builds the text button theme
  static TextButtonThemeData _buildTextButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.secondary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(0, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: 'InterDisplay',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  /// Builds the input decoration theme
  static InputDecorationTheme _buildInputDecorationTheme(
    ColorScheme colorScheme,
  ) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12), // From Figma design
        borderSide: BorderSide(color: colorScheme.outline, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.outline, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.error, width: 2),
      ),
      contentPadding: const EdgeInsets.all(16), // From Figma design
      labelStyle: TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurfaceVariant,
      ),
      hintStyle: TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurfaceVariant,
      ),
      helperStyle: TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurfaceVariant,
      ),
      errorStyle: TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: colorScheme.error,
      ),
    );
  }

  /// Builds the floating action button theme
  static FloatingActionButtonThemeData _buildFABTheme(ColorScheme colorScheme) {
    return FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      elevation: 6,
      focusElevation: 8,
      hoverElevation: 8,
      highlightElevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  /// Builds the chip theme
  static ChipThemeData _buildChipTheme(ColorScheme colorScheme) {
    return ChipThemeData(
      backgroundColor: colorScheme.surfaceContainer,
      selectedColor: colorScheme.secondaryContainer,
      disabledColor: colorScheme.surfaceVariant,
      side: BorderSide(color: colorScheme.outline, width: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      labelStyle: TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  /// Builds the dialog theme
  static DialogThemeData _buildDialogTheme(ColorScheme colorScheme) {
    return DialogThemeData(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // From Figma modal design
      ),
      elevation: 6,
      titleTextStyle: TextStyle(
        fontFamily: 'FamiljenGrotesk',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      contentTextStyle: TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  /// Builds the bottom sheet theme
  static BottomSheetThemeData _buildBottomSheetTheme(ColorScheme colorScheme) {
    return BottomSheetThemeData(
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24), // From Figma modal design
        ),
      ),
      elevation: 8,
      modalBackgroundColor: colorScheme.surface,
      modalElevation: 8,
    );
  }

  /// Builds the tab bar theme
  static TabBarThemeData _buildTabBarTheme(ColorScheme colorScheme) {
    return TabBarThemeData(
      labelColor: colorScheme.onSurface,
      unselectedLabelColor: colorScheme.onSurfaceVariant,
      // indicator: BoxDecoration(
      //   border: Border.all(color: colorScheme.secondary, width: 1),
      //   borderRadius: BorderRadius.circular(12),
      // ),
      labelStyle: const TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    );
  }

  /// Builds the list tile theme
  static ListTileThemeData _buildListTileTheme(ColorScheme colorScheme) {
    return ListTileThemeData(
      tileColor: colorScheme.surface,
      textColor: colorScheme.onSurface,
      iconColor: colorScheme.onSurfaceVariant,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  /// Builds the divider theme
  static DividerThemeData _buildDividerTheme(ColorScheme colorScheme) {
    return DividerThemeData(color: colorScheme.outline, thickness: 1, space: 1);
  }

  /// Builds the switch theme
  static SwitchThemeData _buildSwitchTheme(ColorScheme colorScheme) {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.onPrimary;
        }
        return colorScheme.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.surfaceVariant;
      }),
    );
  }

  /// Builds the checkbox theme
  static CheckboxThemeData _buildCheckboxTheme(ColorScheme colorScheme) {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
      side: BorderSide(color: colorScheme.outline, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }

  /// Builds the radio theme
  static RadioThemeData _buildRadioTheme(ColorScheme colorScheme) {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.outline;
      }),
    );
  }

  /// Builds the slider theme
  static SliderThemeData _buildSliderTheme(ColorScheme colorScheme) {
    return SliderThemeData(
      activeTrackColor: colorScheme.primary,
      inactiveTrackColor: colorScheme.surfaceVariant,
      thumbColor: colorScheme.primary,
      overlayColor: colorScheme.primary.withOpacity(0.12),
      valueIndicatorColor: colorScheme.primary,
      valueIndicatorTextStyle: TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: colorScheme.onPrimary,
      ),
    );
  }

  /// Builds the progress indicator theme
  static ProgressIndicatorThemeData _buildProgressIndicatorTheme(
    ColorScheme colorScheme,
  ) {
    return ProgressIndicatorThemeData(
      color: colorScheme.primary,
      linearTrackColor: colorScheme.surfaceVariant,
      circularTrackColor: colorScheme.surfaceVariant,
    );
  }

  /// Builds the snack bar theme
  static SnackBarThemeData _buildSnackBarTheme(ColorScheme colorScheme) {
    return SnackBarThemeData(
      backgroundColor: colorScheme.inverseSurface,
      contentTextStyle: TextStyle(
        fontFamily: 'InterDisplay',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colorScheme.onInverseSurface,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      behavior: SnackBarBehavior.floating,
      elevation: 6,
    );
  }
}
