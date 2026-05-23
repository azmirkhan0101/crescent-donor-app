import 'package:cresent_charge_user_app/common-widgets/custom_loader/custom_loader.dart';
import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/forgot_password_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_title_section.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/custom_input_field.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/have_account_widget.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../core/helper/extension/context_extension.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    final controller = Get.isRegistered<ForgotPasswordController>()
        ? Get.find<ForgotPasswordController>()
        : Get.put(ForgotPasswordController());

    Future<void> handleForgotPassword() async {
      controller.clearErrors();
      if (!controller.validateAll()) return; // field error shown via Obx
      final success = await controller.sendForgotPasswordRequest();
      if (success) {
        ToastMsg.success('OTP sent to your email successfully!');
        context.pushNamed(
          RoutePath.verifyOtp,
          extra: {
            'email': controller.emailController.text.trim(),
            'isForSignup': false,
            'token': controller.resetToken.value,
          },
        );
      } else if (controller.errorMessage.value.isNotEmpty) {
        /// Special handling for "Last OTP is valid" case
        if (controller.errorMessage.value.contains('Last OTP is valid')) {
          ToastMsg.success(controller.errorMessage.value);
          context.pushNamed(
            RoutePath.verifyOtp,
            extra: {
              'email': controller.emailController.text.trim(),
              'isForSignup': false,
              'token': controller.resetToken.value,
            },
          );
          return;
        }
        ToastMsg.error(controller.errorMessage.value);
      }
    }

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

            // Email field manual validation
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppStrings.email
                    .text(AppTextStyles.baseStyle().copyWith(
                    fontSize:  isTab ? 8.sp : null))
                    .color("#000C0B".hexColor),
                8.rh.heightWidth,
                CustomInputField(
                  controller: controller.emailController,
                  hintText: AppStrings.enterEmailAddress,
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: controller.updateEmail,
                ),
                Obx(
                  () => controller.emailError.value.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 8.rh),
                          child: Text(
                            controller.emailError.value,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12.rfs,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                Obx(
                  () => controller.errorMessage.value.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 8.rh),
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
              ],
            ),

            const Spacer(),
            // 100.rh.heightWidth,
            Column(
              children: [
                Obx(
                  () => controller.isLoading.value
                      ? const CustomLoader()
                      : CustomFilledButton(
                          title: AppStrings.continueText,
                          onTap: handleForgotPassword,
                        ),
                ),
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
