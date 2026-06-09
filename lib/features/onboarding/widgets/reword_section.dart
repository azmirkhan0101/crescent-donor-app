import 'package:cresent_charge_user_app/core/helper/extension/context_extension.dart';
import 'package:cresent_charge_user_app/features/onboarding/controllers/how_to_works_controller.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RewordSection extends StatelessWidget {
  const RewordSection({super.key});

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    final controller = Get.put(HowToWorksController());
    return Obx(() {
      return Column(
        children: [
          controller.rewardsList[controller.currentIndex.value][0].centerText(
            AppTextStyles.f28W700(),
          ),
          // Grab a coffee or shop online — and unlock rewards instantly.
          controller.rewardsList[controller.currentIndex.value][1].centerText(
            AppTextStyles.baseStyle().copyWith(letterSpacing: 1, fontSize: isTab ? 12.sp : null),
          ),
        ],
      ).paddingXY(X: 40.rw);
    });
  }
}
