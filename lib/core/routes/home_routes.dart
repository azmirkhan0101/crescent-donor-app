import 'package:go_router/go_router.dart';
import 'package:cresent_charge_user_app/core/routes/route_config.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/core/routes/auth_guard.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';

// Import home/main app pages
import 'package:cresent_charge_user_app/features/home/pages/home_page.dart';
import 'package:cresent_charge_user_app/features/favorites/pages/favorites_page.dart';
import 'package:cresent_charge_user_app/features/donation/pages/donation_page.dart';
import 'package:cresent_charge_user_app/features/profile/pages/profile_page.dart';
import 'package:cresent_charge_user_app/features/main-layout/pages/main_layout_page.dart';

/// Home Routes Configuration
///
/// This class manages all routes related to the main application features.
/// Different routes have different authentication requirements:
/// - Guest allowed: Users can access via "Login as Guest"
/// - Auth required: Only fully authenticated users
/// - Strict auth: Sensitive features requiring full authentication
class HomeRoutes extends AppRouteConfig {
  @override
  List<RouteBase> get routes => [
    /// Shell route for main layout with bottom navigation
    /// Allows both authenticated users and guests
    ShellRoute(
      builder: (context, state, child) => MainLayoutPage(child: child),
      routes: [
        /// Home Page - Main dashboard
        /// GUEST ALLOWED: Users can access via "Login as Guest"
        GoRoute(
          name: RoutePath.home,
          path: RoutePath.home.addBasePath,
          builder: (context, state) => const HomePage(),
          // Allow both authenticated users and guests
          redirect: AuthGuard.guestAllowed.redirect,
        ),

        /// Favorites Page - User's favorite charities
        /// GUEST ALLOWED: Guests can view and save favorites locally
        GoRoute(
          name: RoutePath.favorites,
          path: RoutePath.favorites.addBasePath,
          builder: (context, state) => const FavoritesPage(),
          // Allow both authenticated users and guests
          redirect: AuthGuard.guestAllowed.redirect,
        ),

        /// Donation Page - Donation history and management
        /// AUTH REQUIRED: Donations require account for tracking and security
        GoRoute(
          name: RoutePath.donation,
          path: RoutePath.donation.addBasePath,
          builder: (context, state) => const DonationPage(),
          // Only authenticated users - no guest access for donations
          redirect: AuthGuard.authRequired.redirect,
        ),

        /// Profile Page - User account and settings
        /// AUTH REQUIRED: Profile management requires authentication
        GoRoute(
          name: RoutePath.profile,
          path: RoutePath.profile.addBasePath,
          builder: (context, state) => const ProfilePage(),
          // Only authenticated users - no guest access for profile
          redirect: AuthGuard.authRequired.redirect,
        ),
      ],
    ),

    // Additional routes that might be added in the future:
    //
    // Settings Page - Would use AuthGuard.authRequired
    // Help & Support - Would use AuthGuard.guestAllowed
    // Notifications - Would use AuthGuard.authRequired
    // Payment Methods - Would use AuthGuard.strictAuth
    // Admin Panel - Would use AuthGuard.strictAuth
  ];
}

/// Route metadata for home routes
class HomeRouteMeta {
  static const home = RouteMetadata(
    name: RoutePath.home,
    path: '/home',
    requiresAuth: true,
    redirectPath: '/login', // Redirect unauthenticated users to login
  );

  // TODO: Add metadata for additional home routes
}
