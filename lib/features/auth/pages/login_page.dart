import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/login_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_tile_section.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/have_account_widget.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/login_form_fields.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    return Scaffold(
      backgroundColor: AppColors.white,
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

              AuthTileSection(
                title: AppStrings.welcomeBack,
                subtitle: AppStrings.weMissedYourBusinessGrowth,
              ),

              32.rh.heightWidth,

              // Login form fields widget
              LoginFormFields(controller: loginController),

              const Spacer(),

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
    return GetX<LoginController>(
      builder: (controller) {
        return Column(
          children: [
            // Login button
            CustomPrimaryButton(
              title: "Login",
              onTap: controller.isLoading.value
                  ? null
                  : () => _handleLogin(context, controller),
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
            CustomPrimaryButton(
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
        ).paddingSymmetric(horizontal: 56.rw);
      },
    );
  }

  /// Handle login button press
  Future<void> _handleLogin(
    BuildContext context,
    LoginController controller,
  ) async {
    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    final success = await controller.login();

    if (success && context.mounted) {
      // Navigate to home on successful login
      context.pushNamed(RoutePath.home);

      // Show success message
      Get.snackbar(
        'Login Successful',
        'Welcome back!',
        backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
        colorText: AppColors.black,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// Handle guest login button press
  Future<void> _handleGuestLogin(
    BuildContext context,
    LoginController controller,
  ) async {
    final success = await controller.loginAsGuest();

    if (success && context.mounted) {
      // Navigate to home on successful guest login
      context.pushNamed(RoutePath.home);

      // Show guest mode message
      Get.snackbar(
        'Guest Mode',
        'You are now browsing as a guest',
        backgroundColor: AppColors.grayColor.withValues(alpha: 0.1),
        colorText: AppColors.black,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
