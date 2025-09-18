# 🔐 Authentication Guard System

This document explains how to properly configure authentication guards for different types of routes in your app.

## 🎯 Authentication Levels

Your app now supports **3 levels of access**:

1. **🌐 Public Routes** - No authentication required
2. **👤 Guest Access** - Basic access via "Login as Guest"  
3. **🔒 Full Authentication** - Complete login required

## 📋 Route Configuration Options

### 1. No Authentication Required

```dart
// Public routes - anyone can access
redirect: AuthGuard.noAuthRequired.redirect,
```

**Use for**: Welcome pages, help pages, terms & conditions

### 2. Guest Allowed

```dart
// Protected routes - authenticated users AND guests allowed
redirect: AuthGuard.guestAllowed.redirect,
```

**Use for**: Main app features that work for guests (Home, Favorites, Browse)

### 3. Authentication Required

```dart
// Protected routes - only authenticated users, NO guests
redirect: AuthGuard.authRequired.redirect,
```

**Use for**: Features requiring account (Donations, Profile, Settings)

### 4. Strict Authentication

```dart
// Sensitive routes - only fully authenticated users
redirect: AuthGuard.strictAuth.redirect,
```

**Use for**: Payment methods, admin features, sensitive data

## 🏠 Current Home Page Configuration

Based on your requirements, here's how the routes are configured:

```dart
// Home Page - GUEST ALLOWED ✅
// Users can access via "Login as Guest"
GoRoute(
  name: RoutePath.home,
  path: RoutePath.home.addBasePath,
  builder: (context, state) => const HomePage(),
  redirect: AuthGuard.guestAllowed.redirect, // 👤 Guests can browse
),

// Favorites Page - GUEST ALLOWED ✅  
// Guests can save favorites locally
GoRoute(
  name: RoutePath.favorites,
  path: RoutePath.favorites.addBasePath,
  builder: (context, state) => const FavoritesPage(),
  redirect: AuthGuard.guestAllowed.redirect, // 👤 Guests can favorite
),

// Donation Page - AUTH REQUIRED 🔒
// Donations need account for security/tracking
GoRoute(
  name: RoutePath.donation,
  path: RoutePath.donation.addBasePath,
  builder: (context, state) => const DonationPage(),
  redirect: AuthGuard.authRequired.redirect, // 🔒 Account required
),

// Profile Page - AUTH REQUIRED 🔒
// Profile management needs authentication
GoRoute(
  name: RoutePath.profile,
  path: RoutePath.profile.addBasePath,
  builder: (context, state) => const ProfilePage(),
  redirect: AuthGuard.authRequired.redirect, // 🔒 Account required
),
```

## 🚀 How "Login as Guest" Works

### 1. User Flow

```
1. User opens app → Login Page
2. User taps "Login as Guest" 
3. AuthGuard.setGuestMode(true) is called
4. User navigates to Home Page
5. Home/Favorites accessible, Donation/Profile require login
```

### 2. Code Implementation

```dart
// In login_page.dart
CustomPrimaryButton(
  title: "Login as a Guest",
  onTap: () async {
    // Set guest mode
    await AuthGuard.setGuestMode(true);
    
    // Navigate to home
    if (mounted) {
      context.pushNamed(RoutePath.home);
    }
  },
),
```

### 3. What Guests Can Do

- ✅ Browse home page
- ✅ View charities and causes  
- ✅ Save favorites (locally)
- ✅ Explore content
- ❌ Make donations (requires account)
- ❌ Access profile (requires account)

## 🔄 Navigation Behavior

### From Guest → Auth Required Route

```
Guest user taps "Donation" tab
→ AuthGuard detects no authentication
→ Redirects to Login Page
→ User can login or go back
```

### From Authenticated → Auth Pages

```
Logged-in user visits /login  
→ AuthGuard detects authentication
→ Redirects to Home Page
→ No need to login again
```

## 🛠️ Implementation Examples

### Adding a New Route

#### Example 1: Settings Page (Auth Required)

```dart
GoRoute(
  name: 'settings',
  path: '/settings',
  builder: (context, state) => const SettingsPage(),
  redirect: AuthGuard.authRequired.redirect, // 🔒 Account needed
),
```

#### Example 2: Help Page (Public)  

```dart
GoRoute(
  name: 'help',
  path: '/help', 
  builder: (context, state) => const HelpPage(),
  redirect: AuthGuard.noAuthRequired.redirect, // 🌐 Anyone can access
),
```

#### Example 3: Charity Details (Guest Allowed)

```dart
GoRoute(
  name: 'charityDetails',
  path: '/charity/:id',
  builder: (context, state) => CharityDetailsPage(
    charityId: state.pathParameters['id']!,
  ),
  redirect: AuthGuard.guestAllowed.redirect, // 👤 Guests can browse
),
```

## 🔧 Customizing Authentication Logic

### Checking User Status in Widgets

```dart
// Check if user is authenticated
bool isAuth = await AuthGuard.isAuthenticated();

// Check if user is guest
bool isGuest = await AuthGuard.isGuestMode();

// Check if user has any access
bool hasAccess = await AuthGuard.hasAccess();
```

### Setting Authentication States

```dart
// Set guest mode
await AuthGuard.setGuestMode(true);

// Clear all auth states (logout)
await AuthGuard.clearAuthStates();

// Set authentication token (real login)
await SharePrefsHelper.setString(AppConstants.token, 'user_token');
```

## 🎛️ UI Adaptations

### Conditional UI Based on Auth Status

```dart
// In your widgets
Widget build(BuildContext context) {
  return FutureBuilder<bool>(
    future: AuthGuard.isAuthenticated(),
    builder: (context, snapshot) {
      bool isAuth = snapshot.data ?? false;
      
      return Column(
        children: [
          // Always show
          CharityListWidget(),
          
          // Only for authenticated users
          if (isAuth) 
            DonationHistoryWidget(),
            
          // Only for guests
          if (!isAuth)
            SignUpPromptWidget(),
        ],
      );
    },
  );
}
```

### Navigation Prompts

```dart
// Show login prompt for restricted actions
void onDonatePressed() async {
  bool hasAccess = await AuthGuard.hasAccess();
  bool isAuth = await AuthGuard.isAuthenticated();
  
  if (!isAuth) {
    // Show login prompt
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Account Required'),
        content: Text('Please create an account to make donations.'),
        actions: [
          TextButton(
            onPressed: () => context.goNamed(RoutePath.login),
            child: Text('Login'),
          ),
        ],
      ),
    );
  } else {
    // Proceed with donation
    proceedToDonation();
  }
}
```

## 📊 Route Protection Summary

| Route | Guest Access | Auth Required | Use Case |
|-------|-------------|---------------|-----------|
| Home | ✅ Yes | ❌ No | Browse content |
| Favorites | ✅ Yes | ❌ No | Save locally |
| Donation | ❌ No | ✅ Yes | Financial security |
| Profile | ❌ No | ✅ Yes | Account management |
| Settings | ❌ No | ✅ Yes | User preferences |
| Help | ✅ Yes | ❌ No | Public information |

## 🔄 Migration Guide

### From Old System

```dart
// OLD WAY
redirect: AuthGuard.createRedirect(requiresAuth: true),

// NEW WAY  
redirect: AuthGuard.guestAllowed.redirect,    // Guest allowed
redirect: AuthGuard.authRequired.redirect,    // Auth required
```

### Benefits of New System

- ✅ Clear intent with predefined configs
- ✅ Guest mode support built-in
- ✅ Better documentation and understanding
- ✅ Easier to modify auth requirements
- ✅ Consistent behavior across routes

---

This system gives you complete control over which routes require authentication and which allow guest access, making your app more accessible while keeping sensitive features protected! 🎉
