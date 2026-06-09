import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/date_time_converter/date_time_converter.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/claim_reward_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_all_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_reward_detail_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/models/reward_model.dart'
    hide InStoreRedemptionMethods;
import 'package:cresent_charge_user_app/features/rewards/utils/show_rewards_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/redemption_code_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/reward_details_bottom_sheet.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helper/extension/context_extension.dart';

class RedeemCard extends StatelessWidget {
  const RedeemCard({super.key, required this.index, required this.reward});

  final int index;
  final RewardModel reward;

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return GestureDetector(
      onTap: () => _handleCardTap(context),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.rw),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Image and brand logo
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8.rh),
                      width: double.infinity,
                      height: 85.rh,
                      // padding: EdgeInsets.all(8.rw),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.rw),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.rw),
                        child:
                            (reward.business?.coverImage?.isNotEmpty ?? false)
                            ? Image.network(
                                reward.business!.coverImage!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(
                                      Icons.image_outlined,
                                      size: 40.rw,
                                      color: Colors.grey[400],
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 40.rw,
                                  color: Colors.grey[400],
                                ),
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.rh,
                    left: 10.rw,
                    child: Container(
                      width: 44.rw,
                      height: 44.rh,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999.rw),
                        color: Colors.black,
                      ),
                      child: ClipOval(
                        child: (reward.business?.logoImage?.isNotEmpty ?? false)
                            ? Image.network(
                                reward.business!.logoImage!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Text(
                                      reward.business?.name != null &&
                                              reward.business!.name.isNotEmpty
                                          ? reward.business!.name[0]
                                                .toUpperCase()
                                          : 'B',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isTab ? 14.sp : 20,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Inter Display',
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                  reward.business?.name != null &&
                                          reward.business!.name.isNotEmpty
                                      ? reward.business!.name[0].toUpperCase()
                                      : 'B',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isTab ? 14.sp : 20,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Inter Display',
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),

              // Title and points
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    // child: "10% off on Groceries".text(AppTextStyles.f16W500()),
                    child: Text(
                      reward.title,
                      style: AppTextStyles.f16W500().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: isTab ? 14.sp : null
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Assets.rewards.rewardCoin.svg(
                        width: 16.rw,
                        colorFilter: ColorFilter.mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                      // "450"
                      "${reward.pointsCost}"
                          .text(AppTextStyles.f16W500().copyWith(fontSize: isTab ? 12.sp : null))
                          .fontWeight(FontWeight.w600)
                          .fontFamily(AppStrings.interDisplay),
                    ],
                  ),
                ],
              ),
              2.rh.height,

              /// ===> Description <===
              Text(
                reward.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF808E8D),
                  fontSize: isTab ? 12.sp : 12,
                  fontFamily: 'Inter Display',
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                ),
              ),
              2.rh.height,

              /// ===> Expiry Date <===
              RichText(
                text: TextSpan(
                  text: 'Expires:',
                  style: TextStyle(
                    color: const Color(0xFF808E8D),
                    fontSize: isTab ? 12.sp : 12,
                    fontFamily: 'Inter Display',
                    fontWeight: FontWeight.w500,
                    height: 1.33,
                  ),
                  children: [
                    TextSpan(
                      text: () {
                        final expiryDate = reward.expiryDate;
                        if (expiryDate == null || expiryDate.isEmpty) {
                          return ' N/A';
                        }
                        try {
                          return ' ${DateConverter.estimatedDate(DateTime.parse(expiryDate))}';
                        } catch (e) {
                          return ' N/A';
                        }
                      }(),
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: isTab ? 12.sp : null),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              /// ===> Claim / Redeem Button <===
              GetX<ClaimRewardController>(
                init: ClaimRewardController(),
                builder: (controller) {
                  return GestureDetector(
                    onTap: () => _onTapClaimButton(context, controller),
                    child: Container(
                      width: double.infinity,
                      height: 32.rh,
                      decoration: BoxDecoration(
                        color:
                            reward.isAlreadyRedeemed == true ||
                                (controller.isLoading.value &&
                                    reward.id == controller.clickedId.value)
                            ? const Color(0xFFEBE9EC)
                            : AppColors.secondaryColor,
                        borderRadius: BorderRadius.circular(8.rw),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4.rw,
                        children: [
                          if (reward.userStatus == 'claimed')
                            Assets.rewards.checkmark.svg(width: 14.rw),

                          Text(
                            reward.id == controller.clickedId.value &&
                                    controller.isLoading.value
                                ? 'Processing...'
                                : reward.userStatus == 'redeemed'
                                ? "Redeemed"
                                : reward.userStatus == 'not_claimed'
                                ? "Claim"
                                : "claimed",
                            style: TextStyle(
                              color: const Color(0xFF000C0B),
                              fontSize: isTab ? 12.sp : 12,
                              fontFamily: 'Inter Display',
                              fontWeight: FontWeight.w600,
                              height: 1.33,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleCardTap(BuildContext context) {
    // print('Card tapped: ${reward.title}');
    // print('User status: ${reward.userStatus}');
    // if user status is 'not_claimed', show online reward details bottom sheet

    showRewardsBottomSheet(
      context,
      RewardDetailsBottomSheet(
        rewardId: reward.id,
        userStatus: reward.userStatus,
      ),
    );
  }

  void _onTapClaimButton(
    BuildContext context,
    ClaimRewardController controller,
  ) async {
    if (reward.userStatus == 'not_claimed') {
      controller.clickedId.value = reward.id;

      /// ===> Claim Reward Flow <===
      bool success = await controller.claimReward(reward.id);
      if (success) {
        if (!context.mounted) return;

        /// refresh rewords list after claiming
        Get.find<GetAllRewardsController>().fetchRewards();
        // if (reward.type != "online") {
        //   showRewardsBottomSheet(
        //     context,
        //     TabbedRedemptionBottomSheet(
        //       redemptionCode: controller.claimResult.value?.code ?? '',
        //       availableMethods: InStoreRedemptionMethods(
        //         qrCode:
        //             controller.claimResult.value?.availableMethods.contains(
        //               'qr',
        //             ) ??
        //             false,
        //         staticCode:
        //             controller.claimResult.value?.availableMethods.contains(
        //               'static',
        //             ) ??
        //             false,
        //         nfcTap:
        //             controller.claimResult.value?.availableMethods.contains(
        //               'nfc',
        //             ) ??
        //             false,
        //       ),
        //     ),
        //   );
        // }
      }
    }

    /// ===> Redeemed Rewards <===
    if (reward.userStatus == 'claimed') {
      showRewardsBottomSheet(
        context,
        GetX<GetRewardDetailController>(
          initState: (state) {
            state.controller?.fetchRewardDetail(reward.id);
          },
          builder: (controller) {
            return Skeletonizer(
              enabled: controller.isLoading.value,
              child: RedemptionCodeBottomSheet(
                rewardTitle: controller.rewardDetail.value?.title ?? '',
                rewardDescription:
                    controller.rewardDetail.value?.description ?? '',
                redemptionCode:
                    controller.rewardDetail.value?.claimDetails?.assignedCode ??
                    '',
                expiryDate: () {
                  final expiryDate = controller.rewardDetail.value?.expiryDate;
                  if (expiryDate == null || expiryDate.isEmpty) {
                    return 'N/A';
                  }
                  try {
                    return DateConverter.estimatedDate(
                      DateTime.parse(expiryDate),
                    );
                  } catch (e) {
                    return 'N/A';
                  }
                }(),
                brandIcon: Container(
                  width: 24.rw,
                  height: 24.rh,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999.rw),
                    color: Colors.black,
                  ),
                  child: ClipOval(
                    child: (reward.business?.logoImage?.isNotEmpty ?? false)
                        ? Image.network(
                            reward.business!.logoImage!,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Text(
                                  reward.business?.name != null &&
                                          reward.business!.name.isNotEmpty
                                      ? reward.business!.name[0].toUpperCase()
                                      : 'B',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter Display',
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              controller.rewardDetail.value?.business?.name !=
                                          null &&
                                      controller
                                          .rewardDetail
                                          .value!
                                          .business!
                                          .name
                                          .isNotEmpty
                                  ? controller
                                        .rewardDetail
                                        .value!
                                        .business!
                                        .name[0]
                                        .toUpperCase()
                                  : 'B',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter Display',
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
