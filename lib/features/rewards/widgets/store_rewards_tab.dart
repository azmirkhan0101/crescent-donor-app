import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_all_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/redeem_card.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreRewardsTab extends StatelessWidget {
  const StoreRewardsTab({super.key, required this.businessId});

  final String businessId;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final cardHeight = screenHeight < 700
        ? 250
              .rh // Smaller devices
        : screenHeight < 900
        ? 270
              .rh // Medium devices
        : 280.rh; // Large devices
    return GetX<GetAllRewardsController>(
      init: Get.find<GetAllRewardsController>(),
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          state.controller!.fetchRewards(businessId: businessId);
        });
      },
      builder: (controller) {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          ).paddingT(32.rh);
        }

        if (controller.rewards.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.card_giftcard_outlined,
                  size: 80.rw,
                  color: const Color(0xFFD1D5D4),
                ),
                16.rh.heightWidth,
                Text(
                  'No Rewards Available',
                  style: TextStyle(
                    color: const Color(0xFF000C0B),
                    fontSize: 18.rfs,
                    fontFamily: 'Inter Display',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                8.rh.heightWidth,
                Text(
                  'This store hasn\'t added any rewards yet.\nCheck back later!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF818F8D),
                    fontSize: 14.rfs,
                    fontFamily: 'Inter Display',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ).paddingT(60.rh);
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.rw,
            mainAxisSpacing: 12.rh,
            mainAxisExtent: cardHeight, // Responsive height
          ),
          itemCount: controller.rewards.length,
          itemBuilder: (context, index) =>
              RedeemCard(index: index, reward: controller.rewards[index]),
        ).paddingAll(16.rw);
      },
    );
  }
}
