import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_all_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_point_balance_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/your_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/my_rewards_tab_view.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/rewards_explore_tab_view.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Define colors from Figma design
const Color _offBlack = Color(0xFF000C0B);
const Color _lightGray = Color(0xFFEBE9EC);
const Color _backgroundGray = Color(0xFFF7F7F7);
const Color _textGray = Color(0xFF515A59);
const Color _borderGray = Color(0xFFEDEDED);
const Color _progressGray = Color(0xFF848484);
const Color _progressStart = Color(0xFFC08FFF);
const Color _progressEnd = Color(0xFF735699);

class YourRewardsPage extends StatelessWidget {
  const YourRewardsPage({super.key});

  Future<void> _refreshData() async {
    // final controller = Get.find<YourRewardsController>();
    await Future.wait([
      Get.find<GetAllRewardsController>().fetchRewards(
        // search: controller.searchQuery.isEmpty ? null : controller.searchQuery,
        // category: controller.selectedCategoryIndex != 0
        //     ? controller.categories[controller.selectedCategoryIndex]
        //           .toLowerCase()
        //     : null,
        status: 'all',
      ),
      Get.find<GetPointBalanceController>().fetchUserPoints(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(YourRewardsController());

    return Scaffold(
      backgroundColor: _backgroundGray,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Header
            _buildHeader(controller),

            // Scrollable Content
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshData,
                color: _progressStart,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // Badge Section
                      _buildBadgeProgressSection(
                        controller,
                      ).paddingXY(X: 16.rw),

                      // Tabs
                      _buildTabs(controller),

                      // Content
                      _buildContent(controller),

                      48.heightWidth,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildBadgeProgressSection(YourRewardsController controller) {
    return Container(
      // height: 136.rh,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(12.rw),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // height: 100.rh,
            padding: EdgeInsets.all(12.rw),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.rw),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.rh,
              children: [
                // Progress text and percentage
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        controller.nextBadgeText,
                        style: AppTextStyles.f14W400().copyWith(
                          color: _offBlack,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${controller.progressPercentage.toInt()}%',
                        style: AppTextStyles.f14W400().copyWith(
                          color: _progressGray,
                        ),
                      ),
                    ),
                  ],
                ),
                4.rh.heightWidth,

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
                          ),
                          _buildProgressPoint(
                            1000,
                            controller.currentProgress >= 1000,
                          ),
                          _buildProgressPoint(
                            1500,
                            controller.currentProgress >= 1500,
                          ),
                          _buildProgressPoint(
                            2000,
                            controller.currentProgress >= 2000,
                          ),
                          _buildProgressPoint(
                            3000,
                            controller.currentProgress >= 3000,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Progress Numbers
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '100',
                      style: AppTextStyles.f14W400().copyWith(color: _textGray),
                    ),
                    Text(
                      '1000',
                      style: AppTextStyles.f14W400().copyWith(color: _textGray),
                    ),
                    Text(
                      '1500',
                      style: AppTextStyles.f14W400().copyWith(color: _textGray),
                    ),
                    Text(
                      '2000',
                      style: AppTextStyles.f14W400().copyWith(color: _textGray),
                    ),
                    Text(
                      '3000',
                      style: AppTextStyles.f14W400().copyWith(color: _textGray),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4.rw,
            children: [
              Assets.bottomNav.donation.svg(
                colorFilter: ColorFilter.mode(
                  Color(0xFF40520A),
                  BlendMode.srcIn,
                ),
              ),
              "Donate Now".text().fontSize(16.rfs).color(Color(0xFF40520A)),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF40520A),
                size: 16.rfs,
              ),
            ],
          ).paddingXY(Y: 8.rh),
        ],
      ),
    );
  }

  Widget _buildHeader(YourRewardsController controller) {
    return Container(
      // height: 64.rh,
      padding: EdgeInsets.all(16.rw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Your Rewards',
            style: AppTextStyles.f28W700().copyWith(
              color: _offBlack,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.24,
            ),
          ).fontSize(24.rfs),

          Column(
            children: [
              Row(
                children: [
                  Assets.rewards.rewardCoin.svg(width: 24.rw, height: 24.rw),

                  4.rw.heightWidth,

                  Text(
                    'Points',
                    style: AppTextStyles.f14W400().copyWith(
                      color: AppColors.black,
                    ),
                  ),

                  8.rw.heightWidth,
                ],
              ),
              Obx(
                () => Text(
                  Get.find<GetPointBalanceController>()
                          .balance
                          .value
                          ?.currentBalance
                          .toString() ??
                      '0',
                  style: AppTextStyles.f20w600().copyWith(color: _offBlack),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressPoint(int value, bool isActive) {
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
        child: isActive
            ? Assets.rewards.rewardProgressBorderedPointer.image(
                width: 24.rw,
                height: 24.rh,
              )
            : Assets.rewards.rewardProgressPointer.image(
                width: 24.rw,
                height: 24.rh,
              ),
      ),
    );
  }

  Widget _buildTabs(YourRewardsController controller) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.rw),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: _borderGray, width: 1)),
        ),
        child: Row(
          children: controller.tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;

            return Expanded(
              child: GestureDetector(
                onTap: () => controller.selectTab(index),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.rh),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: controller.selectedTabIndex == index
                            ? _offBlack
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    tab,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.f16W500().copyWith(
                      color: controller.selectedTabIndex == index
                          ? _offBlack
                          : const Color(0xFF848484),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  Widget _buildContent(YourRewardsController controller) {
    return Obx(() {
      if (controller.selectedTabIndex == 0) {
        // return _buildExploreTab(controller);
        return RewardsExploreTabView();
      } else {
        return MyRewardsTabView();
      }
    });
  }
}
