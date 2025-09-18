import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/features/onboarding/controllers/how_to_works_controller.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HowToWorksController>();
    return Row(
      children: [
        // Skip button
        AppStrings.skip.centerText(AppTextStyles.baseStyle()).onTap(() {
          onClickSkip(context);
        }),

        const Spacer(),
        // Dots indicator
        Obx(
          () => Row(
            spacing: 1.rw,
            children: List.generate(
              4,
              (index) => index == controller.currentIndex.value
                  ? Assets.onboarding.smallStar
                        .svg(width: 12.rw, height: 12.rh)
                        .onTap(() => onClickDot(index, controller))
                  : Assets.onboarding.dotGrey
                        .svg(width: 8.rw, height: 8.rh)
                        .onTap(() => onClickDot(index, controller)),
            ),
          ),
        ),
        const Spacer(),

        // Next button
        Assets.onboarding.arrowRightCircleButton
            .svg(width: 40.rh, height: 40.rh)
            .onTap(() => onTapNext(controller, context)),
      ],
    ).paddingXY(horizontal: 16.rw);
  }

  void onClickSkip(BuildContext context) {
    context.pushReplacement(RoutePath.login.addBasePath);
  }

  void onClickDot(int index, HowToWorksController controller) {
    controller.updateIndex(index);
  }

  void onTapNext(HowToWorksController controller, BuildContext context) {
    if (controller.currentIndex.value < 3) {
      controller.updateIndex(controller.currentIndex.value + 1);
    } else {
      // Navigate to next screen or perform final action
      context.pushReplacement(RoutePath.login.addBasePath);
    }
  }
}
