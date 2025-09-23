import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/rewards/utils/show_rewards_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/rewards/utils/show_tabbed_redemption_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/redemption_code_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/reward_details_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/tabbed_redemption_bottom_sheet.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RedeemCard extends StatelessWidget {
  const RedeemCard({super.key, required this.index});

  final int index;

  void _handleCardTap(BuildContext context) {
    showRewardsBottomSheet(
      context,
      RewardDetailsBottomSheet(
        index: index,
        isStoreReward: index == 1, // Example: make second card a store reward
        expiryDateTime: index == 1
            ? DateTime.now().add(
                const Duration(days: 5, hours: 12, minutes: 32),
              )
            : null,
        storeName: index == 1 ? 'Amazon Store' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleCardTap(context),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image and brand logo
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 16.rh),
                  width: double.infinity,
                  height: 120.rh,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.rw),
                    image: DecorationImage(
                      image: AssetImage(Assets.rewards.groceries.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.rh,
                  left: 10.rw,
                  child: Container(
                    padding: EdgeInsets.all(8.rh),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999.rw),
                      color: Colors.black,
                    ),
                    child: Assets.rewards.amazonA.svg(width: 16.rw),
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
                  child: "10% off on Groceries".text(AppTextStyles.f16W500()),
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
                    "450"
                        .text(AppTextStyles.f16W500())
                        .fontWeight(FontWeight.w600)
                        .fontFamily(AppStrings.interDisplay),
                  ],
                ),
              ],
            ),
            8.rh.heightWidth,
            // Offer description
            RichText(
              text: TextSpan(
                text: 'Enjoy ',
                style: TextStyle(
                  color: const Color(0xFF808E8D),
                  fontSize: 12,
                  fontFamily: 'Inter Display',
                  fontWeight: FontWeight.w400,
                  height: 1.33,
                ),
                children: [
                  TextSpan(
                    text: '10% off',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  TextSpan(text: ' on your next grocery'),
                ],
              ),
            ),
            8.rh.heightWidth,
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
                    text: ' 28 May 2025',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            8.rh.heightWidth,
            ElevatedButton(
              onPressed: () {
                // Show different bottom sheets based on card state
                if (index % 3 == 2) {
                  // Claimed rewards - show tabbed redemption
                  showTabbedRedemptionBottomSheet(
                    context,
                    rewardTitle: '10% off on Groceries',
                    rewardDescription: 'Enjoy 10% off on your next grocery run at amazon!',
                    redemptionCode: 'AMAZON10FRESH',
                    expiryDate: '28 May 2025',
                    brandIcon: Assets.rewards.amazonA.svg(
                      width: 14.rw,
                      height: 14.rh,
                    ),
                    initialMethod: RedemptionMethod.qrCode,
                  );
                } else {
                  // Unclaimed rewards - show simple redemption code
                  showRewardsBottomSheet(
                    context,
                    RedemptionCodeBottomSheet(
                      rewardTitle: '10% off on Groceries',
                      rewardDescription: 'Enjoy 10% off on your next grocery run at amazon!',
                      redemptionCode: 'AMAZON10FRESH',
                      expiryDate: '28 May 2025',
                      brandIcon: Assets.rewards.amazonA.svg(
                        width: 14.rw,
                        height: 14.rh,
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(double.maxFinite, 32.rh),
                backgroundColor: index % 3 != 0
                    ? const Color(0xFFEBE9EC)
                    : AppColors.secondaryColor,
              ),
              child: index % 3 != 2
                  ? Text(
                      'Redeem',
                      style: TextStyle(
                        color: const Color(0xFF000C0B),
                        fontSize: 12,
                        fontFamily: 'Inter Display',
                        fontWeight: FontWeight.w600,
                        height: 1.33,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4.rw,
                      children: [
                        Assets.rewards.checkmark.svg(
                          width: 14.rw,
                          // colorFilter: ColorFilter.mode(
                          //   Colors.black,
                          //   BlendMode.srcIn,
                          // ),
                        ),
                        "Claimed".text(
                          TextStyle(
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
          ],
        ).paddingAll(6.rw),
      ),
    );
  }
}
