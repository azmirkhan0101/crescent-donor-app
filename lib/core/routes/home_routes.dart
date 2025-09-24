import 'dart:core';

import 'package:cresent_charge_user_app/core/routes/auth_guard.dart';
import 'package:cresent_charge_user_app/core/routes/route_config.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/features/auth/pages/add_card_page.dart';
import 'package:cresent_charge_user_app/features/donation/pages/donation_page.dart';
import 'package:cresent_charge_user_app/features/donation/pages/organization_donations_page.dart';
import 'package:cresent_charge_user_app/features/donation/pages/recurring_donations_page.dart';
import 'package:cresent_charge_user_app/features/donation/pages/round_up_page.dart';
import 'package:cresent_charge_user_app/features/home/pages/charities_page.dart';
// Import home/main app pages
import 'package:cresent_charge_user_app/features/home/pages/home_page.dart';
import 'package:cresent_charge_user_app/features/home/pages/search_page.dart';
import 'package:cresent_charge_user_app/features/home/pages/verified_charities_page.dart';
import 'package:cresent_charge_user_app/features/main-layout/pages/main_layout_page.dart';
import 'package:cresent_charge_user_app/features/notification/pages/notification_page.dart';
import 'package:cresent_charge_user_app/features/organization/pages/confirm_donation_page.dart';
import 'package:cresent_charge_user_app/features/organization/pages/donation_complete_page.dart';
import 'package:cresent_charge_user_app/features/organization/pages/make_payment_page.dart';
import 'package:cresent_charge_user_app/features/organization/pages/organization_details_page.dart';
import 'package:cresent_charge_user_app/features/organization/pages/payment_linked_account_page.dart';
import 'package:cresent_charge_user_app/features/profile/pages/profile_page.dart';
import 'package:cresent_charge_user_app/features/rewards/pages/your_rewards_page.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:go_router/go_router.dart';

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
          // Only authenticated users - no guest access for donations
          redirect: AuthGuard.authRequired.redirect,
        ),

        /// Round Up Page - Round up details and activity
        /// AUTH REQUIRED: Round up details require account access
        GoRoute(
          name: RoutePath.roundUp,
          path: RoutePath.roundUp.addBasePath,
          builder: (context, state) => const RoundUpPage(),
          // Only authenticated users - no guest access for round up details
          redirect: AuthGuard.authRequired.redirect,
        ),

        /// Recurring Donations Page - Manage recurring donations
        /// AUTH REQUIRED: Recurring donations require account access
        GoRoute(
          name: RoutePath.recurringDonations,
          path: RoutePath.recurringDonations.addBasePath,
          builder: (context, state) => const RecurringDonationsPage(),
          // Only authenticated users - no guest access for recurring donations
          redirect: AuthGuard.authRequired.redirect,
        ),

        /// Organization Donations Page - Organization donation history
        /// AUTH REQUIRED: Donation history requires account access
        GoRoute(
          name: RoutePath.organizationDonations,
          path: RoutePath.organizationDonations.addBasePath,
          builder: (context, state) {
            final organizationId = state.pathParameters['organizationId'];
            return OrganizationDonationsPage(organizationId: organizationId);
          },
          // Only authenticated users - no guest access for donation history
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

    /// Search Page - User search functionality
    /// AUTH REQUIRED: Search is user-specific and requires login
    GoRoute(
      name: RoutePath.search,
      path: RoutePath.search.addBasePath,
      builder: (context, state) => const SearchPage(),
      redirect: AuthGuard.guestAllowed.redirect,
    ),

    /// Search Page - User search functionality
    /// AUTH REQUIRED: Search is user-specific and requires login
    GoRoute(
      name: RoutePath.charities,
      path: RoutePath.charities.addBasePath,
      builder: (context, state) => const CharitiesPage(),
      redirect: AuthGuard.guestAllowed.redirect,
    ),

    /// Search Page - User search functionality
    /// AUTH REQUIRED: Search is user-specific and requires login
    GoRoute(
      name: RoutePath.verifiedCharities,
      path: RoutePath.verifiedCharities.addBasePath,
      builder: (context, state) => const VerifiedCharitiesPage(),
      redirect: AuthGuard.guestAllowed.redirect,
    ),

    GoRoute(
      name: RoutePath.organizationDetails,
      path: RoutePath.organizationDetails.addBasePath,
      builder: (context, state) => const OrganizationDetailsPage(),
      redirect: AuthGuard.guestAllowed.redirect,
    ),

    GoRoute(
      name: RoutePath.linkedAccount,
      path: RoutePath.linkedAccount.addBasePath,
      builder: (context, state) => const PaymentLinkedAccountPage(),
      redirect: AuthGuard.authRequired.redirect,
    ),

    GoRoute(
      name: RoutePath.addNewCard,
      path: RoutePath.addNewCard.addBasePath,
      builder: (context, state) => AddCardPage(isAddNewCard: true),
      redirect: AuthGuard.authRequired.redirect,
    ),

    GoRoute(
      name: RoutePath.makePayment,
      path: RoutePath.makePayment.addBasePath,
      builder: (context, state) => const MakePaymentPage(),
      redirect: AuthGuard.authRequired.redirect,
    ),

    GoRoute(
      name: RoutePath.confirmDonation,
      path: RoutePath.confirmDonation.addBasePath,
      builder: (context, state) => const ConfirmDonationPage(),
      redirect: AuthGuard.authRequired.redirect,
    ),

    GoRoute(
      name: RoutePath.donationComplete,
      path: RoutePath.donationComplete.addBasePath,
      builder: (context, state) => const DonationCompletePage(),
      redirect: AuthGuard.authRequired.redirect,
    ),

    /// Notification Page - User notifications and alerts
    /// AUTH REQUIRED: Notifications are user-specific and require login
    GoRoute(
      name: RoutePath.notifications,
      path: RoutePath.notifications.addBasePath,
      builder: (context, state) => const NotificationsPage(),
      redirect: AuthGuard.authRequired.redirect,
    ),
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
