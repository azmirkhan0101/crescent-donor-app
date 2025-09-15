import 'package:cresent_charge_user_app/comon-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/gen/assets.gen.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme style = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            24.rh.heightWidth,

            // app logo
            Assets.images.appLogoName.svgAsset(width: 150.rw, height: 40.rh),
            38.rh.heightWidth,

            // saving coins illustration image
            Assets.images.onboardingSavingCoins.svgAsset(
              width: 177.rw,
              height: 304.rh,
            ),
            38.rh.heightWidth,

            // Turn your small change into real change
            AppStrings.turnYourSmallChangeIntoRealChange.mediumHeadingText(),

            12.rh.heightWidth,

            // Discover rewards and cash back offers
            AppStrings.discoverRewards.normalText(),
            58.rh.heightWidth,

            // Get Started button
            CustomPrimaryButton(
              title: "Get Started",
              onTap: () {
                // debugPrint("Getx width: ${Get.width}, height: ${Get.height}");
              },
            ),
            15.rh.heightWidth,

            // Already have an account? Sign In
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppStrings.alreadyHaveAnAccount.normalText(),
                4.rw.heightWidth,
                "Sign In"
                    .normalText()
                    .fontWeight(FontWeight.w700)
                    .color(Colors.black),
              ],
            ),
          ],
        ).paddingSymmetric(horizontal: 40.rw),
      ),
    );
  }
}
