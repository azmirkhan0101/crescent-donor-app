# 🚀 Modular Routing Architecture

This document explains the new modular routing structure that makes navigation easier to understand, maintain, and extend.

## 📁 File Structure

```
lib/core/routes/
├── app_router.dart          # Main router that combines all modules
├── route_config.dart        # Base configuration and utilities  
├── route_path.dart          # Route path constants (existing)
├── auth_guard.dart          # Authentication protection
├── onboarding_routes.dart   # Onboarding flow routes
├── auth_routes.dart         # Authentication routes
├── home_routes.dart         # Main app routes
└── routes.dart              # (Legacy - can be removed)
```

## 🎯 Key Benefits

### 1. **Beginner Friendly**

- Clear separation by feature
- Extensive documentation in code
- Easy to understand which routes belong where

### 2. **Maintainable**

- Each feature has its own route file
- Changes to one feature don't affect others
- Easy to add new features

### 3. **Scalable**

- Add new route modules easily
- Authentication guards built-in
- Consistent error handling

## 🔧 How to Use

### Basic Navigation

```dart
// Navigate to login
context.pushNamed(RoutePath.login);

// Navigate to home
context.pushNamed(RoutePath.home);
```

### Adding New Routes

#### 1. Create a new route module (if needed)

```dart
// lib/core/routes/profile_routes.dart
class ProfileRoutes extends AppRouteConfig {
  @override
  List<RouteBase> get routes => [
    GoRoute(
      name: RoutePath.profile,
      path: RoutePath.profile.addBasePath,
      builder: (context, state) => const ProfilePage(),
      redirect: AuthGuard.createRedirect(requiresAuth: true),
    ),
  ];
}
```

#### 2. Add route path constant

```dart
// lib/core/routes/route_path.dart
static const String profile = 'profile';
```

#### 3. Register in main router

```dart
// lib/core/routes/app_router.dart
static final _profileRoutes = ProfileRoutes();

// Add to routes list
..._profileRoutes.routes,
```

## 🔐 Authentication Guards

### Protected Routes

Routes that require authentication:

```dart
GoRoute(
  name: RoutePath.home,
  path: RoutePath.home.addBasePath,
  builder: (context, state) => const HomePage(),
  redirect: AuthGuard.createRedirect(requiresAuth: true), // Protected
),
```

### Public Routes

Routes that don't require authentication:

```dart
GoRoute(
  name: RoutePath.login,
  path: RoutePath.login.addBasePath,
  builder: (context, state) => const LoginPage(),
  redirect: AuthGuard.createRedirect(requiresAuth: false), // Public
),
```

## 📋 Route Categories

### 🎬 Onboarding Routes (`onboarding_routes.dart`)

- **Purpose**: App introduction for new users
- **Authentication**: Not required
- **Routes**:
  - Get Started Page - First screen users see
  - How to Work Page - Explains app functionality

### 🔑 Authentication Routes (`auth_routes.dart`)

- **Purpose**: User authentication and account setup
- **Authentication**: Not required (but redirects authenticated users)
- **Routes**:
  - Login Page - User sign in
  - Signup Page - New user registration
  - Few Details Page - Additional user info
  - Upload Profile Picture - Avatar setup
  - Add Card Page - Payment method setup
  - Terms Agreement - Legal agreement
  - Forgot Password - Password recovery initiation
  - Verify OTP - Code verification
  - Reset Password - New password creation

### 🏠 Home Routes (`home_routes.dart`)

- **Purpose**: Main application features
- **Authentication**: Required (redirects unauthenticated users to login)
- **Routes**:
  - Home Page - Main dashboard

## 🛠️ Development Tips

### Adding Authentication Logic

Modify `auth_guard.dart` to customize authentication checks:

```dart
static Future<bool> isAuthenticated() async {
  // Your authentication logic here
  final token = await SharePrefsHelper.getString(AppConstants.token);
  return token.isNotEmpty;
}
```

### Debugging Routes

Use the helper methods in `AppRouter`:

```dart
// Check if route exists
if (AppRouter.routeExists('login')) {
  // Route exists
}

// Get all routes for debugging
final allRoutes = AppRouter.getAllRoutes();
print(allRoutes);
```

### Error Handling

The router includes built-in error handling for unknown routes:

- Shows a user-friendly "Page Not Found" screen
- Provides a "Go Home" button
- Displays the attempted route path

## 🔄 Migration from Old Structure

The new structure maintains backward compatibility:

```dart
// Old way (still works)
AppRouter.route

// New way (recommended)
AppRouter.router
```

## 📱 Best Practices

1. **Group related routes** in the same module
2. **Use descriptive comments** for each route
3. **Apply authentication guards** consistently
4. **Test navigation flows** after adding routes
5. **Keep route paths simple** and predictable

## 🚨 Common Issues

### Route Not Found

- Check if route is registered in the correct module
- Verify route path matches the constant
- Ensure module is included in `app_router.dart`

### Authentication Issues

- Check `auth_guard.dart` logic
- Verify token storage/retrieval
- Test with different authentication states

### Navigation Conflicts

- Use `context.pushNamed()` for simple navigation
- Use `GoRouter.of(context).go()` for specific cases
- Avoid conflicting extension methods

---

This modular approach makes the routing system more maintainable, scalable, and beginner-friendly while providing powerful features like authentication guards and error handling.
