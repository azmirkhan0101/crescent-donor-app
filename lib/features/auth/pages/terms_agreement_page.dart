import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/signup_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_tile_section.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';

class TermsAgreementPage extends StatelessWidget {
  const TermsAgreementPage({super.key});

  List<String> get termsList => [
    "Allow us to process recurring donations on your behalf based on your chosen plan.",
    "Receive occasional updates or perks from verified partner brands.",
    "Let us securely store your payment info (we never share it!).",
    "Receive occasional updates or perks from trusted partner brands.",
    "Receive occasional updates or perks from trusted partner brands.",
  ];

  @override
  Widget build(BuildContext context) {
    final signupController = Get.find<SignupController>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.heightWidth,

          AuthHeader(),
          24.heightWidth,

          AuthTileSection(
            title: AppStrings.reviewAndAccept,
            subtitle: AppStrings.readAndAcceptTerms,
          ),
          24.rh.heightWidth,

          "Terms & Donation Policy".text(AppTextStyles.f28W700()).fontSize(20),
          "These Terms apply to your use of our app and your participation in automated donations and reward programs."
              .text(AppTextStyles.f14W400()),
          16.rh.heightWidth,

          "By continuing, you agree to:".text(AppTextStyles.f14W400()),
          for (int i = 0; i < termsList.length; i++) ...[
            8.rh.heightWidth,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                4.rh.width,
                "${i + 1}. ".text(AppTextStyles.f14W400()),
                Expanded(child: termsList[i].text(AppTextStyles.f14W400())),
              ],
            ),
          ],

          24.rh.heightWidth,
          Row(
            spacing: 4.rh,
            children: [
              Obx(() {
                return Container(
                  padding: EdgeInsets.all(2.rfs),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.rfs),
                    border: Border.all(
                      color: signupController.agreeToTerms.value
                          ? AppColors.secondaryColor
                          : Colors.black,
                      width: 0.5,
                    ),
                    color: signupController.agreeToTerms.value
                        ? AppColors.secondaryColor
                        : Colors.transparent,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 12.rfs,
                    color: signupController.agreeToTerms.value
                        ? Colors.black
                        : Colors.white,
                  ),
                );
              }),

              "I agree with the Terms & Conditions."
                  .text(AppTextStyles.f14W400())
                  .color(AppColors.black),
            ],
          ).onTap(() {
            signupController.agreeToTerms.value =
                !signupController.agreeToTerms.value;
          }),

          8.rh.heightWidth,

          "By clicking here, I state that I have read and understood the terms and conditions."
              .text(AppTextStyles.f14W400()),

          48.rh.heightWidth,

          Column(
            children: [
              // Continue button
              CustomPrimaryButton(
                title: "Agree & Continue",
                onTap: () {
                  // context.pushNamed(RoutePath.termsAgreement);
                },
              ),

              24.heightWidth,
            ],
          ).paddingSymmetric(horizontal: 40.rw),
        ],
      ).paddingSymmetric(horizontal: 16.rw),
    ).scaffoldSafeArea();
  }
}
