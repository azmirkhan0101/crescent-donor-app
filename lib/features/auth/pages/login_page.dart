import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/login_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_title_section.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/have_account_widget.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/login_form_fields.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/get_profile_controller.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginController loginController;

  @override
  void initState() {
    super.initState();
    // Check if controller already exists to avoid duplicate creation
    loginController = Get.isRegistered<LoginController>()
        ? Get.find<LoginController>()
        : Get.put(LoginController());
  }

  @override
  void dispose() {
    // Clean up form errors when leaving the page
    if (Get.isRegistered<LoginController>()) {
      loginController.clearErrors();
      // Delete the controller when the page is disposed
      Get.delete<LoginController>();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.rw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.heightWidth,

              // Back button and theme toggle
              AuthHeader(
                onTap: () {
                  context.pushReplacementNamed(RoutePath.getStartPage);
                },
              ),

              32.heightWidth,

              AuthTitleSection(
                title: AppStrings.welcomeBack,
                subtitle: AppStrings.weMissedYourBusinessGrowth,
              ),

              32.rh.heightWidth,

              // Login form fields widget
              LoginFormFields(controller: loginController),

              // 130.rh.heightWidth,
              Spacer(),

              // Login buttons and actions
              _buildLoginActions(context, loginController),
            ],
          ),
        ),
      ),
    );
  }

  /// Build login actions section (login button, guest login, etc.)
  Widget _buildLoginActions(BuildContext context, LoginController controller) {
    return Obx(() {
      return Column(
        children: [
          CustomFilledButton(
            title: "Login",
            loadingText: controller.isLoading.value ? "Logging In..." : null,
            onTap: () async {
              final success = await controller.login();
              if (!context.mounted) return;
              if (success) {
                final getProfileController = Get.put(GetProfileController());
                await getProfileController.fetchProfile();

                // Make sure context is still valid after the async gap
                if (!context.mounted) return;

                if (getProfileController.profile.value?.id.isNotEmpty ??
                    false) {
                  context.replaceNamed(RoutePath.home);
                } else {
                  ToastMsg.error('Incomplete profile data');
                  context.replaceNamed(RoutePath.fewDetails);
                }
              }
            },
          ),

          16.heightWidth,

          HaveAccountWidget(),

          16.rh.heightWidth,

          "OR"
              .centerText(
                controller.isLoading.value
                    ? TextStyle(color: AppColors.grayColor)
                    : const TextStyle(),
              )
              .fontFamily(GoogleFonts.inter().fontFamily),

          16.rh.heightWidth,

          // Login as guest button
          CustomFilledButton(
            title: controller.isLoading.value
                ? "Please wait..."
                : "Login as a Guest",
            fillColor: Colors.transparent,
            onTap: controller.isLoading.value
                ? null
                : () => _handleGuestLogin(context, controller),
          ),

          24.heightWidth,
        ],
      ).paddingXY(X: 56.rw);
    });
  }

  /// Handle guest login button press
  Future<void> _handleGuestLogin(
    BuildContext context,
    LoginController controller,
  ) async {
    final success = await controller.loginAsGuest();

    if (success && context.mounted) {
      // Show guest mode message before navigation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You are now browsing as a guest'),
          backgroundColor: AppColors.grayColor.withValues(alpha: 0.9),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Navigate to home on successful guest login (replace current route)
      context.goNamed(RoutePath.home);
    }
  }
}
