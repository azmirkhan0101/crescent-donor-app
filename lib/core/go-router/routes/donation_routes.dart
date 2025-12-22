import 'package:cresent_charge_user_app/core/go-router/config/route_config.dart';
import 'package:cresent_charge_user_app/core/go-router/guard/auth_guard.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/donation/pages/badges_page.dart';
import 'package:cresent_charge_user_app/features/donation/pages/one_time_page.dart';
import 'package:cresent_charge_user_app/features/donation/pages/organization_donations_page.dart';
import 'package:cresent_charge_user_app/features/donation/pages/recurring_donations_page.dart';
import 'package:cresent_charge_user_app/features/donation/pages/round_up_page.dart';
import 'package:cresent_charge_user_app/features/donation/pages/settings_page.dart';
import 'package:go_router/go_router.dart';

class DonationRoutes extends AppRouteConfig {
  @override
  List<RouteBase> get routes => [
    /// Organization Donations Page - Organization donation history
    /// AUTH REQUIRED: Donation history requires account access
    GoRoute(
      name: RoutePath.organizationDonations,
      path: RoutePath.organizationDonations.addBasePath,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final organizationId = extra?['organizationId'] as String;
        return OrganizationDonationsPage(organizationId: organizationId);
      },
      // Only authenticated users - no guest access for donation history
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

    /// Round Up Settings Page - Configure round-up donation settings
    /// AUTH REQUIRED: Round up settings require account access
    GoRoute(
      name: RoutePath.settings,
      path: RoutePath.settings.addBasePath,
      builder: (context, state) {
        bool isRecurring = state.extra != null && state.extra as bool;
        return SettingsPage(isRecurring: isRecurring);
      },
      // Only authenticated users - no guest access for round up settings
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

    /// One Time Page - One time donation details and activity
    /// AUTH REQUIRED: One time donation details require account access
    GoRoute(
      name: RoutePath.oneTime,
      path: RoutePath.oneTime.addBasePath,
      builder: (context, state) => OneTimePage(),
      // Only authenticated users - no guest access for one time donation details
      redirect: AuthGuard.authRequired.redirect,
    ),

    /// Badges Page - Badges details and activity
    /// AUTH REQUIRED: Badges details require account access
    GoRoute(
      name: RoutePath.badges,
      path: RoutePath.badges.addBasePath,
      builder: (context, state) => BadgesPage(),
      // Only authenticated users - no guest access for badges details
      redirect: AuthGuard.authRequired.redirect,
    ),
  ];
}
