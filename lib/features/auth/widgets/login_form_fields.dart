import 'package:cresent_charge_user_app/common-widgets/form-fields/form_fields.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/login_controller.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginFormFields extends StatelessWidget {
  final LoginController? controller;

  const LoginFormFields({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final loginController = controller ?? Get.find<LoginController>();

    return Form(
      key: loginController.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email field
          _buildEmailField(loginController),

          24.heightWidth,

          // Password field
          _buildPasswordField(loginController),

          16.heightWidth,

          // Remember password and forgot password row
          _buildRememberAndForgotRow(loginController, context),

          // Error message display
          Obx(() => _buildErrorMessage(loginController)),
        ],
      ),
    );
  }

  /// Build email input field
  Widget _buildEmailField(LoginController controller) {
    return LoginEmailField(
      controller: controller.emailController,
      onChanged: (value) {
        // Clear email error when user starts typing
        if (controller.emailError.value.isNotEmpty) {
          controller.emailError.value = '';
        }
      },
    );
  }

  /// Build password input field
  Widget _buildPasswordField(LoginController controller) {
    return LoginPasswordField(
      controller: controller.passwordController,
      onChanged: (value) {
        // Clear password error when user starts typing
        if (controller.passwordError.value.isNotEmpty) {
          controller.passwordError.value = '';
        }
      },
    );
  }

  /// Build remember password and forgot password row
  Widget _buildRememberAndForgotRow(
    LoginController controller,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Remember password checkbox
        Row(
          children: [
            GestureDetector(
              onTap: () => controller.toggleRememberPassword(),
              child: Container(
                width: 20.rh,
                height: 20.rh,
                decoration: BoxDecoration(
                  color: controller.rememberPassword.value
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  border: Border.all(
                    color: controller.rememberPassword.value
                        ? AppColors.primaryColor
                        : AppColors.black.withValues(alpha: 0.3),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4.rw),
                ),
                child: controller.rememberPassword.value
                    ? Icon(Icons.check, color: AppColors.white, size: 14.rw)
                    : null,
              ),
            ),
            8.heightWidth,

            Text(
              "Remember Password",
              style: AppTextStyles.f14W400().copyWith(
                color: AppColors.black,
                height: 20.rw / 14.rw,
                fontFamily: AppStrings.interDisplay,
              ),
            ),
          ],
        ),

        // Forgot password link
        GestureDetector(
          onTap: () {
            context.pushNamed(RoutePath.forgotPassword);
          },
          child: Text(
            "Forgot Password?",
            style: AppTextStyles.f14W400().copyWith(
              color: AppColors.black,
              decoration: TextDecoration.underline,
              fontFamily: AppStrings.interDisplay,
            ),
          ),
        ),
      ],
    );
  }

  /// Build general error message display
  Widget _buildErrorMessage(LoginController controller) {
    if (controller.errorMessage.value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(top: 16.rh),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.rw),
        decoration: BoxDecoration(
          color: AppColors.redColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.rw),
          border: Border.all(
            color: AppColors.redColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: AppColors.redColor, size: 16.rw),
            8.rw.width,
            Expanded(
              child: Text(
                controller.errorMessage.value,
                style: AppTextStyles.f14W400().copyWith(
                  color: AppColors.redColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
