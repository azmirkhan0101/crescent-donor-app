import 'dart:core';

import 'package:cresent_charge_user_app/core/go-router/config/route_config.dart';
import 'package:cresent_charge_user_app/core/go-router/guard/auth_guard.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/home/pages/charities_page.dart';
import 'package:cresent_charge_user_app/features/home/pages/search_page.dart';
import 'package:cresent_charge_user_app/features/home/pages/verified_charities_page.dart';
import 'package:cresent_charge_user_app/features/notification/pages/notification_page.dart';
import 'package:cresent_charge_user_app/features/payment/screens/add_card_page.dart';
import 'package:cresent_charge_user_app/features/organization/pages/confirm_donation_page.dart';
import 'package:cresent_charge_user_app/features/organization/pages/donation_complete_page.dart';
import 'package:cresent_charge_user_app/features/payment/screens/make_payment_page.dart';
import 'package:cresent_charge_user_app/features/organization/pages/organization_details_page.dart';
import 'package:cresent_charge_user_app/features/payment/screens/payment_linked_account_page.dart';
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
    /// Search Page
    GoRoute(
      name: RoutePath.search,
      path: RoutePath.search.addBasePath,
      builder: (context, state) => const SearchPage(),
      redirect: AuthGuard.guestAllowed.redirect,
    ),

    /// Charities Page
    GoRoute(
      name: RoutePath.charities,
      path: RoutePath.charities.addBasePath,
      builder: (context, state) => const CharitiesPage(),
      redirect: AuthGuard.guestAllowed.redirect,
    ),

    /// Verified Charities Page
    GoRoute(
      name: RoutePath.verifiedCharities,
      path: RoutePath.verifiedCharities.addBasePath,
      builder: (context, state) => const VerifiedCharitiesPage(),
      redirect: AuthGuard.guestAllowed.redirect,
    ),

    /// Organization Details Page
    GoRoute(
      name: RoutePath.organizationDetails,
      path: RoutePath.organizationDetails.addBasePath,
      builder: (context, state) => const OrganizationDetailsPage(),
      redirect: AuthGuard.guestAllowed.redirect,
    ),

    /// Payment Linked Account Page
    GoRoute(
      name: RoutePath.linkedAccount,
      path: RoutePath.linkedAccount.addBasePath,
      builder: (context, state) => const PaymentLinkedAccountPage(),
      redirect: AuthGuard.authRequired.redirect,
    ),

    /// Add New Card Page
    GoRoute(
      name: RoutePath.addNewCard,
      path: RoutePath.addNewCard.addBasePath,
      builder: (context, state) => const AddCardPage(),
      redirect: AuthGuard.authRequired.redirect,
    ),

    /// Make Payment Page
    GoRoute(
      name: RoutePath.makePayment,
      path: RoutePath.makePayment.addBasePath,
      builder: (context, state) => const MakePaymentPage(),
      redirect: AuthGuard.authRequired.redirect,
    ),

    /// Confirm Donation Page
    GoRoute(
      name: RoutePath.confirmDonation,
      path: RoutePath.confirmDonation.addBasePath,
      builder: (context, state) {
        final paymentMethodId = state.uri.queryParameters['paymentMethodId'];
        return ConfirmDonationPage(paymentMethodId: paymentMethodId);
      },
      redirect: AuthGuard.authRequired.redirect,
    ),

    /// Donation Complete Page
    GoRoute(
      name: RoutePath.donationComplete,
      path: RoutePath.donationComplete.addBasePath,
      builder: (context, state) => const DonationCompletePage(),
      redirect: AuthGuard.authRequired.redirect,
    ),

    /// Notification Page
    GoRoute(
      name: RoutePath.notifications,
      path: RoutePath.notifications.addBasePath,
      builder: (context, state) => const NotificationsPage(),
      redirect: AuthGuard.authRequired.redirect,
    ),
  ];
}
