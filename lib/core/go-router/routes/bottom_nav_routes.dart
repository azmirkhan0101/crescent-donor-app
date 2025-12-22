import 'package:cresent_charge_user_app/core/go-router/config/route_config.dart';
import 'package:cresent_charge_user_app/core/go-router/guard/auth_guard.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/donation/pages/donation_page.dart';
import 'package:cresent_charge_user_app/features/home/pages/home_page.dart';
import 'package:cresent_charge_user_app/features/main-layout/pages/main_layout_page.dart';
import 'package:cresent_charge_user_app/features/profile/pages/profile_page.dart';
import 'package:cresent_charge_user_app/features/rewards/pages/your_rewards_page.dart';
import 'package:go_router/go_router.dart';

class BottomNavRoutes extends AppRouteConfig {
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
          builder: (context, state) => HomePage(),
          // Allow both authenticated users and guests
          redirect: AuthGuard.guestAllowed.redirect,
        ),

        /// Your Rewards Page - User's favorite charities
        /// GUEST ALLOWED: Guests can view and save favorites locally
        GoRoute(
          name: RoutePath.yourRewards,
          path: RoutePath.yourRewards.addBasePath,
          builder: (context, state) => const YourRewardsPage(),
          // Allow both authenticated users and guests
          redirect: AuthGuard.guestAllowed.redirect,
        ),

        /// Donation Page - Donation history and management
        /// AUTH REQUIRED: Donations require account for tracking and security
        GoRoute(
          name: RoutePath.donation,
          path: RoutePath.donation.addBasePath,
          builder: (context, state) => const DonationPage(),
          redirect: AuthGuard.authRequired.redirect,
        ),

        /// Profile Page - User profile and settings
        /// AUTH REQUIRED: Notifications are user-specific and require login
        GoRoute(
          name: RoutePath.profile,
          path: RoutePath.profile.addBasePath,
          builder: (context, state) => const ProfilePage(),
          redirect: AuthGuard.authRequired.redirect,
        ),
      ],
    ),
  ];
}
