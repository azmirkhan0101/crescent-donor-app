import 'package:cresent_charge_user_app/common-widgets/custom_loader/custom_loader.dart';
import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/profile_controller.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/signup_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_title_section.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class TermsAgreementPage extends StatefulWidget {
  const TermsAgreementPage({super.key});

  @override
  State<TermsAgreementPage> createState() => _TermsAgreementPageState();
}

class _TermsAgreementPageState extends State<TermsAgreementPage> {
  late final SignupController signupController;
  late final ProfileController profileController;

  @override
  void initState() {
    super.initState();
    signupController = Get.isRegistered<SignupController>()
        ? Get.find<SignupController>()
        : Get.put(SignupController());
    profileController = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());
  }

  Future<void> _handleAgreeAndContinue() async {
    if (!signupController.agreeToTerms.value) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please agree to the terms and conditions'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    // Create profile
    final success = await profileController.createProfile();

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile created successfully!'),
          backgroundColor: AppColors.primaryColor,
        ),
      );

      // Navigate to login first
      context.pushReplacementNamed(RoutePath.login);

      // Clean up controllers after navigation completes
      Future.delayed(const Duration(milliseconds: 100), () {
        if (Get.isRegistered<SignupController>()) {
          Get.delete<SignupController>();
        }
        if (Get.isRegistered<ProfileController>()) {
          Get.delete<ProfileController>();
        }
      });
    } else if (profileController.errorMessage.value.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(profileController.errorMessage.value),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  List<String> get termsList => [
    "Allow us to process recurring donations on your behalf based on your chosen plan.",
    "Receive occasional updates or perks from verified partner brands.",
    "Let us securely store your payment info (we never share it!).",
    "Receive occasional updates or perks from trusted partner brands.",
    "Receive occasional updates or perks from trusted partner brands.",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.heightWidth,

          AuthHeader(),
          24.heightWidth,

          AuthTitleSection(
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
              Obx(() {
                if (profileController.isLoading.value) {
                  return const CustomLoader();
                }
                return CustomFilledButton(
                  title: "Agree & Continue",
                  onTap: _handleAgreeAndContinue,
                );
              }),

              24.heightWidth,
            ],
          ).paddingXY(X: 40.rw),
        ],
      ).paddingXY(X: 16.rw),
    ).scaffoldSafeArea();
  }
}
