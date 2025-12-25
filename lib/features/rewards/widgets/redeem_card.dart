import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/date_time_converter/date_time_converter.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/claim_reward_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/models/reward_details_models.dart';
import 'package:cresent_charge_user_app/features/rewards/models/reward_model.dart'
    hide InStoreRedemptionMethods;
import 'package:cresent_charge_user_app/features/rewards/utils/show_rewards_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/redemption_code_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/reward_details_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/tabbed_redemption_bottom_sheet.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RedeemCard extends StatelessWidget {
  const RedeemCard({super.key, required this.index, required this.reward});

  final int index;
  final RewardModel reward;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleCardTap(context),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.rw),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Image and brand logo
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12.rh),
                      width: double.infinity,
                      height: 100.rh,
                      // padding: EdgeInsets.all(8.rw),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.rw),
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.rw),
                        child: Image.network(
                          reward.business?.coverImage ?? '',
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
                        child: Image.network(
                          reward.business?.logoImage ?? '',

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
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Inter Display',
                                ),
                              ),
                            );
                          },
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
                    child: reward.title
                        .text(AppTextStyles.f16W500())
                        .fontWeight(FontWeight.w500),
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
                          .text(AppTextStyles.f16W500())
                          .fontWeight(FontWeight.w600)
                          .fontFamily(AppStrings.interDisplay),
                    ],
                  ),
                ],
              ),
              4.rh.heightWidth,

              /// ===> Description <===
              Text(
                reward.description,
                style: TextStyle(
                  color: const Color(0xFF808E8D),
                  fontSize: 12,
                  fontFamily: 'Inter Display',
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                ),
              ),
              4.rh.heightWidth,

              /// ===> Expiry Date <===
              RichText(
                text: TextSpan(
                  text: 'Expires:',
                  style: TextStyle(
                    color: const Color(0xFF808E8D),
                    fontSize: 12,
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
                      style: TextStyle(fontWeight: FontWeight.w400),
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
                              fontSize: 12,
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
        if (reward.type != "online") {
          showRewardsBottomSheet(
            context,
            TabbedRedemptionBottomSheet(
              redemptionCode: controller.claimResult.value?.code ?? '',
              availableMethods: InStoreRedemptionMethods(
                qrCode:
                    controller.claimResult.value?.availableMethods.contains(
                      'qr',
                    ) ??
                    false,
                staticCode:
                    controller.claimResult.value?.availableMethods.contains(
                      'static',
                    ) ??
                    false,
                nfcTap:
                    controller.claimResult.value?.availableMethods.contains(
                      'nfc',
                    ) ??
                    false,
              ),
            ),
          );
        }
      }
    }

    /// ===> Redeemed Rewards <===
    if (reward.userStatus == 'claimed') {
      // Unclaimed rewards - show simple redemption code
      showRewardsBottomSheet(
        context,
        RedemptionCodeBottomSheet(
          rewardTitle: reward.title,
          rewardDescription: reward.description,
          redemptionCode: reward.codePrefix,
          expiryDate: () {
            final expiryDate = reward.expiryDate;
            if (expiryDate == null || expiryDate.isEmpty) {
              return 'N/A';
            }
            try {
              return DateConverter.estimatedDate(DateTime.parse(expiryDate));
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
              child: Image.network(
                reward.business?.logoImage ?? '',
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
              ),
            ),
            // child: Center(
            //   child: Text(
            //     reward.business?.name != null &&
            //             reward.business!.name.isNotEmpty
            //         ? reward.business!.name[0].toUpperCase()
            //         : 'B',
            //     style: const TextStyle(
            //       color: Colors.white,
            //       fontSize: 12,
            //       fontWeight: FontWeight.w600,
            //       fontFamily: 'Inter Display',
            //     ),
            //   ),
            // ),
          ),
        ),
      );
    }
  }
}
