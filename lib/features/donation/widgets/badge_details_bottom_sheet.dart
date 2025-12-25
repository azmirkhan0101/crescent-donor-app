import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/badges/controllers/badges_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_badge_history_controller.dart';
import 'package:cresent_charge_user_app/features/donation/models/badges_data_model.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
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
class BadgeDetailsBottomSheet extends StatelessWidget {
  // final Badge selectedBadge;
  final BadgeDataModel badgeDataModel;

  const BadgeDetailsBottomSheet({
    super.key,
    // required this.selectedBadge,
    required this.badgeDataModel,
  });

  @override
  Widget build(BuildContext context) {
    final yourRewardController = Get.find<YourRewardsController>();
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
              child: GetX<GetBadgeHistoryController>(
                initState: (state) {
                  state.controller!.fetchBadgeHistory(
                    badgeDataModel.badge?.id ?? '',
                  );
                },
                builder: (controller) {
                  return Skeletonizer(
                    enabled: controller.isLoading.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.rh),

                        // Selected Badge Display
                        _buildSelectedBadge(
                          badgeUrl: badgeDataModel.badge?.icon,
                          badgeName: badgeDataModel.badge?.name,
                          badgeDescription: badgeDataModel.badge?.description,
                        ),

                        SizedBox(height: 32.rh),

                        // Progress Bar with Tiers
                        _buildProgressSection(
                          yourRewardController,
                          currentTier: controller
                              .badgeHistoryModel
                              .value
                              ?.data
                              .progress
                              .currentTier,
                          percent: controller
                              .badgeHistoryModel
                              .value
                              ?.data
                              .progress
                              .percentage,
                        ),

                        SizedBox(height: 24.rh),

                        /// Title
                        Text(
                          'Recent Donations',
                          style: AppTextStyles.f16W500(),
                        ),
                        SizedBox(height: 12.rh),

                        /// === Recent Donations List === ///
                        // GetX<GetBadgeHistoryController>(
                        //   initState: (state) {
                        //     state.controller!.fetchBadgeHistory(
                        //       badgeDataModel.badge?.id ?? '',
                        //     );
                        //   },
                        //   builder: (controller) {
                        Skeletonizer(
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
                        ),
                        // },
                        // )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedBadge({
    String? badgeUrl,
    String? badgeName,
    String? badgeDescription,
  }) {
    return Center(
      child: Column(
        children: [
          // Badge Icon
          Center(
            child: Image.network(
              // badgeDataModel.badge?.icon ?? '',
              badgeUrl ?? '',
              width: 120.rw,
              height: 120.rh,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported,
                  size: 80.rw,
                  color: Colors.grey,
                );
              },
            ),
          ),

          SizedBox(height: 16.rh),

          SizedBox(
            width: 327,
            height: 22,
            child: Text(
              badgeName ?? 'N/A',
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
              badgeDescription ?? 'N/A',
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

  Widget _buildProgressSection(
    YourRewardsController controller, {
    String? currentTier,
    int? percent,
  }) {
    final badgesController = Get.find<BadgesController>();
    print('Current Tier: $currentTier, Percent: $percent');
    print(
      'Calculated Progress: ${badgesController.getTierProgress(currentTier ?? '', percent?.toDouble() ?? 0)}',
    );

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
              widthFactor: currentTier == 'one-tier'
                  ? 1
                  : badgesController.getTierProgress(
                          currentTier ?? '',
                          percent?.toDouble() ?? 0,
                        ) /
                        3,
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
                  if (currentTier != 'one-tier')
                    _buildProgressPoint(
                      0,
                      badgesController.getTierIndex(currentTier ?? '') >= 0,
                      badgesController.getTierIndex(currentTier ?? '') >= 0
                          ? _buildImage(Assets.donation.badge00.path)
                          : _buildImage(Assets.common.lock.path),
                    ),

                  if (currentTier != 'one-tier')
                    _buildProgressPoint(
                      1,
                      badgesController.getTierIndex(currentTier ?? '') >= 1,
                      badgesController.getTierIndex(currentTier ?? '') >= 1
                          ? _buildImage(Assets.donation.badgeNo1.path)
                          : _buildImage(Assets.common.lock.path),
                    ),
                  if (currentTier != 'one-tier')
                    _buildProgressPoint(
                      2,
                      badgesController.getTierIndex(currentTier ?? '') >= 2,
                      badgesController.getTierIndex(currentTier ?? '') >= 2
                          ? _buildImage(Assets.donation.badgeNo2.path)
                          : _buildImage(Assets.common.lock.path),
                    ),
                  if (currentTier != 'one-tier')
                    _buildProgressPoint(
                      3,
                      badgesController.getTierIndex(currentTier ?? '') >= 3,
                      badgesController.getTierIndex(currentTier ?? '') >= 3
                          ? _buildImage(Assets.donation.badgeNo3.path)
                          : _buildImage(Assets.common.lock.path),
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
