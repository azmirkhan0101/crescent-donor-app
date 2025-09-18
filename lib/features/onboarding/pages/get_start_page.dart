import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/have_account_widget.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class GetStartPage extends StatelessWidget {
  const GetStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            24.rh.heightWidth,

            // app logo
            Assets.onboarding.appLogoName.svg(width: 150.rw, height: 40.rh),
            38.rh.heightWidth,

            // saving coins illustration image
            Assets.onboarding.onboardingSavingCoins.svg(
              width: 177.rw,
              height: 304.rh,
            ),
            38.rh.heightWidth,

            // Turn your small change into real change
            AppStrings.turnYourSmallChangeIntoRealChange.centerText(
              AppTextStyles.f28W700(),
            ),

            12.rh.heightWidth,

            // Discover rewards and cash back offers
            AppStrings.discoverRewards.centerText(AppTextStyles.baseStyle()),
            Spacer(),

            // Get Started button
            CustomPrimaryButton(
              title: "Get Started",
              onTap: () {
                context.pushNamed(RoutePath.howToWorkPage);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return const LoaderExamplesPage();
                //     },
                //   ),
                // );
              },
            ),
            15.rh.heightWidth,

            // Already have an account? Sign In
            HaveAccountWidget(haveAccount: true),
          ],
        ).paddingXY(X: 40.rw),
      ),
    );
  }
}
