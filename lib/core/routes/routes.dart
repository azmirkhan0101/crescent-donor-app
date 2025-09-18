import 'package:cresent_charge_user_app/features/auth/pages/add_card_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/few_details_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/forgot_password_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/login_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/reset_password_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/signup_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/terms_agreement_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/upload_profile_picture_page.dart';
import 'package:cresent_charge_user_app/features/auth/pages/verify_otp_page.dart';
import 'package:cresent_charge_user_app/features/home/pages/home_page.dart';
import 'package:cresent_charge_user_app/features/onboarding/pages/get_start_page.dart';
import 'package:cresent_charge_user_app/features/onboarding/pages/how_to_work_page.dart';
import 'package:go_router/go_router.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';

class AppRouter {
  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutePath.getStartPage.addBasePath,
    // navigatorKey: Get.key,
    debugLogDiagnostics: true,
    routes: [
      ///======================= splash Route =======================
      GoRoute(
        name: RoutePath.getStartPage,
        path: RoutePath.getStartPage.addBasePath,
        builder: (context, state) => const GetStartPage(),
      ),

      GoRoute(
        path: RoutePath.howToWorkPage.addBasePath,
        name: RoutePath.howToWorkPage,
        builder: (context, state) => const HowToWorkPage(),
      ),

      GoRoute(
        path: RoutePath.login.addBasePath,
        name: RoutePath.login,
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: RoutePath.signup.addBasePath,
        name: RoutePath.signup,
        builder: (context, state) => const SignupPage(),
      ),

      GoRoute(
        path: RoutePath.fewDetails.addBasePath,
        name: RoutePath.fewDetails,
        builder: (context, state) => const FewDetailsPage(),
      ),

      GoRoute(
        path: RoutePath.uploadProfilePicture.addBasePath,
        name: RoutePath.uploadProfilePicture,
        builder: (context, state) => const UploadProfilePicturePage(),
      ),

      GoRoute(
        path: RoutePath.addCard.addBasePath,
        name: RoutePath.addCard,
        builder: (context, state) => const AddCardPage(),
      ),

      GoRoute(
        path: RoutePath.termsAgreement.addBasePath,
        name: RoutePath.termsAgreement,
        builder: (context, state) => const TermsAgreementPage(),
      ),

      GoRoute(
        path: RoutePath.forgotPassword.addBasePath,
        name: RoutePath.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),

      GoRoute(
        path: RoutePath.verifyOtp.addBasePath,
        name: RoutePath.verifyOtp,
        builder: (context, state) => const VerifyOtpPage(),
      ),

      GoRoute(
        path: RoutePath.resetPassword.addBasePath,
        name: RoutePath.resetPassword,
        builder: (context, state) => const ResetPasswordPage(),
      ),

      GoRoute(
        path: RoutePath.home.addBasePath,
        name: RoutePath.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );

  static GoRouter get route => initRoute;
}
