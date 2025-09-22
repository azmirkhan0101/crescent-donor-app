import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
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
  const AddCardPage({super.key, this.isAddNewCard = false});

  final bool isAddNewCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isAddNewCard
          ? CustomAppBar(
              title: 'Add New Card',
              actions: [
                IconButton(onPressed: () {}, icon: Assets.common.add.svg()),
              ],
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (!isAddNewCard) 16.heightWidth,

              if (!isAddNewCard) AuthHeader(),
              if (!isAddNewCard) 32.heightWidth,

              if (!isAddNewCard)
                AuthTitleSection(
                  title: AppStrings.startGivingEffortlessly,
                  subtitle: AppStrings.secureYourWallet,
                ),
              if (!isAddNewCard) 12.rh.heightWidth,

              Assets.onboarding.cardInfo.svg(),
              32.rh.heightWidth,

              AddCardFormFields(),
              24.rh.heightWidth,
              if (isAddNewCard) 90.rh.heightWidth,

              Column(
                children: [
                  // Continue button
                  ElevatedButton(
                    onPressed: () {
                      if (isAddNewCard) {
                        context.pushNamed(RoutePath.makePayment);
                      } else {
                        context.pushNamed(RoutePath.termsAgreement);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(double.maxFinite, 56.rh),
                      backgroundColor: isAddNewCard ? AppColors.black : null,
                      foregroundColor: isAddNewCard ? AppColors.white : null,
                    ),
                    child: Text(
                      !isAddNewCard
                          ? AppStrings.addCard
                          : AppStrings.continueText,
                    ),
                  ),
                  16.heightWidth,

                  if (!isAddNewCard)
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
        ),
      ),
    );
  }
}
