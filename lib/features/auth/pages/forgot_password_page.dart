import 'package:cresent_charge_user_app/common-widgets/custom_loader/custom_loader.dart';
import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/forgot_password_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_title_section.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/custom_input_field.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/have_account_widget.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final ForgotPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<ForgotPasswordController>()
        ? Get.find<ForgotPasswordController>()
        : Get.put(ForgotPasswordController());
  }

  @override
  void dispose() {
    if (Get.isRegistered<ForgotPasswordController>()) {
      Get.delete<ForgotPasswordController>();
    }
    super.dispose();
  }

  Future<void> _handleForgotPassword() async {
    controller.clearErrors();

    final success = await controller.sendForgotPasswordRequest();

    if (success && mounted) {
      Get.snackbar(
        'Success',
        'OTP sent to your email successfully!',
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );

      // Navigate to OTP verification
      context.pushNamed(
        RoutePath.verifyOtp,
        extra: {
          'email': controller.emailController.text.trim(),
          'isForSignup': false,
          'token': controller.resetToken.value,
        },
      );
    } else if (mounted && controller.errorMessage.value.isNotEmpty) {
      Get.snackbar(
        'Error',
        controller.errorMessage.value,
        backgroundColor: Colors.red,
        colorText: AppColors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthHeader(),
            32.heightWidth,
            AuthTitleSection(
              title: "Forgot Password?",
              subtitle: "Enter your email to reset password",
            ),

            32.rh.heightWidth,

            // Email field
            Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppStrings.email
                      .text(AppTextStyles.baseStyle())
                      .color("#000C0B".hexColor),

                  8.rh.heightWidth,
                  CustomInputField(
                    controller: controller.emailController,
                    hintText: AppStrings.enterEmailAddress,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.emailAddress,
                    validator: controller.validateEmail,
                    onChanged: (value) {
                      controller.clearErrors();
                    },
                  ),
                  Obx(() {
                    if (controller.errorMessage.value.isNotEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 8.rh),
                        child: Text(
                          controller.errorMessage.value,
                          style: TextStyle(color: Colors.red, fontSize: 12.rfs),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                ],
              ),
            ),

            const Spacer(),
            // 100.rh.heightWidth,
            Column(
              children: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return const CustomLoader();
                  }
                  return CustomFilledButton(
                    title: AppStrings.continueText,
                    onTap: _handleForgotPassword,
                  );
                }),
                16.heightWidth,
                HaveAccountWidget(),
              ],
            ).paddingXY(X: 40.rw),
          ],
        ).paddingAll(16.rw),
      ),
    );
  }
}
