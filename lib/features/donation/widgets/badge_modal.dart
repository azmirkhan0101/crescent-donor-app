import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/badge_card.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/recent_donation.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/your_rewards_controller.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

const Color _lightGray = Color(0xFFEBE9EC);
const Color _progressStart = Color(0xFFC08FFF);
const Color _progressEnd = Color(0xFF735699);

/// Badge Modal Bottom Sheet
///
/// Shows detailed badge information with progress bar and recent donations
class BadgeModal extends StatelessWidget {
  final Badge selectedBadge;

  const BadgeModal({super.key, required this.selectedBadge});

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
          Align(
            alignment: Alignment.topRight,
            child: Assets.common.cancel.svg(),
          ).paddingAll(16.rw).onTap(() => context.pop()),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.rw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.rh),

                  // Selected Badge Display
                  _buildSelectedBadge(controller),

                  SizedBox(height: 32.rh),

                  // Progress Bar with Tiers
                  _buildProgressSection(controller),

                  SizedBox(height: 32.rh),

                  RecentDonation(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedBadge(YourRewardsController controller) {
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
              selectedBadge.name,
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
              'You’ve turned small change into real change — literally.',
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
            Obx(
              () => FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: controller.progressPercentage / 100,
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

/// Show Badge Modal Bottom Sheet
void showBadgeModal(BuildContext context, Badge badge) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => BadgeModal(selectedBadge: badge),
  );
}
