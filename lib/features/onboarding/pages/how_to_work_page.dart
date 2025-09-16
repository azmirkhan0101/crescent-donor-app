import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/onboarding/controllers/how_to_works_controller.dart';
import 'package:cresent_charge_user_app/features/onboarding/widgets/footer_section.dart';
import 'package:cresent_charge_user_app/features/onboarding/widgets/reword_section.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';

class HowToWorkPage extends StatelessWidget {
  const HowToWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            24.heightWidth,

            // How to Works
            AppStrings.howToWorks.centerText(AppTextStyles.f28W700()),
            Spacer(),
            // Image
            AssetGenImage(
              Assets.images.howToWork.path,
            ).image(width: 343.rw, height: 304.rh),
            Spacer(),

            RewordSection(),
            Spacer(),
            FooterSection(),
            24.heightWidth,
          ],
        ).center,
      ),
    );
  }
}
