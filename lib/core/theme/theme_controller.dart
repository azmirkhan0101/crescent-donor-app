import 'package:cresent_charge_user_app/helper/local_db/local_db.dart';
import 'package:cresent_charge_user_app/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller for managing theme switching throughout the app
class ThemeController extends GetxController {
  // Observable theme mode
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  /// Current theme mode
  ThemeMode get themeMode => _themeMode.value;

  /// Check if current theme is dark
  bool get isDarkMode {
    switch (_themeMode.value) {
      case ThemeMode.dark:
        return true;
      case ThemeMode.light:
        return false;
      case ThemeMode.system:
        return Get.isPlatformDarkMode;
    }
  }

  /// Check if current theme is light
  bool get isLightMode => !isDarkMode;

  @override
  void onInit() {
    super.onInit();
    _loadThemeMode();
  }

  /// Load theme mode from storage
  Future<void> _loadThemeMode() async {
    try {
      final savedThemeIndex = await SharePrefsHelper.getInt(
        AppConstants.themeMode,
      );
      // Check if it's a valid theme mode index (getInt returns -1 if not found)
      if (savedThemeIndex >= 0 && savedThemeIndex < ThemeMode.values.length) {
        _themeMode.value = ThemeMode.values[savedThemeIndex];
        Get.changeThemeMode(_themeMode.value);
        update();
      }
    } catch (e) {
      debugPrint('Error loading theme mode: $e');
    }
  }

  /// Save theme mode to storage
  Future<void> _saveThemeMode() async {
    try {
      await SharePrefsHelper.setInt(
        AppConstants.themeMode,
        _themeMode.value.index,
      );
    } catch (e) {
      debugPrint('Error saving theme mode: $e');
    }
  }

  /// Switch to light theme
  Future<void> setLightTheme() async {
    _themeMode.value = ThemeMode.light;
    Get.changeThemeMode(ThemeMode.light);
    await _saveThemeMode();
    update();
  }

  /// Switch to dark theme
  Future<void> setDarkTheme() async {
    _themeMode.value = ThemeMode.dark;
    Get.changeThemeMode(ThemeMode.dark);
    await _saveThemeMode();
    update();
  }

  /// Switch to system theme
  Future<void> setSystemTheme() async {
    _themeMode.value = ThemeMode.system;
    Get.changeThemeMode(ThemeMode.system);
    await _saveThemeMode();
    update();
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    if (isDarkMode) {
      await setLightTheme();
    } else {
      await setDarkTheme();
    }
  }

  /// Cycle through all theme modes
  Future<void> cycleTheme() async {
    switch (_themeMode.value) {
      case ThemeMode.system:
        await setLightTheme();
        break;
      case ThemeMode.light:
        await setDarkTheme();
        break;
      case ThemeMode.dark:
        await setSystemTheme();
        break;
    }
  }

  /// Get theme mode name for display
  String get themeModeDisplayName {
    switch (_themeMode.value) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  /// Get theme mode icon
  IconData get themeModeIcon {
    switch (_themeMode.value) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.brightness_7;
      case ThemeMode.dark:
        return Icons.brightness_3;
    }
  }
}
