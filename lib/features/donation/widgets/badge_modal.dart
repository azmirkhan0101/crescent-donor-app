import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_badge_history_controller.dart';
import 'package:cresent_charge_user_app/features/donation/models/badges_data_model.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/badge_card.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/recent_donation.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/your_rewards_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

const Color _lightGray = Color(0xFFEBE9EC);
const Color _progressStart = Color(0xFFC08FFF);
const Color _progressEnd = Color(0xFF735699);

/// Badge Modal Bottom Sheet
///
/// Shows detailed badge information with progress bar and recent donations
class BadgeModal extends StatelessWidget {
  final Badge selectedBadge;
  final BadgeDataModel badgeDataModel;

  const BadgeModal({
    super.key,
    required this.selectedBadge,
    required this.badgeDataModel,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<YourRewardsController>();
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          /// Top handler
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              width: 32,
              height: 4,
              decoration: ShapeDecoration(
                color: const Color(0xFF000C0B) /* Colors-Off-Black */,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),

          /// Close button
          Padding(
            padding: EdgeInsets.only(right: 24.rw),
            child: Align(
              alignment: Alignment.topRight,
              child: Assets.common.cancel.svg(),
            ).onTap(() => context.pop()),
          ),
          SizedBox(height: 8.rh),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.rw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.rh),

                  // Selected Badge Display
                  _buildSelectedBadge(controller, badgeDataModel),

                  SizedBox(height: 32.rh),

                  // Progress Bar with Tiers
                  _buildProgressSection(controller),

                  SizedBox(height: 24.rh),

                  /// Title
                  Text('Recent Donations', style: AppTextStyles.f16W500()),
                  SizedBox(height: 12.rh),

                  /// === Recent Donations List === ///
                  GetX<GetBadgeHistoryController>(
                    initState: (state) {
                      state.controller!.fetchBadgeHistory(
                        badgeDataModel.badge?.id ?? '',
                      );
                    },
                    builder: (controller) {
                      return Skeletonizer(
                        enabled: controller.isLoading.value,
                        child: RecentDonation(
                          recentDonations:
                              controller
                                  .badgeHistoryModel
                                  .value
                                  ?.data
                                  .recentDonations ??
                              [],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedBadge(
    YourRewardsController controller,
    BadgeDataModel badgeDataModel,
  ) {
    return Center(
      child: Column(
        children: [
          // Badge Icon
          Center(
            child: Image.asset(
              selectedBadge.iconPath,
              width: 120.rw,
              height: 120.rh,
            ),
          ),

          SizedBox(height: 16.rh),

          SizedBox(
            width: 327,
            height: 22,
            child: Text(
              badgeDataModel.badge?.name ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF0C0B0D),
                fontSize: 18,
                fontFamily: DonationFonts.interDisplay,
                fontWeight: FontWeight.w500,
                height: 1.22,
              ),
            ),
          ),

          SizedBox(height: 8.rh),

          // Badge Description
          SizedBox(
            width: 215,
            child: Text(
              // 'You’ve turned small change into real change — literally.',
              badgeDataModel.badge?.description ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF6D6D6D),
                fontSize: 14,
                fontFamily: 'Inter Display',
                fontWeight: FontWeight.w400,
                height: 1.29,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(YourRewardsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Progress Bar
        Stack(
          children: [
            // Background progress bar
            Container(
              height: 10.rh,
              decoration: BoxDecoration(
                color: _lightGray,
                borderRadius: BorderRadius.circular(24),
              ),
            ),

            // Active progress bar with gradient
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (badgeDataModel.progressPercentage ?? 0) / 100,
              child: Container(
                height: 10.rh,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_progressStart, _progressEnd],
                    stops: [0.75, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),

            Transform.translate(
              offset: Offset(0, -7.rh),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildProgressPoint(
                    100,
                    controller.currentProgress >= 100,
                    _buildImage(Assets.donation.badge00.path),
                  ),
                  _buildProgressPoint(
                    1000,
                    controller.currentProgress >= 1000,
                    _buildImage(Assets.donation.badgeNo1.path),
                  ),
                  _buildProgressPoint(
                    1500,
                    controller.currentProgress >= 1500,
                    _buildImage(Assets.common.lock.path),
                  ),
                  _buildProgressPoint(
                    2000,
                    controller.currentProgress >= 2000,
                    _buildImage(Assets.common.lock.path),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 16.rh),

        /// Current Tier
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Current Tier:',
                style: AppTextStyles.f14W400().copyWith(
                  color: const Color(0xFF000C0B),
                ),
              ),
              TextSpan(
                text: ' ${badgeDataModel.currentTier ?? ''}',
                style: AppTextStyles.f14W400(),
              ),
            ],
          ),
        ),

        SizedBox(height: 8.rh),

        /// Remaining Donations Text
        SizedBox(
          width: 311,
          child: Text(
            'Only ${badgeDataModel.nextTier?.requiredCount ?? 'N/A'} more round-up donations to reach ${badgeDataModel.nextTier?.tier ?? ''}!',
            textAlign: TextAlign.center,
            style: AppTextStyles.f14W400(),
          ),
        ),
      ],
    );
  }

  Widget _buildImage(String path) {
    return Container(
      width: 36.rw,
      height: 36.rh,
      padding: EdgeInsets.all(4.rw),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFFA55EEA), width: 1.rw),
      ),
      child: Image.asset(
        path,
        errorBuilder: (context, error, stackTrace) {
          return SvgPicture.asset(path);
        },
      ),
    );
  }
}

Widget _buildProgressPoint(int value, bool isActive, [Widget? icon]) {
  return Container(
    width: 24.rw,
    height: 24.rh,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: const RadialGradient(
        colors: [Color(0xFFFFFFFF), Color(0xFFE8E8E8), Color(0xFFFFFFFF)],
        stops: [0.0, 0.497, 1.0],
      ),
    ),
    child: Center(
      child:
          icon ??
          (isActive
              ? Assets.rewards.rewardProgressBorderedPointer.image(
                  width: 24.rw,
                  height: 24.rh,
                )
              : Assets.rewards.rewardProgressPointer.image(
                  width: 24.rw,
                  height: 24.rh,
                )),
    ),
  );
}
