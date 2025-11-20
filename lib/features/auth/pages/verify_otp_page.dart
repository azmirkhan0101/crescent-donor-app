import 'package:cresent_charge_user_app/common-widgets/custom_loader/custom_loader.dart';
import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/otp_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_title_section.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({
    super.key,
    required this.email,
    this.isForSignup = false,
    this.token,
  });

  final String email;
  final bool isForSignup;
  final String? token;

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  late final OtpController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<OtpController>()
        ? Get.find<OtpController>()
        : Get.put(OtpController());

    // Set email and flow type
    controller.setEmailAndFlow(
      emailAddress: widget.email,
      forSignup: widget.isForSignup,
    );

    // Set token if provided (for forgot password flow)
    if (widget.token != null && widget.token!.isNotEmpty) {
      controller.setToken(widget.token!);
    }
  }

  @override
  void dispose() {
    if (Get.isRegistered<OtpController>()) {
      Get.delete<OtpController>();
    }
    super.dispose();
  }

  Future<void> _handleVerifyOtp() async {
    controller.clearErrors();

    bool success = false;

    if (widget.isForSignup) {
      success = await controller.verifySignupOtp();
    } else {
      success = await controller.verifyForgotPasswordOtp();
    }

    if (success && mounted) {
      Get.snackbar(
        'Success',
        'OTP verified successfully!',
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );

      // Navigate based on flow
      if (widget.isForSignup) {
        // Navigate to few details page to complete profile
        context.pushNamed(RoutePath.fewDetails);
      } else {
        // Navigate to reset password page
        context.pushNamed(RoutePath.resetPassword);
      }
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthHeader(),
        32.heightWidth,
        AuthTitleSection(title: "Enter Verification Code"),
        Row(
          children: [
            "We've sent a code to ".text(AppTextStyles.f14W400()),
            widget.email
                .text(AppTextStyles.f14W400())
                .fontWeight(FontWeight.w600)
                .color(AppColors.black),
          ],
        ),

        32.rh.heightWidth,

        // OTP field
        Pinput(
          autofocus: true,
          length: 6,
          onCompleted: (pin) {
            controller.otpValue.value = pin;
          },
          onChanged: (pin) {
            controller.otpValue.value = pin;
            controller.clearErrors();
          },
          defaultPinTheme: PinTheme(
            width: 52.rw,
            height: 52.rw,
            textStyle: AppTextStyles.f28W700().copyWith(
              fontSize: 18.rfs,
              fontWeight: FontWeight.w500,
              height: 24.rw / 18.rw,
              fontFamily: AppStrings.interDisplay,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: "#E4E4E4".hexColor, width: 1),
            ),
          ),
        ),

        // Error message
        Obx(() {
          if (controller.errorMessage.value.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 16.rh),
              child: Text(
                controller.errorMessage.value,
                style: TextStyle(color: Colors.red, fontSize: 14.rfs),
              ),
            );
          }
          return const SizedBox.shrink();
        }),

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
                onTap: _handleVerifyOtp,
              );
            }),
            16.heightWidth,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ("Haven’t receive any code?").centerText(
                  AppTextStyles.f14W400(),
                ),
                4.rw.width,
                Obx(() {
                  return ("Resend Code")
                      .centerText(AppTextStyles.f14W400())
                      .fontWeight(FontWeight.w600)
                      .color(
                        controller.isLoading.value
                            ? AppColors.grayColor
                            : AppColors.black,
                      )
                      .fontSize(14.rfs)
                      .onTap(
                        controller.isLoading.value
                            ? () {}
                            : controller.resendOtp,
                      );
                }),
              ],
            ),
          ],
        ).paddingXY(X: 32.rw),
      ],
    ).paddingAll(16.rw).scaffoldSafeArea();
  }
}
