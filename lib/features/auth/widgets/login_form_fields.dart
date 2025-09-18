import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
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

    return GetX<LoginController>(
      init: loginController,
      builder: (controller) {
        return Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Email field
              _buildEmailField(controller),

              24.heightWidth,

              // Password field
              _buildPasswordField(controller),

              16.heightWidth,

              // Remember password and forgot password row
              _buildRememberAndForgotRow(controller, context),

              // Error message display
              _buildErrorMessage(controller),
            ],
          ),
        );
      },
    );
  }

  /// Build email input field
  Widget _buildEmailField(LoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Email".text(AppTextStyles.baseStyle()).color("#000C0B".hexColor),

        8.rh.heightWidth,

        TextFormField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          style: AppTextStyles.baseStyle().copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          validator: controller.validateEmail,
          onChanged: (value) {
            // Clear email error when user starts typing
            if (controller.emailError.value.isNotEmpty) {
              controller.emailError.value = '';
            }
          },
          decoration: InputDecoration(
            hintText: "Enter Email Address",
            hintStyle: AppTextStyles.baseStyle().copyWith(
              fontWeight: FontWeight.w500,
              color: "#CCCCCC".hexColor,
            ),
            prefixIcon: Assets.onboarding.mail.svg().paddingOnly(
              left: 16.rw,
              right: 8.rw,
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 16.rw,
              minHeight: 14.rh,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: "#E4E4E4".hexColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: "#E4E4E4".hexColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: AppColors.redColor, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: AppColors.redColor, width: 1.5),
            ),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.rh,
              horizontal: 16.rw,
            ),
          ),
        ),

        // Email specific error message
        if (controller.emailError.value.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 4.rh),
            child: Text(
              controller.emailError.value,
              style: AppTextStyles.f14W400().copyWith(
                color: AppColors.redColor,
                fontSize: 12.rfs,
              ),
            ),
          ),
      ],
    );
  }

  /// Build password input field
  Widget _buildPasswordField(LoginController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Password".text(AppTextStyles.baseStyle()).color("#000C0B".hexColor),

        8.rh.heightWidth,

        TextFormField(
          controller: controller.passwordController,
          obscureText: !controller.isPasswordVisible.value,
          textInputAction: TextInputAction.done,
          style: AppTextStyles.baseStyle().copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          validator: controller.validatePassword,
          onChanged: (value) {
            // Clear password error when user starts typing
            if (controller.passwordError.value.isNotEmpty) {
              controller.passwordError.value = '';
            }
          },
          decoration: InputDecoration(
            hintText: "***********",
            hintStyle: AppTextStyles.baseStyle().copyWith(
              fontWeight: FontWeight.w500,
              color: "#CCCCCC".hexColor,
            ),
            prefixIcon: Assets.onboarding.lock.svg().paddingOnly(
              left: 16.rw,
              right: 8.rw,
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 16.rw,
              minHeight: 14.rh,
            ),
            suffixIcon: GestureDetector(
              onTap: () => controller.togglePasswordVisibility(),
              child: Icon(
                controller.isPasswordVisible.value
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: AppColors.black.withValues(alpha: 0.6),
                size: 20.rw,
              ).paddingOnly(right: 16.rw),
            ),
            suffixIconConstraints: BoxConstraints(
              minWidth: 16.rw,
              minHeight: 10.rh,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: "#E4E4E4".hexColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: "#E4E4E4".hexColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: AppColors.redColor, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: AppColors.redColor, width: 1.5),
            ),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.rh,
              horizontal: 16.rw,
            ),
          ),
        ),

        // Password specific error message
        if (controller.passwordError.value.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 4.rh),
            child: Text(
              controller.passwordError.value,
              style: AppTextStyles.f14W400().copyWith(
                color: AppColors.redColor,
                fontSize: 12.rfs,
              ),
            ),
          ),
      ],
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
