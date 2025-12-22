import 'package:cresent_charge_user_app/common-widgets/custom_loader/custom_loader.dart';
import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/signup_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_title_section.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/have_account_widget.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/signup_form_fields.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/snack_bar/snackbar_msg.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<SignupController>()
        ? Get.find<SignupController>()
        : Get.put(SignupController());

    Future<void> handleSignup() async {
      if (controller.isLoading.value) return;
      controller.clearErrors();
      // Manual validation before API call
      if (!controller.validateAll()) return;
      final success = await controller.signup();
      if (success) {
        SnackbarMsg.success(context, 'OTP sent to your email successfully!');
        context.pushNamed(
          RoutePath.verifyOtp,
          extra: {
            'email': controller.emailController.text.trim(),
            'isForSignup': true,
          },
        );
      } else if (controller.errorMessage.value.isNotEmpty) {
        SnackbarMsg.error(context, controller.errorMessage.value);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.rw),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.heightWidth,
                AuthHeader(),
                32.heightWidth,
                AuthTitleSection(
                  title: AppStrings.letsGetYouStarted,
                  subtitle: AppStrings.itOnlyTakesAFewSeconds,
                ),

                32.rh.heightWidth,

                SignupFormFields(),

                // const Spacer(),
                100.rh.heightWidth,
                Column(
                  children: [
                    Obx(
                      () => controller.isLoading.value
                          ? const CustomLoader()
                          : CustomFilledButton(
                              title: "Sign Up",
                              onTap: handleSignup,
                            ),
                    ),
                    16.heightWidth,
                    HaveAccountWidget(haveAccount: true),

                    24.heightWidth,
                  ],
                ).paddingXY(X: 56.rw),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
