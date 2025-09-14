import 'package:go_router/go_router.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/presentation/screens/splash_screen/splash_screen.dart';

class AppRouter {
  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutePath.splashScreen.addBasePath,
    // navigatorKey: Get.key,
    debugLogDiagnostics: true,
    routes: [
      ///======================= splash Route =======================
      GoRoute(
        name: RoutePath.splashScreen,
        path: RoutePath.splashScreen.addBasePath,
        builder: (context, state) => const SplashScreen(),
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
