// lib/services/app_storage_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorageService {
  // Private instances
  static final FlutterSecureStorage _secureStorage =
      const FlutterSecureStorage();
  static late SharedPreferences _preferences;
  static bool _isInitialized = false;

  // Storage keys - keep all keys in one place
  static const String _authTokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _lastLoginKey = 'last_login_time';
  static const String _isGuestKey = 'is_guest_user';

  // Preference keys
  // static const String _themeKey = 'app_theme';
  // static const String _languageKey = 'app_language';
  // static const String _firstLaunchKey = 'is_first_launch';

  // Initialize both storage systems
  static Future<void> init() async {
    if (!_isInitialized) {
      try {
        _preferences = await SharedPreferences.getInstance();
        _isInitialized = true;
      } catch (e) {
        throw Exception('Failed to initialize storage service: $e');
      }
    }
  }

  // Check if service is initialized
  static bool get isInitialized => _isInitialized;

  // ==================== SECURE STORAGE METHODS ====================

  // Auth Tokens
  static Future<void> saveAuthToken(String token) async {
    _checkInitialization();
    await _secureStorage.write(key: _authTokenKey, value: token);
  }

  static Future<String?> getAuthToken() async {
    _checkInitialization();
    return await _secureStorage.read(key: _authTokenKey);
  }

  static Future<void> deleteAuthToken() async {
    _checkInitialization();
    await _secureStorage.delete(key: _authTokenKey);
  }

  static Future<void> saveRefreshToken(String token) async {
    _checkInitialization();
    await _secureStorage.write(key: _refreshTokenKey, value: token);
  }

  static Future<String?> getRefreshToken() async {
    _checkInitialization();
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  static Future<void> deleteRefreshToken() async {
    _checkInitialization();
    await _secureStorage.delete(key: _refreshTokenKey);
  }

  // Is Guest User
  static Future<void> saveIsGuestUser(bool isGuest) async {
    _checkInitialization();
    await _secureStorage.write(key: _isGuestKey, value: isGuest.toString());
  }

  static Future<bool> getIsGuestUser() async {
    _checkInitialization();
    String? value = await _secureStorage.read(key: _isGuestKey);
    return value == 'true';
  }

  // User Data
  static Future<void> saveUserId(String userId) async {
    _checkInitialization();
    await _secureStorage.write(key: _userIdKey, value: userId);
  }

  static Future<String?> getUserId() async {
    _checkInitialization();
    return await _secureStorage.read(key: _userIdKey);
  }

  static Future<void> saveUserName(String userName) async {
    _checkInitialization();
    await _secureStorage.write(key: _userNameKey, value: userName);
  }

  static Future<String?> getUserName() async {
    _checkInitialization();
    return await _secureStorage.read(key: _userNameKey);
  }

  static Future<void> saveUserEmail(String userEmail) async {
    _checkInitialization();
    await _secureStorage.write(key: _userEmailKey, value: userEmail);
  }

  static Future<String?> getUserEmail() async {
    _checkInitialization();
    return await _secureStorage.read(key: _userEmailKey);
  }

  // Generic secure storage methods
  static Future<void> writeSecure(String key, String value) async {
    _checkInitialization();
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String?> readSecure(String key) async {
    _checkInitialization();
    return await _secureStorage.read(key: key);
  }

  static Future<void> deleteSecure(String key) async {
    _checkInitialization();
    await _secureStorage.delete(key: key);
  }

  // ==================== SHARED PREFERENCES METHODS ====================

  // // Theme Preferences
  // static Future<void> saveTheme(String theme) async {
  //   _checkInitialization();
  //   await _preferences.setString(_themeKey, theme);
  // }

  // static String getTheme() {
  //   return _preferences.getString(_themeKey) ?? 'light';
  // }

  // // Language Preferences
  // static Future<void> saveLanguage(String language) async {
  //   _checkInitialization();
  //   await _preferences.setString(_languageKey, language);
  // }

  // static String getLanguage() {
  //   return _preferences.getString(_languageKey) ?? 'en';
  // }

  // // First Launch
  // static Future<void> saveFirstLaunch(bool isFirst) async {
  //   _checkInitialization();
  //   await _preferences.setBool(_firstLaunchKey, isFirst);
  // }

  // static bool getFirstLaunch() {
  //   return _preferences.getBool(_firstLaunchKey) ?? true;
  // }

  // Last Login Time
  static Future<void> saveLastLogin(DateTime dateTime) async {
    _checkInitialization();
    await _preferences.setString(_lastLoginKey, dateTime.toIso8601String());
  }

  static DateTime? getLastLogin() {
    String? dateTimeString = _preferences.getString(_lastLoginKey);
    if (dateTimeString != null) {
      try {
        return DateTime.parse(dateTimeString);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // Generic preference methods
  static Future<void> writePreference(String key, String value) async {
    _checkInitialization();
    await _preferences.setString(key, value);
  }

  static Future<void> writePreferenceBool(String key, bool value) async {
    _checkInitialization();
    await _preferences.setBool(key, value);
  }

  static Future<void> writePreferenceInt(String key, int value) async {
    _checkInitialization();
    await _preferences.setInt(key, value);
  }

  static String? readPreference(String key) {
    return _preferences.getString(key);
  }

  static bool? readPreferenceBool(String key) {
    return _preferences.getBool(key);
  }

  static int? readPreferenceInt(String key) {
    return _preferences.getInt(key);
  }

  // ==================== UTILITY METHODS ====================

  // Clear all sensitive data (for logout)
  static Future<void> clearSecureData() async {
    _checkInitialization();
    await _secureStorage.deleteAll();
  }

  // Clear all preferences
  static Future<void> clearPreferences() async {
    _checkInitialization();
    await _preferences.clear();
  }

  // Clear everything
  static Future<void> clearAll() async {
    _checkInitialization();
    await _secureStorage.deleteAll();
    await _preferences.clear();
  }

  // Check if a secure key exists
  static Future<bool> containsSecureKey(String key) async {
    _checkInitialization();
    return await _secureStorage.containsKey(key: key);
  }

  // Check if a preference key exists
  static bool containsPreferenceKey(String key) {
    return _preferences.containsKey(key);
  }

  // Private method to ensure initialization
  static void _checkInitialization() {
    if (!_isInitialized) {
      throw Exception('AppStorageService not initialized. Call init() first.');
    }
  }
}
