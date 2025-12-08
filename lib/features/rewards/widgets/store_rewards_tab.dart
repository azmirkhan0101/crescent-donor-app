import 'package:cresent_charge_user_app/features/rewards/controllers/get_all_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/redeem_card.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreRewardsTab extends StatelessWidget {
  const StoreRewardsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<GetAllRewardsController>(
      init: Get.find<GetAllRewardsController>(),
      initState: (state) async {
        await state.controller!.fetchRewards();
      },
      builder: (controller) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.rw,
            mainAxisSpacing: 8.rh,
            childAspectRatio: 51 / 90,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return RedeemCard(index: index, reward: controller.rewards[index]);
          },
        ).paddingAll(16.rw);
      },
    );
  }
}
