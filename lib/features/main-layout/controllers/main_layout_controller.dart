import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:get/get.dart';

/// Main Layout Controller
///
/// This controller manages the state of the main layout including
/// bottom navigation, current tab selection, and any shared state
/// across the main app sections.
class MainLayoutController extends GetxController {

  /// Currently selected tab index
  final RxInt selectedIndex = 0.obs;

  /// Available navigation tabs with their corresponding routes
  final List<String> navigationRoutes = [
    RoutePath.home,
    RoutePath.yourRewards,
    RoutePath.donation,
    RoutePath.profile,
  ];

  /// Change the selected tab based on current route
  void updateTabFromRoute(String route) {
    // Remove the leading '/' and find the matching route
    String cleanRoute = route.startsWith('/') ? route.substring(1) : route;
    int index = navigationRoutes.indexOf(cleanRoute);
    if (index != -1) {
      selectedIndex.value = index;
    }
  }

  /// Get the current tab route
  String get currentTabRoute => navigationRoutes[selectedIndex.value];

  /// Check if a specific tab is selected
  bool isTabSelected(int index) => selectedIndex.value == index;

  /// Get route for a specific tab index
  String getRouteForIndex(int index) {
    if (index >= 0 && index < navigationRoutes.length) {
      return navigationRoutes[index];
    }
    return RoutePath.home;
  }
}
