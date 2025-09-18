import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cresent_charge_user_app/helper/local_db/local_db.dart';
import 'package:cresent_charge_user_app/utils/app_const/app_const.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';

/// Authentication guard for protecting routes
/// This class handles checking if user is authenticated and redirecting if needed
class AuthGuard {
  /// Check if user is currently authenticated (has valid token)
  static Future<bool> isAuthenticated() async {
    try {
      // final token = await SharePrefsHelper.getString(AppConstants.token);
      final String token = await AppStorageService.getAuthToken() ?? '';
      
      final isLoggedIn = token.isNotEmpty;

      debugPrint('🔐 Auth Guard: User authenticated = $isLoggedIn');
      return isLoggedIn;
    } catch (e) {
      debugPrint('🔐 Auth Guard Error: $e');
      return false;
    }
  }

  /// Check if user is in guest mode
  static Future<bool> isGuestMode() async {
    try {
      final isGuest = await SharePrefsHelper.getBool('isGuestMode') ?? false;
      debugPrint('👤 Auth Guard: Guest mode = $isGuest');
      return isGuest;
    } catch (e) {
      debugPrint('👤 Auth Guard Guest Error: $e');
      return false;
    }
  }

  /// Check if user has any form of access (authenticated or guest)
  static Future<bool> hasAccess() async {
    final isAuth = await isAuthenticated();
    final isGuest = await isGuestMode();
    return isAuth || isGuest;
  }

  /// Set guest mode
  static Future<void> setGuestMode(bool isGuest) async {
    try {
      await SharePrefsHelper.setBool('isGuestMode', isGuest);
      debugPrint('👤 Auth Guard: Guest mode set to $isGuest');
    } catch (e) {
      debugPrint('👤 Auth Guard Guest Set Error: $e');
    }
  }

  /// Clear all auth states
  static Future<void> clearAuthStates() async {
    try {
      await SharePrefsHelper.setString(AppConstants.token, '');
      await SharePrefsHelper.setBool('isGuestMode', false);
      debugPrint('🔐 Auth Guard: All auth states cleared');
    } catch (e) {
      debugPrint('🔐 Auth Guard Clear Error: $e');
    }
  }

  /// Get the appropriate redirect path based on authentication status
  static Future<String?> getRedirectPath({
    required String currentPath,
    required bool requiresAuth,
    bool allowGuest = true, // Allow guest access by default
  }) async {
    final isAuth = await isAuthenticated();
    final isGuest = await isGuestMode();
    final hasAnyAccess = isAuth || (allowGuest && isGuest);

    // If route requires auth and user has no access
    if (requiresAuth && !hasAnyAccess) {
      debugPrint('🔐 Auth Guard: Redirecting to login - no access');
      return RoutePath.login.addBasePath;
    }

    // If user has access but trying to access auth pages
    if (hasAnyAccess && _isAuthPage(currentPath)) {
      debugPrint('🔐 Auth Guard: Redirecting to home - user has access');
      return RoutePath.home.addBasePath;
    }

    // No redirect needed
    return null;
  }

  /// Check if the current path is an authentication page
  static bool _isAuthPage(String path) {
    const authPaths = [
      '/login',
      '/signup',
      '/forgotPassword',
      '/verifyOtp',
      '/resetPassword',
      '/fewDetails',
      '/uploadProfilePicture',
      '/addCard',
      '/termsAgreement',
    ];

    return authPaths.any((authPath) => path.contains(authPath));
  }

  /// Create a redirect function for GoRouter
  ///
  /// [requiresAuth] - Whether the route requires authentication
  /// [allowGuest] - Whether guest users can access this route
  /// [authRequired] - Strict authentication (only authenticated users, no guests)
  static String? Function(BuildContext, GoRouterState) createRedirect({
    bool requiresAuth = false,
    bool allowGuest = true,
    bool authRequired = false,
  }) {
    return (BuildContext context, GoRouterState state) {
      return _syncRedirectCheck(
        currentPath: state.fullPath ?? '',
        requiresAuth: requiresAuth,
        allowGuest: allowGuest,
        authRequired: authRequired,
      );
    };
  }

  /// Synchronous redirect check
  static String? _syncRedirectCheck({
    required String currentPath,
    required bool requiresAuth,
    required bool allowGuest,
    required bool authRequired,
  }) {
    // This is a simplified synchronous version
    // In production, you might want to store auth state in a way that's synchronously accessible

    // For demonstration, check if we have stored auth state
    // You can customize this logic based on your needs

    if (authRequired) {
      // Only authenticated users allowed, no guests
      debugPrint('🔐 Auth Guard: Route requires strict auth - checking token');
      // Here you would check for actual authentication token
      // For now, we'll redirect to login if strict auth is required
      return RoutePath.login.addBasePath;
    }

    if (requiresAuth && !allowGuest) {
      // Requires auth but no guest access
      debugPrint(
        '🔐 Auth Guard: Route requires auth, no guest - redirecting to login',
      );
      return RoutePath.login.addBasePath;
    }

    // For guest-allowed routes, no redirect needed
    return null;
  }

  /// Route configuration helpers
  static const RouteGuardConfig noAuthRequired = RouteGuardConfig(
    requiresAuth: false,
    allowGuest: true,
    description: 'Public route - no authentication required',
  );

  static const RouteGuardConfig guestAllowed = RouteGuardConfig(
    requiresAuth: true,
    allowGuest: true,
    description: 'Protected route - authenticated users and guests allowed',
  );

  static const RouteGuardConfig authRequired = RouteGuardConfig(
    requiresAuth: true,
    allowGuest: false,
    description: 'Protected route - only authenticated users allowed',
  );

  static const RouteGuardConfig strictAuth = RouteGuardConfig(
    requiresAuth: true,
    allowGuest: false,
    authRequired: true,
    description: 'Strict auth - only authenticated users, no guests',
  );
}

/// Configuration class for route guards
class RouteGuardConfig {
  final bool requiresAuth;
  final bool allowGuest;
  final bool authRequired;
  final String description;

  const RouteGuardConfig({
    this.requiresAuth = false,
    this.allowGuest = true,
    this.authRequired = false,
    required this.description,
  });

  /// Create redirect function for this configuration
  String? Function(BuildContext, GoRouterState) get redirect {
    return AuthGuard.createRedirect(
      requiresAuth: requiresAuth,
      allowGuest: allowGuest,
      authRequired: authRequired,
    );
  }
}
