import 'package:cresent_charge_user_app/core/go-router/config/route_config.dart';
import 'package:cresent_charge_user_app/core/go-router/guard/auth_guard.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/pages/add_card_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/few_details_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/forgot_password_page.dart';
// Import authentication pages
import 'package:cresent_charge_user_app/features/auth/pages/login_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/reset_password_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/signup_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/terms_agreement_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/upload_profile_picture_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/verify_otp_page.dart';
import 'package:go_router/go_router.dart';

/// Authentication Routes Configuration
///
/// This class manages all routes related to user authentication and account setup.
/// These routes handle login, signup, password reset, and user profile setup.
class AuthRoutes extends AppRouteConfig {
  @override
  List<RouteBase> get routes => [
    /// Login Page - User authentication
    /// Users enter their credentials to access the app
    GoRoute(
      name: RoutePath.login,
      path: RoutePath.login.addBasePath,
      builder: (context, state) => const LoginPage(),
      // Redirect authenticated users away from login
      redirect: AuthGuard.createRedirect(requiresAuth: false),
    ),

    /// Signup Page - New user registration
    /// First step in the user registration process
    GoRoute(
      name: RoutePath.signup,
      path: RoutePath.signup.addBasePath,
      builder: (context, state) => const SignupPage(),
      redirect: AuthGuard.createRedirect(requiresAuth: false),
    ),

    /// Few Details Page - Additional user information
    /// Collects basic user details after initial signup
    GoRoute(
      name: RoutePath.fewDetails,
      path: RoutePath.fewDetails.addBasePath,
      builder: (context, state) => const FewDetailsPage(),
      // This is part of the signup flow, so no auth needed yet
    ),

    /// Upload Profile Picture Page - User avatar setup
    /// Allows users to upload their profile picture
    GoRoute(
      name: RoutePath.uploadProfilePicture,
      path: RoutePath.uploadProfilePicture.addBasePath,
      builder: (context, state) => const UploadProfilePicturePage(),
      // Part of signup flow
    ),

    /// Add Card Page - Payment method setup
    /// Users add their payment information
    GoRoute(
      name: RoutePath.addCard,
      path: RoutePath.addCard.addBasePath,
      builder: (context, state) => const AddCardPage(),
      // Part of signup flow
    ),

    /// Terms Agreement Page - Legal agreement
    /// Users must accept terms and conditions
    GoRoute(
      name: RoutePath.termsAgreement,
      path: RoutePath.termsAgreement.addBasePath,
      builder: (context, state) => const TermsAgreementPage(),
      // Part of signup flow
    ),

    /// Forgot Password Page - Password recovery initiation
    /// Users request password reset
    GoRoute(
      name: RoutePath.forgotPassword,
      path: RoutePath.forgotPassword.addBasePath,
      builder: (context, state) => const ForgotPasswordPage(),
      redirect: AuthGuard.createRedirect(requiresAuth: false),
    ),

    /// Verify OTP Page - Code verification
    /// Users enter the verification code sent to their email/phone
    GoRoute(
      name: RoutePath.verifyOtp,
      path: RoutePath.verifyOtp.addBasePath,
      builder: (context, state) {
        // if email not passed, throw error
        if (state.extra == null) {
          throw Exception('Email is required to verify OTP');
        }

        final email = (state.extra as Map<String, dynamic>)['email'] as String;
        final isForSignup =
            state.extra != null && state.extra is Map<String, dynamic>
            ? (state.extra as Map<String, dynamic>)['isForSignup'] as bool? ??
                  false
            : false;

        return VerifyOtpPage(email: email, isForSignup: isForSignup);
      },
      // Part of password reset flow
    ),

    /// Reset Password Page - New password creation
    /// Users create a new password after verification
    GoRoute(
      name: RoutePath.resetPassword,
      path: RoutePath.resetPassword.addBasePath,
      builder: (context, state) => const ResetPasswordPage(),
      // Part of password reset flow
    ),
  ];
}

/// Route metadata for authentication routes
class AuthRouteMeta {
  static const login = RouteMetadata(
    name: RoutePath.login,
    path: '/login',
    requiresAuth: false,
    redirectPath: '/home', // Redirect authenticated users to home
  );

  static const signup = RouteMetadata(
    name: RoutePath.signup,
    path: '/signup',
    requiresAuth: false,
    redirectPath: '/home',
  );

  static const fewDetails = RouteMetadata(
    name: RoutePath.fewDetails,
    path: '/fewDetails',
    requiresAuth: false,
  );

  static const uploadProfilePicture = RouteMetadata(
    name: RoutePath.uploadProfilePicture,
    path: '/uploadProfilePicture',
    requiresAuth: false,
  );

  static const addCard = RouteMetadata(
    name: RoutePath.addCard,
    path: '/addCard',
    requiresAuth: false,
  );

  static const termsAgreement = RouteMetadata(
    name: RoutePath.termsAgreement,
    path: '/termsAgreement',
    requiresAuth: false,
  );

  static const forgotPassword = RouteMetadata(
    name: RoutePath.forgotPassword,
    path: '/forgotPassword',
    requiresAuth: false,
  );

  static const verifyOtp = RouteMetadata(
    name: RoutePath.verifyOtp,
    path: '/verifyOtp',
    requiresAuth: false,
  );

  static const resetPassword = RouteMetadata(
    name: RoutePath.resetPassword,
    path: '/resetPassword',
    requiresAuth: false,
  );
}
