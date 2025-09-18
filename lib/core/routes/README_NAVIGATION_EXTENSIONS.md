# 🧭 AppRouter Navigation Extensions Guide

This guide explains how to use the navigation extensions provided in `AppRouter` for safe and convenient routing.

## 📋 Available Navigation Methods

### 1. Static AppRouter Extensions

#### `AppRouterExtension.navigateToRoute()`

```dart
// Push a new route onto the stack
AppRouterExtension.navigateToRoute(context, RoutePath.home);
AppRouterExtension.navigateToRoute(context, RoutePath.login);
```

#### `AppRouterExtension.goToRoute()`

```dart
// Replace current route (no back button)
AppRouterExtension.goToRoute(context, RoutePath.home);
AppRouterExtension.goToRoute(context, RoutePath.login);
```

### 2. BuildContext Extensions (Recommended)

#### `context.safeNavigateToRoute()`

```dart
// Safe navigation with existence check
context.safeNavigateToRoute(RoutePath.home);
context.safeNavigateToRoute(RoutePath.profile);

// If route doesn't exist, logs warning instead of crashing
context.safeNavigateToRoute('nonExistentRoute'); // ⚠️ Logs warning
```

#### `context.safeGoToRoute()`

```dart
// Safe replacement navigation
context.safeGoToRoute(RoutePath.login);
context.safeGoToRoute(RoutePath.home);
```

#### `context.navigateToRouteWithFallback()`

```dart
// Navigation with fallback options
context.navigateToRouteWithFallback(
  RoutePath.profile,
  fallbackRoute: RoutePath.home, // If profile doesn't exist, go to home
);

// Ultimate fallback to home if both routes don't exist
context.navigateToRouteWithFallback('nonExistentRoute');
```

## 🎯 Usage Examples

### Example 1: Button Navigation

```dart
// In any widget with BuildContext
ElevatedButton(
  onPressed: () {
    // Method 1: Direct context extension (Recommended)
    context.safeNavigateToRoute(RoutePath.profile);
    
    // Method 2: Static extension
    AppRouterExtension.navigateToRoute(context, RoutePath.profile);
    
    // Method 3: Traditional GoRouter (Still works)
    context.pushNamed(RoutePath.profile);
  },
  child: Text('Go to Profile'),
)
```

### Example 2: Conditional Navigation

```dart
void navigateBasedOnUserType() {
  if (userIsGuest) {
    // Navigate to guest-friendly page
    context.safeNavigateToRoute(RoutePath.home);
  } else if (userIsAuthenticated) {
    // Navigate to authenticated user page
    context.safeNavigateToRoute(RoutePath.profile);
  } else {
    // Fallback to login
    context.safeGoToRoute(RoutePath.login);
  }
}
```

### Example 3: Error-Safe Navigation

```dart
// In a dynamic route scenario
void navigateToFeature(String featureRoute) {
  context.navigateToRouteWithFallback(
    featureRoute,
    fallbackRoute: RoutePath.home,
  );
}

// Usage
navigateToFeature('experimental_feature'); // Safe even if route doesn't exist
```

### Example 4: Bottom Navigation Implementation

```dart
// In your bottom navigation widget
void onTabTapped(int index) {
  final routes = [
    RoutePath.home,
    RoutePath.favorites,
    RoutePath.donation,
    RoutePath.profile,
  ];
  
  // Safe navigation to tab route
  context.safeGoToRoute(routes[index]);
}
```

## 🆚 Method Comparison

| Method | Behavior | Use Case | Safety |
|--------|----------|----------|--------|
| `context.pushNamed()` | Push to stack | Traditional GoRouter | ❌ Can crash |
| `context.goNamed()` | Replace current | Traditional GoRouter | ❌ Can crash |
| `context.safeNavigateToRoute()` | Push to stack | Safe navigation | ✅ Logs warning |
| `context.safeGoToRoute()` | Replace current | Safe navigation | ✅ Logs warning |
| `context.navigateToRouteWithFallback()` | Push with fallback | Critical flows | ✅ Always navigates |

## 🎯 Best Practices

### 1. Use BuildContext Extensions (Recommended)

```dart
// ✅ Good - Clean and safe
context.safeNavigateToRoute(RoutePath.home);

// ❌ Verbose - Works but longer
AppRouterExtension.navigateToRoute(context, RoutePath.home);
```

### 2. Use Fallbacks for Critical Navigation

```dart
// ✅ Good - For critical flows like authentication
context.navigateToRouteWithFallback(
  RoutePath.userDashboard,
  fallbackRoute: RoutePath.home,
);

// ❌ Risky - Might fail silently
context.safeNavigateToRoute(RoutePath.userDashboard);
```

### 3. Choose Right Navigation Type

#### Push (Add to Stack) - Use `navigateToRoute`

```dart
// User can press back button
context.safeNavigateToRoute(RoutePath.profile);
context.safeNavigateToRoute(RoutePath.settings);
```

#### Replace (No Back) - Use `goToRoute`

```dart
// For major flow changes (login → home)
context.safeGoToRoute(RoutePath.home);
context.safeGoToRoute(RoutePath.login);
```

## 🔧 Custom Navigation Helpers

You can also create your own navigation helpers:

```dart
// In your widgets or controllers
class NavigationHelper {
  static void goHome(BuildContext context) {
    context.safeGoToRoute(RoutePath.home);
  }
  
  static void goToAuthFlow(BuildContext context) {
    context.safeGoToRoute(RoutePath.login);
  }
  
  static void goToProfile(BuildContext context) {
    context.navigateToRouteWithFallback(
      RoutePath.profile,
      fallbackRoute: RoutePath.home,
    );
  }
}

// Usage
NavigationHelper.goHome(context);
NavigationHelper.goToProfile(context);
```

## 🐛 Error Handling

### Route Existence Check

```dart
// Check if route exists before navigation
if (AppRouter.routeExists(RoutePath.someRoute)) {
  context.pushNamed(RoutePath.someRoute);
} else {
  // Handle non-existent route
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Feature Not Available'),
      content: Text('This feature is coming soon!'),
    ),
  );
}
```

### Safe Navigation with User Feedback

```dart
void navigateWithFeedback(String routeName) {
  if (AppRouter.routeExists(routeName)) {
    context.safeNavigateToRoute(routeName);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Feature not available yet'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
```

## 🎮 Real-World Usage Examples

### Login Page

```dart
// In login_page.dart
CustomPrimaryButton(
  title: "Login",
  onTap: () async {
    // Authenticate user...
    if (loginSuccessful) {
      context.safeGoToRoute(RoutePath.home);
    }
  },
),

CustomPrimaryButton(
  title: "Login as Guest",
  onTap: () async {
    await AuthGuard.setGuestMode(true);
    context.safeGoToRoute(RoutePath.home);
  },
),
```

### Bottom Navigation

```dart
// In bottom_nav.dart
GestureDetector(
  onTap: () {
    context.safeGoToRoute(RoutePath.home);
  },
  child: NavIcon(...),
)
```

### Settings Menu

```dart
// In settings_page.dart
ListTile(
  title: Text('Profile'),
  onTap: () => context.safeNavigateToRoute(RoutePath.profile),
),
ListTile(
  title: Text('Help'),
  onTap: () => context.navigateToRouteWithFallback(
    RoutePath.help,
    fallbackRoute: RoutePath.home,
  ),
),
```

---

## 🎉 Summary

The AppRouter extensions provide **safe, convenient navigation** with built-in error handling:

- ✅ **Safer** than raw GoRouter calls
- ✅ **Cleaner** syntax with BuildContext extensions  
- ✅ **Fallback** options for critical flows
- ✅ **Debug-friendly** with helpful error messages
- ✅ **Flexible** - choose the right method for your use case

**Recommended Usage**: Use `context.safeNavigateToRoute()` for most cases, and `context.navigateToRouteWithFallback()` for critical navigation flows!
