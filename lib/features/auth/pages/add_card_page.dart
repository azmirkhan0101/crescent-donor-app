import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/add_card_form_fields.dart';
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

class AddCardPage extends StatelessWidget {
  const AddCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          16.heightWidth,

          AuthHeader(),
          32.heightWidth,

          AuthTitleSection(
            title: AppStrings.startGivingEffortlessly,
            subtitle: AppStrings.secureYourWallet,
          ),
          12.rh.heightWidth,

          Assets.onboarding.cardInfo.svg(),
          32.rh.heightWidth,

          AddCardFormFields(),
          24.rh.heightWidth,

          Column(
            children: [
              // Continue button
              CustomPrimaryButton(
                title: AppStrings.continueText,
                onTap: () {
                  context.pushNamed(RoutePath.termsAgreement);
                },
              ),
              16.heightWidth,

              // I'll do this later text
              AppStrings.illDoThisLater.centerText(
                AppTextStyles.baseStyle().copyWith(
                  fontFamily: AppStrings.interDisplay,
                  fontSize: 14.rfs,
                  color: AppColors.grayColor,
                ),
              ),
              24.heightWidth,
            ],
          ).paddingXY(X: 40.rw),
        ],
      ).paddingXY(X: 16.rw),
    ).scaffoldSafeArea();
  }
}
