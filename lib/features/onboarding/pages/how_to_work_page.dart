import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
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
            'How To Works'.centerText(AppTextStyles.f28W700()),
            85.heightWidth,
            AssetGenImage(
              Assets.images.howToWork.path,
            ).image(),
            // Assets.images.howToWork.path.AssetGet(),
          ],
        ).center,
      ),
    );
  }
}
