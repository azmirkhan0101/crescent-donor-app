import 'package:cresent_charge_user_app/features/onboarding/pages/get_start_page.dart';
import 'package:go_router/go_router.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';

class AppRouter {
  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutePath.onboardingPage.addBasePath,
    // navigatorKey: Get.key,
    debugLogDiagnostics: true,
    routes: [
      ///======================= splash Route =======================
      GoRoute(
        name: RoutePath.onboardingPage,
        path: RoutePath.onboardingPage.addBasePath,
        builder: (context, state) => const OnboardingPage(),
        // redirect: (context, state) {
        //   // Future.delayed(const Duration(seconds: 1), () {
        //   //   AppRouter.route.replaceNamed(RoutePath.chooseRole);
        //   // });
        //   // return null;
        // },
      ),
    ],
  );

  static GoRouter get route => initRoute;
}
