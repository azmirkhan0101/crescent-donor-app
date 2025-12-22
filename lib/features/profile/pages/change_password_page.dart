import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/custom_input_field.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/change_password_controller.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());
    return Scaffold(
      backgroundColor: AppColors.lightPageBackground,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: "Change Password",
        backgroundColor: AppColors.lightPageBackground,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable form content
            Expanded(
              child: SingleChildScrollView(
                // <-- This makes the content scrollable
                padding: EdgeInsets.symmetric(horizontal: 16.rw),
                child: Column(
                  spacing: 16.rh,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Current Password"
                            .text(AppTextStyles.f14W400())
                            .fontWeight(FontWeight.w500)
                            .color("#000C0B".hexColor),

                        8.rh.heightWidth,
                        CustomInputField(
                          controller: controller.currentPasswordController,
                          hintText: "***********",
                          prefixIcon: Assets.onboarding.lock.svg(),
                          obscureText: !controller.isNewPasswordVisible.value,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        8.rh.heightWidth,
                        Row(
                          children: [
                            'Forgot your current password? '
                                .text(AppTextStyles.f14W400())
                                .color("#808080".hexColor),
                            'Click here'
                                .text(
                                  AppTextStyles.f14W400().copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                                .fontWeight(FontWeight.w500)
                                .color("#000C0B".hexColor)
                                .onTap(() {
                                  context.pushNamed(RoutePath.forgotPassword);
                                }),
                          ],
                        ),
                      ],
                    ),

                    // Password field
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "New Password"
                              .text(AppTextStyles.f14W400())
                              .fontWeight(FontWeight.w500)
                              .color("#000C0B".hexColor),

                          8.rh.heightWidth,

                          CustomInputField(
                            controller: controller.newPasswordController,
                            hintText: "***********",
                            prefixIcon: Assets.onboarding.lock.svg(),
                            obscureText: !controller.isNewPasswordVisible.value,
                            textInputAction: TextInputAction.next,
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

                    // Strength indicator
                    Obx(() {
                      return Row(
                        spacing: 4.rw,
                        children: List.generate(4, (index) {
                          return Expanded(
                            child: Container(
                              height: 4.rh,
                              decoration: BoxDecoration(
                                color: controller.passwordStrength.value > index
                                    ? AppColors.primaryColor
                                    : "#EBE9EC".hexColor,
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          );
                        }),
                      );
                    }),

                    // Confirm Password field
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Confirm Password"
                              .text(AppTextStyles.f14W400())
                              .fontWeight(FontWeight.w500)
                              .color("#000C0B".hexColor),

                          8.rh.heightWidth,

                          CustomInputField(
                            controller: controller.confirmPasswordController,
                            hintText: "***********",
                            prefixIcon: Assets.onboarding.lock.svg(),
                            obscureText:
                                !controller.isConfirmPasswordVisible.value,
                            textInputAction: TextInputAction.done,
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

                    // Password requirements list
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Strong password requirements section
                        "A strong password must have:".text(
                          AppTextStyles.f14W400(),
                        ),
                        16.heightWidth,
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
                            controller.hasUppercase.value &&
                                controller.hasLowercase.value,
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
                  ],
                ),
              ),
            ),

            // Button at the bottom - will be pushed up by keyboard
            Column(
                  children: [
                    Obx(
                      () => CustomFilledButton(
                        onTap: controller.isLoading.value
                            ? null
                            : () async {
                                final messenger = ScaffoldMessenger.of(context);

                                final ok = await controller.changePassword();
                                if (ok) {
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                        'Password changed successfully',
                                      ),
                                      backgroundColor: AppColors.primaryColor,
                                    ),
                                  );
                                  if (!context.mounted) return;
                                  GoRouter.of(context).pop();
                                } else if (controller
                                    .errorMessage
                                    .value
                                    .isNotEmpty) {
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        controller.errorMessage.value,
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                        title: controller.isLoading.value
                            ? 'Please wait...'
                            : "Save",
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
                    // 16.heightWidth,
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      child: Text("Cancel"),
                    ),
                  ],
                )
                .paddingX(40.rw)
                .paddingB(16.rh), // Add bottom padding for better spacing
          ],
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
