import 'package:cresent_charge_user_app/common-widgets/form-fields/form_fields.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/login_controller.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../core/helper/extension/context_extension.dart';

class LoginFormFields extends StatelessWidget {
  final LoginController? controller;

  const LoginFormFields({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    final loginController = controller ?? Get.find<LoginController>();

    return Column(
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
        // Obx(() => _buildErrorMessage(loginController)),
      ],
    );
  }

  /// Build email input field
  Widget _buildEmailField(LoginController controller,) {
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
    bool isTab = context.isTab;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Remember password checkbox
        Obx(() {
          return Row(
            children: [
              Container(
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
              8.heightWidth,

              Text(
                "Remember Password",
                style: AppTextStyles.f14W400().copyWith(
                  color: AppColors.black,
                  height: 20.rw / 14.rw,
                  fontFamily: AppStrings.interDisplay,
                  fontSize: isTab ? 6.sp : null
                ),
              ),
            ],
          ).onTap(() => controller.toggleRememberPassword());
        }),

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
                fontSize: isTab ? 6.sp : null
            ),
          ),
        ),
      ],
    );
  }
}
