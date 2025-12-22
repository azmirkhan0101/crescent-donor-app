import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/go-router/routes/auth_routes.dart';
import 'package:cresent_charge_user_app/core/go-router/routes/bottom_nav_routes.dart';
import 'package:cresent_charge_user_app/core/go-router/routes/donation_routes.dart';
import 'package:cresent_charge_user_app/core/go-router/routes/home_routes.dart';
// Import route modules
import 'package:cresent_charge_user_app/core/go-router/routes/onboarding_routes.dart';
import 'package:cresent_charge_user_app/core/go-router/routes/profile_routes.dart';
import 'package:cresent_charge_user_app/core/go-router/routes/rewards_routes.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main Application Router
///
/// This class is the central point for all routing configuration in the app.
/// It combines routes from different feature modules and provides a clean,
/// organized way to manage navigation throughout the application.
///
/// Key Features:
/// - Modular route organization by feature
/// - Authentication guards
/// - Centralized error handling
/// - Easy to extend and maintain
class AppRouter {
  /// Private constructor to prevent instantiation
  AppRouter._();

  /// Single instance of the router (Singleton pattern)
  static final AppRouter _instance = AppRouter._();
  static AppRouter get instance => _instance;

  /// Route modules - each handles a specific feature area
  static final _bottomNavRoutes = BottomNavRoutes();
  static final _onboardingRoutes = OnboardingRoutes();
  static final _authRoutes = AuthRoutes();
  static final _homeRoutes = HomeRoutes();
  static final _rewardsRoutes = RewardsRoutes();
  static final _donationRoutes = DonationRoutes();
  static final _profileRoutes = ProfileRoutes();

  /// Main GoRouter configuration
  /// This is the router instance that will be used throughout the app
  static final GoRouter _router = GoRouter(
    // App starts at the onboarding screen for new users
    initialLocation: RoutePath.getStartPage.addBasePath,

    // Enable debug logging in development (helpful for beginners)
    debugLogDiagnostics: true,

    // Combine all route modules into a single list
    routes: [
      // Bottom Navigation routes - app introduction and getting started
      ..._bottomNavRoutes.routes,

      // Onboarding routes - app introduction and getting started
      ..._onboardingRoutes.routes,

      // Authentication routes - login, signup, password reset
      ..._authRoutes.routes,

      // Home routes - main app features (requires authentication)
      ..._homeRoutes.routes,

      // Rewards routes - rewards features (requires authentication)
      ..._rewardsRoutes.routes,

      // Donation routes - donation features (requires authentication)
      ..._donationRoutes.routes,

      // Profile routes - profile features (requires authentication)
      ..._profileRoutes.routes,
    ],

    /// Error handling for unknown routes
    /// This provides a fallback when users navigate to non-existent routes
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text('Page Not Found')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Oops! Page not found',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'The page "${state.fullPath}" does not exist.',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () =>
                    GoRouter.of(context).go(RoutePath.home.addBasePath),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      );
    },
  );

  /// Getter to access the router instance
  /// Use this in your main.dart: AppRouter.router
  static GoRouter get router => _router;

  /// Helper method to check if a route exists
  /// Useful for conditional navigation
  static bool routeExists(String routeName) {
    try {
      final allRoutes = [
        ..._bottomNavRoutes.routes,
        ..._onboardingRoutes.routes,
        ..._authRoutes.routes,
        ..._homeRoutes.routes,
        ..._rewardsRoutes.routes,
        ..._donationRoutes.routes,
        ..._profileRoutes.routes,
      ];

      return allRoutes.any((route) {
        if (route is GoRoute) {
          return route.name == routeName;
        }
        return false;
      });
    } catch (e) {
      return false;
    }
  }

  /// Helper method to get route information
  /// Useful for debugging and development
  static Map<String, String> getAllRoutes() {
    final routes = <String, String>{};

    // Add bottom navigation routes
    routes['Bottom Navigation - Home'] = RoutePath.home;
    routes['Bottom Navigation - Rewards'] = RoutePath.rewards;
    routes['Bottom Navigation - Donations'] = RoutePath.donation;
    routes['Bottom Navigation - Profile'] = RoutePath.profile;

    // Add onboarding routes
    routes['Onboarding - Get Started'] = RoutePath.getStartPage;
    routes['Onboarding - How to Work'] = RoutePath.howToWorkPage;

    // Add auth routes
    routes['Auth - Login'] = RoutePath.login;
    routes['Auth - Signup'] = RoutePath.signup;
    routes['Auth - Few Details'] = RoutePath.fewDetails;
    routes['Auth - Upload Picture'] = RoutePath.uploadProfilePicture;
    routes['Auth - Add Card'] = RoutePath.addCard;
    routes['Auth - Terms Agreement'] = RoutePath.termsAgreement;
    routes['Auth - Forgot Password'] = RoutePath.forgotPassword;
    routes['Auth - Verify OTP'] = RoutePath.verifyOtp;
    routes['Auth - Reset Password'] = RoutePath.resetPassword;

    // Add home routes
    routes['Home - Dashboard'] = RoutePath.home;

    // Add rewards routes
    routes['Rewards - Store Profile'] = RoutePath.storeProfile;

    // Add donation routes
    routes['Donation - Organization Donations'] =
        RoutePath.organizationDonations;
    routes['Donation - Round Up'] = RoutePath.roundUp;
    routes['Donation - Round Up Settings'] = RoutePath.settings;
    routes['Donation - Recurring Donations'] = RoutePath.recurringDonations;

    // Add profile routes
    routes['Profile - Dashboard'] = RoutePath.profile;

    return routes;
  }
}

/// Extension to provide easy access to the router
/// This makes it convenient to access the router from anywhere in the app
extension AppRouterExtension on AppRouter {
  /// Navigate to a specific route by name (requires BuildContext)
  static void navigateToRoute(BuildContext context, String routeName, {extra}) {
    if (AppRouter.routeExists(routeName)) {
      context.pushNamed(routeName, extra: extra);
    } else {
      throw Exception('Route $routeName does not exist');
    }
  }

  /// Navigate and replace current route
  static void goToRoute(BuildContext context, String routeName) {
    if (AppRouter.routeExists(routeName)) {
      context.goNamed(routeName);
    } else {
      throw Exception('Route $routeName does not exist');
    }
  }

  /// Navigate and clear the entire stack
  static void goToRouteAndClearStack(BuildContext context, String routeName) {
    if (AppRouter.routeExists(routeName)) {
      context.goNamed(routeName);
    } else {
      throw Exception('Route $routeName does not exist');
    }
  }
}

/// Extension on BuildContext for easier navigation
/// This provides direct methods on BuildContext for navigation
extension AppRouterContextExtension on BuildContext {
  /// Navigate to a route by name with safety check
  void safeNavigateToRoute(String routeName) {
    if (AppRouter.routeExists(routeName)) {
      pushNamed(routeName);
    } else {
      debugPrint('⚠️ Route $routeName does not exist');
    }
  }

  /// Go to a route by name with safety check
  void safeGoToRoute(String routeName) {
    if (AppRouter.routeExists(routeName)) {
      goNamed(routeName);
    } else {
      debugPrint('⚠️ Route $routeName does not exist');
    }
  }

  /// Navigate with route validation and error handling
  void navigateToRouteWithFallback(String routeName, {String? fallbackRoute}) {
    if (AppRouter.routeExists(routeName)) {
      pushNamed(routeName);
    } else {
      debugPrint('⚠️ Route $routeName does not exist');
      if (fallbackRoute != null && AppRouter.routeExists(fallbackRoute)) {
        pushNamed(fallbackRoute);
      } else {
        // Go to home as ultimate fallback
        goNamed(RoutePath.home);
      }
    }
  }
}

/// Legacy compatibility
/// This maintains backward compatibility with your existing code
class LegacyAppRouter {
  static GoRouter get route => AppRouter.router;

  static final GoRouter initRoute = AppRouter.router;
}
