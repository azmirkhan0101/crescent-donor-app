import 'package:cresent_charge_user_app/core/go-router/config/route_config.dart';
import 'package:cresent_charge_user_app/core/go-router/guard/auth_guard.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/round_up_controller.dart';
import 'package:cresent_charge_user_app/features/profile/pages/edit_profile_page.dart';
import 'package:cresent_charge_user_app/features/profile/pages/notification_settings_page.dart';
import 'package:cresent_charge_user_app/features/profile/pages/transaction_history_page.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:go_router/go_router.dart';

class ProfileRoutes extends AppRouteConfig {
  @override
  List<RouteBase> get routes => [
    /// Edit Profile Page
    GoRoute(
      name: RoutePath.editProfile,
      path: RoutePath.editProfile.addBasePath,
      builder: (context, state) => const EditProfilePage(),
      redirect: AuthGuard.guestAllowed.redirect,
    ),

    // Notification Settings
    GoRoute(
      name: RoutePath.notificationSettings,
      path: RoutePath.notificationSettings.addBasePath,
      builder: (context, state) => const NotificationSettingsPage(),
      redirect: AuthGuard.guestAllowed.redirect,
    ),

    // Transaction History
    GoRoute(
      name: RoutePath.transactionHistory,
      path: RoutePath.transactionHistory.addBasePath,
      builder: (context, state) =>
          TransactionHistoryPage(controller: RoundUpController()),
      redirect: AuthGuard.guestAllowed.redirect,
    ),
  ];
}
