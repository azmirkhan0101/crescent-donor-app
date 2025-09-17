import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/reset_password_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_tile_section.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthHeader(),
        32.heightWidth,
        AuthTileSection(
          title: "Reset Your Password",
          subtitle: "The password must be different than before",
        ),

        32.rh.heightWidth,

        // Enter new password field
        Obx(
          () => _buildPasswordField(
            controller: controller.newPasswordController,
            hintText: "Enter New Password",
            isVisible: controller.isNewPasswordVisible.value,
            onToggleVisibility: controller.toggleNewPasswordVisibility,
            textInputAction: TextInputAction.next,
          ),
        ),
        16.heightWidth,

        // Confirm new password field
        Obx(
          () => _buildPasswordField(
            controller: controller.confirmPasswordController,
            hintText: "Confirm New Password",
            isVisible: controller.isConfirmPasswordVisible.value,
            onToggleVisibility: controller.toggleConfirmPasswordVisibility,
            textInputAction: TextInputAction.done,
          ),
        ),
        24.heightWidth,

        // Strong password requirements section
        "A strong password must have:".text(AppTextStyles.f14W400()),
        16.heightWidth,

        // Password requirements list
        Column(
          children: [
            // At least 8 characters
            Obx(
              () => _buildPasswordRequirement(
                "At least 8 characters",
                controller.hasMinLength.value,
              ),
            ),
            8.heightWidth,

            // At least one uppercase and one lowercase letter
            Obx(
              () => _buildPasswordRequirement(
                "At least one uppercase and one lowercase letter",
                controller.hasUppercase.value && controller.hasLowercase.value,
              ),
            ),
            8.heightWidth,

            // At least one numeral
            Obx(
              () => _buildPasswordRequirement(
                "At least one numeral",
                controller.hasNumber.value,
              ),
            ),
            8.heightWidth,

            // At least one special character
            Obx(
              () => _buildPasswordRequirement(
                "At least one special character",
                controller.hasSpecialChar.value,
              ),
            ),

            // Passwords match validation (only show if confirm password has content)
            Obx(() {
              if (controller.confirmPassword.value.isNotEmpty) {
                return Column(
                  children: [
                    8.heightWidth,
                    _buildPasswordRequirement(
                      "Passwords match",
                      controller.passwordsMatch.value,
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),

        const Spacer(),

        // Continue button and login link
        Column(
          children: [
            Obx(
              () => CustomPrimaryButton(
                title: AppStrings.continueText,
                onTap: controller.canSubmit
                    ? () {
                        controller.resetPassword();
                        context.pushNamed(RoutePath.login);
                      }
                    : null,
              ),
            ),
            16.heightWidth,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ("Changed your mind?").centerText(AppTextStyles.f14W400()),
                4.rw.width,
                ("Login")
                    .centerText(AppTextStyles.f14W400())
                    .fontWeight(FontWeight.w600)
                    .color(AppColors.black)
                    .fontSize(14.rfs)
                    .onTap(() {
                      context.pushNamed(RoutePath.login);
                    }),
              ],
            ),
          ],
        ).paddingSymmetric(horizontal: 40.rw),
      ],
    ).paddingAll(16.rw).scaffoldSafeArea();
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
    required TextInputAction textInputAction,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      textInputAction: textInputAction,
      keyboardType: TextInputType.text,
      style: AppTextStyles.baseStyle().copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.baseStyle().copyWith(
          color: AppColors.grayColor.withOpacity(0.6),
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.rw),
          child: Assets.icons.lock.svg(
            width: 20.rw,
            height: 20.rh,
            colorFilter: ColorFilter.mode(AppColors.grayColor, BlendMode.srcIn),
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: onToggleVisibility,
          child: Padding(
            padding: EdgeInsets.all(12.rw),
            child: Assets.icons.eye.svg(
              width: 20.rw,
              height: 20.rh,
              colorFilter: ColorFilter.mode(
                AppColors.grayColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.rw),
          borderSide: BorderSide(
            color: AppColors.grayColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.rw),
          borderSide: BorderSide(
            color: AppColors.grayColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.rw),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.rw,
          vertical: 16.rh,
        ),
      ),
    );
  }

  Widget _buildPasswordRequirement(String text, bool isValid) {
    return Row(
      children: [
        Container(
          width: 16.rw,
          height: 16.rh,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isValid ? Colors.green : Colors.transparent,
            border: Border.all(
              color: isValid ? Colors.green : AppColors.grayColor,
              width: 1,
            ),
          ),
          child: isValid
              ? Icon(Icons.check, size: 10.rfs, color: Colors.white)
              : null,
        ),
        12.rw.width,
        Expanded(
          child: text
              .text(AppTextStyles.f14W400())
              .color(isValid ? Colors.green : AppColors.grayColor),
        ),
      ],
    );
  }
}
