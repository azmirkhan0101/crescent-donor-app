import 'package:go_router/go_router.dart';

/// Base class for defining route configurations
/// This makes it easier to organize and maintain routes
abstract class AppRouteConfig {
  /// List of routes for this module
  List<RouteBase> get routes;
}

/// Route metadata for better organization
class RouteMetadata {
  final String name;
  final String path;
  final bool requiresAuth;
  final String? redirectPath;

  const RouteMetadata({
    required this.name,
    required this.path,
    this.requiresAuth = false,
    this.redirectPath,
  });
}

/// Common route utilities
class RouteUtils {
  /// Helper method to create a GoRoute with consistent configuration
  static GoRoute createRoute({
    required String name,
    required String path,
    required GoRouterWidgetBuilder builder,
    bool requiresAuth = false,
    String? redirectPath,
  }) {
    return GoRoute(
      name: name,
      path: path,
      builder: builder,
      // We'll add auth guard logic here later
    );
  }
}
