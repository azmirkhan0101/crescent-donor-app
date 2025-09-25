import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';

import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_title_section.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({super.key});

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
            "We’ve sent a code to ".text(AppTextStyles.f14W400()),
            "talha@gmail.com"
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

        const Spacer(),
        // 100.rh.heightWidth,
        Column(
          children: [
            CustomPrimaryButton(
              title: AppStrings.continueText,
              onTap: () {
                context.pushNamed(RoutePath.resetPassword);
              },
            ),
            16.heightWidth,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ("Haven’t receive any code?").centerText(
                  AppTextStyles.f14W400(),
                ),
                4.rw.width,
                ("Resend Code")
                    .centerText(AppTextStyles.f14W400())
                    .fontWeight(FontWeight.w600)
                    .color(AppColors.black)
                    .fontSize(14.rfs)
                    .onTap(() {}),
              ],
            ),
          ],
        ).paddingXY(X: 32.rw),
      ],
    ).paddingAll(16.rw).scaffoldSafeArea();
  }
}
