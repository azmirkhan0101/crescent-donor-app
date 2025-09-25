import 'package:go_router/go_router.dart';
import 'package:cresent_charge_user_app/core/go-router/config/route_config.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';

// Import onboarding pages
import 'package:cresent_charge_user_app/features/onboarding/pages/get_start_page.dart';
import 'package:cresent_charge_user_app/features/onboarding/pages/how_to_work_page.dart';

/// Onboarding Routes Configuration
///
/// This class manages all routes related to the onboarding flow.
/// Onboarding routes are typically shown to new users who haven't
/// completed the app introduction process.
class OnboardingRoutes extends AppRouteConfig {
  @override
  List<RouteBase> get routes => [
    /// Get Started Page - The first screen users see
    /// This is the app's entry point for new users
    GoRoute(
      name: RoutePath.getStartPage,
      path: RoutePath.getStartPage.addBasePath,
      builder: (context, state) => const GetStartPage(),
      // No auth required for onboarding
    ),

    /// How It Works Page - Explains app functionality
    /// Shows users how the app works before they sign up
    GoRoute(
      name: RoutePath.howToWorkPage,
      path: RoutePath.howToWorkPage.addBasePath,
      builder: (context, state) => const HowToWorkPage(),
      // No auth required for onboarding
    ),
  ];
}

/// Route metadata for onboarding routes
class OnboardingRouteMeta {
  static const getStartPage = RouteMetadata(
    name: RoutePath.getStartPage,
    path: '/getStartPage',
    requiresAuth: false,
  );

  static const howToWorkPage = RouteMetadata(
    name: RoutePath.howToWorkPage,
    path: '/howToWorkPage',
    requiresAuth: false,
  );
}
