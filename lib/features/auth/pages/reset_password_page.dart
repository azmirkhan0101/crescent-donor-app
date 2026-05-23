import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/reset_password_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_title_section.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../core/helper/extension/context_extension.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key, required this.resetPasswordToken});

  final String resetPasswordToken;

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    final controller = Get.put(ResetPasswordController());

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.rw),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 16.rh,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthHeader(),
                    32.heightWidth,
                    AuthTitleSection(
                      title: "Reset Your Password",
                      subtitle: "The password must be different than before",
                    ),
                    32.rh.heightWidth,
                    // Enter new password field
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPasswordField(
                            controller: controller.newPasswordController,
                            hintText: "Enter New Password",
                            isVisible: controller.isNewPasswordVisible.value,
                            onToggleVisibility:
                                controller.toggleNewPasswordVisibility,
                            textInputAction: TextInputAction.next,
                            isTab: isTab
                          ),
                          if (controller.newPasswordError.value.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 6.rh),
                              child: Text(
                                controller.newPasswordError.value,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.rfs,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    16.heightWidth,
                    // Confirm new password field
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildPasswordField(
                            controller: controller.confirmPasswordController,
                            hintText: "Confirm New Password",
                            isVisible:
                                controller.isConfirmPasswordVisible.value,
                            onToggleVisibility:
                                controller.toggleConfirmPasswordVisibility,
                            textInputAction: TextInputAction.done,
                            isTab: isTab
                          ),
                          if (controller.confirmPasswordError.value.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 6.rh),
                              child: Text(
                                controller.confirmPasswordError.value,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.rfs,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    24.heightWidth,
                    "A strong password must have:".text(
                      AppTextStyles.f14W400().copyWith(fontSize: isTab ? 8.sp : null),
                    ),
                    16.heightWidth,
                    Column(
                      children: [
                        Obx(
                          () => _buildPasswordRequirement(
                            "At least 8 characters",
                            controller.hasMinLength.value,
                            isTab
                          ),
                        ),
                        8.heightWidth,
                        Obx(
                          () => _buildPasswordRequirement(
                            "At least one uppercase and one lowercase letter",
                            controller.hasUppercase.value &&
                                controller.hasLowercase.value,
                              isTab
                          ),
                        ),
                        8.heightWidth,
                        Obx(
                          () => _buildPasswordRequirement(
                            "At least one numeral",
                            controller.hasNumber.value,
                              isTab
                          ),
                        ),
                        8.heightWidth,
                        Obx(
                          () => _buildPasswordRequirement(
                            "At least one special character",
                            controller.hasSpecialChar.value,
                              isTab
                          ),
                        ),
                        if (controller
                            .confirmPasswordController
                            .text
                            .isNotEmpty)
                          Obx(() {
                            return Column(
                              children: [
                                8.heightWidth,
                                _buildPasswordRequirement(
                                  "Passwords match",
                                  controller.passwordsMatch.value,
                                    isTab
                                ),
                              ],
                            );
                          }),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Bottom actions pinned via Expanded spacer mimic
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Obx(
                            () => CustomFilledButton(
                              title: controller.isLoading.value
                                  ? 'Please wait...'
                                  : "Continue",
                              onTap: controller.isLoading.value
                                  ? null
                                  : () async {
                                      final ok = await controller.resetPassword(
                                        resetPasswordToken,
                                      );
                                      if (ok) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              'Password reset successfully',
                                            ),
                                            backgroundColor:
                                                AppColors.primaryColor,
                                          ),
                                        );
                                        context.pushReplacementNamed(
                                          RoutePath.login,
                                        );
                                      } else if (controller
                                          .errorMessage
                                          .value
                                          .isNotEmpty) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              controller.errorMessage.value,
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                            ),
                          ),
                          Obx(
                            () => controller.errorMessage.value.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(top: 12.rh),
                                    child: Text(
                                      controller.errorMessage.value,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12.rfs,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          16.heightWidth,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ("Changed your mind?").centerText(
                                AppTextStyles.f14W400().copyWith(fontSize: isTab ? 8.sp : null),
                              ),
                              4.rw.width,
                              ("Login")
                                  .centerText(AppTextStyles.f14W400().copyWith(fontSize: isTab ? 8.sp : null))
                                  .fontWeight(FontWeight.w600)
                                  .color(AppColors.black)
                                  //.fontSize(14.rfs)
                                  .onTap(() {
                                    context.pushNamed(RoutePath.login);
                                  }),
                            ],
                          ),
                        ],
                      ).paddingXY(X: 40.rw),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
    required TextInputAction textInputAction,
    required bool isTab
  }) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      textInputAction: textInputAction,
      keyboardType: TextInputType.text,
      style: AppTextStyles.baseStyle().copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: isTab ? 8.sp : null
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.baseStyle().copyWith(
          color: AppColors.grayColor.withValues(alpha: 0.6),
          fontWeight: FontWeight.w400,
          fontSize: isTab ? 8.sp : null
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all( isTab ? 20 :12.rw),
          child: Assets.onboarding.lock.svg(
            width: isTab ? 30 :20.rw,
            height:  isTab ? 30 :20.rh,
            colorFilter: ColorFilter.mode(AppColors.grayColor, BlendMode.srcIn),
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: onToggleVisibility,
          child: Padding(
            padding: EdgeInsets.all(isTab ? 20 :12.rw),
            child: Assets.onboarding.eye.svg(
              width: isTab ? 30 :20.rw,
              height: isTab ? 30 :20.rh,
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
            color: AppColors.grayColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.rw),
          borderSide: BorderSide(
            color: AppColors.grayColor.withValues(alpha: 0.3),
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

  Widget _buildPasswordRequirement(String text, bool isValid, bool isTab) {
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
        isTab ? 4.rw.width : 12.rw.width,
        Expanded(
          child: text
              .text(AppTextStyles.f14W400().copyWith(fontSize: isTab ? 8.sp : null))
              .color(isValid ? Colors.green : AppColors.grayColor),
        ),
      ],
    );
  }
}
