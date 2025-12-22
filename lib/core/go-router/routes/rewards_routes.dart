import 'package:cresent_charge_user_app/core/go-router/config/route_config.dart';
import 'package:cresent_charge_user_app/core/go-router/guard/auth_guard.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/rewards/pages/redeem_error_page.dart';
import 'package:cresent_charge_user_app/features/rewards/pages/redeem_success_page.dart';
import 'package:cresent_charge_user_app/features/rewards/pages/store_profile_page.dart';
import 'package:go_router/go_router.dart';

class RewardsRoutes extends AppRouteConfig {
  @override
  List<RouteBase> get routes => [
    // normal routes
    GoRoute(
      name: RoutePath.storeProfile,
      path: RoutePath.storeProfile.addBasePath,
      builder: (context, state) {
        String? storeId = state.extra as String;
        return StoreProfilePage(storeId: storeId);
      },
      redirect: AuthGuard.authRequired.redirect,
    ),

    GoRoute(
      name: RoutePath.redeemSuccess,
      path: RoutePath.redeemSuccess.addBasePath,
      builder: (context, state) {
        return const RedeemSuccessPage();
      },
      redirect: AuthGuard.authRequired.redirect,
    ),

    GoRoute(
      name: RoutePath.redeemFailure,
      path: RoutePath.redeemFailure.addBasePath,
      builder: (context, state) {
        return const RedeemErrorPage();
      },
      redirect: AuthGuard.authRequired.redirect,
    ),
  ];
}
