import 'package:cresent_charge_user_app/common-widgets/custom_loader/custom_loader.dart';
import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/forgot_password_otp_controller.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/signup_otp_controller.dart';
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

class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({
    super.key,
    required this.email,
    this.isForSignup = false,
    this.token,
  });

  final String email;
  final bool isForSignup;
  final String? token;

  Future<void> _handleVerifyOtp(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);

    if (isForSignup) {
      final controller = Get.find<SignupOtpController>();
      controller.clearErrors();
      final success = await controller.verifyOtp();
      if (!context.mounted) return;
      if (success) {
        messenger.showSnackBar(
          SnackBar(
            content: const Text('OTP verified successfully!'),
            backgroundColor: AppColors.primaryColor,
            duration: const Duration(seconds: 2),
          ),
        );
        context.pushNamed(RoutePath.fewDetails);
      } else if (controller.errorMessage.isNotEmpty) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(controller.errorMessage.value),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      final controller = Get.find<ForgotPasswordOtpController>();
      controller.clearErrors();
      final success = await controller.verifyOtp();
      if (!context.mounted) return;
      if (success) {
        messenger.showSnackBar(
          SnackBar(
            content: const Text('OTP verified successfully!'),
            backgroundColor: AppColors.primaryColor,
            duration: const Duration(seconds: 2),
          ),
        );
        context.pushNamed(
          RoutePath.resetPassword,
          extra: {'resetPasswordToken': controller.resetPasswordToken.value},
        );
      } else if (controller.errorMessage.isNotEmpty) {
        messenger.showSnackBar(
          SnackBar(
            content: Text(controller.errorMessage.value),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Inject appropriate controller & set initial data
    if (isForSignup) {
      final signupCtrl = Get.isRegistered<SignupOtpController>()
          ? Get.find<SignupOtpController>()
          : Get.put(SignupOtpController());
      signupCtrl.setEmail(email);
      if (signupCtrl.timer.value == 0) signupCtrl.startTimer();
    } else {
      final fpCtrl = Get.isRegistered<ForgotPasswordOtpController>()
          ? Get.find<ForgotPasswordOtpController>()
          : Get.put(ForgotPasswordOtpController());
      if (token != null && token!.isNotEmpty) fpCtrl.setToken(token!);
      if (fpCtrl.timer.value == 0) fpCtrl.startTimer();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthHeader(),
        32.heightWidth,
        AuthTitleSection(title: "Enter Verification Code"),
        Row(
          children: [
            "We've sent a code to ".text(AppTextStyles.f14W400()),
            email
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
            if (isForSignup) {
              Get.find<SignupOtpController>().otpValue.value = pin;
            } else {
              Get.find<ForgotPasswordOtpController>().otpValue.value = pin;
            }
          },
          onChanged: (pin) {
            if (isForSignup) {
              final c = Get.find<SignupOtpController>();
              c.otpValue.value = pin;
              c.clearErrors();
            } else {
              final c = Get.find<ForgotPasswordOtpController>();
              c.otpValue.value = pin;
              c.clearErrors();
            }
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
          final err = isForSignup
              ? Get.find<SignupOtpController>().errorMessage.value
              : Get.find<ForgotPasswordOtpController>().errorMessage.value;
          if (err.isNotEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 16.rh),
              child: Text(
                err,
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
              final loading = isForSignup
                  ? Get.find<SignupOtpController>().isLoading.value
                  : Get.find<ForgotPasswordOtpController>().isLoading.value;
              if (loading) return const CustomLoader();
              return CustomFilledButton(
                title: AppStrings.continueText,
                onTap: () => _handleVerifyOtp(context),
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
                  if (isForSignup) {
                    final c = Get.find<SignupOtpController>();
                    if (c.timer.value > 0) {
                      return ("Resend in ${c.timer.value}s")
                          .centerText(AppTextStyles.f14W400())
                          .color(AppColors.grayColor)
                          .fontSize(14.rfs);
                    }
                    return (c.isResendLoading.value
                            ? 'Sending...'
                            : 'Resend Code')
                        .centerText(AppTextStyles.f14W400())
                        .fontWeight(FontWeight.w600)
                        .color(
                          c.isResendLoading.value
                              ? AppColors.grayColor
                              : AppColors.black,
                        )
                        .fontSize(14.rfs)
                        .onTap(
                          c.isResendLoading.value
                              ? () {
                                  debugPrint("Resend OTP tapped but loading");
                                }
                              : () {
                                  debugPrint("Resend OTP tapped");
                                  c.resendOtp();
                                },
                        );
                  } else {
                    final c = Get.find<ForgotPasswordOtpController>();
                    if (c.timer.value > 0) {
                      return ("Resend in ${c.timer.value}s")
                          .centerText(AppTextStyles.f14W400())
                          .color(AppColors.grayColor)
                          .fontSize(14.rfs);
                    }
                    return (c.isResendLoading.value
                            ? 'Sending...'
                            : 'Resend Code')
                        .centerText(AppTextStyles.f14W400())
                        .fontWeight(FontWeight.w600)
                        .color(
                          c.isResendLoading.value
                              ? AppColors.grayColor
                              : AppColors.black,
                        )
                        .fontSize(14.rfs)
                        .onTap(c.isResendLoading.value ? () {} : c.resendOtp);
                  }
                }),
              ],
            ),
          ],
        ).paddingXY(X: 12.rw),
      ],
    ).paddingAll(16.rw).scaffoldSafeArea();
  }
}
