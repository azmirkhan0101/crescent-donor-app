import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/your_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/redeem_card.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Define colors from Figma design
const Color _offBlack = Color(0xFF000C0B);
const Color _white = Color(0xFFFFFFFF);
const Color _lightGray = Color(0xFFEBE9EC);
const Color _secondaryLime = Color(0xFFD1FF43);
const Color _neutral100 = Color(0xFF171717);
const Color _backgroundGray = Color(0xFFF7F7F7);
const Color _textGray = Color(0xFF515A59);
const Color _borderGray = Color(0xFFEDEDED);
const Color _progressGray = Color(0xFF848484);
const Color _progressStart = Color(0xFFC08FFF);
const Color _progressEnd = Color(0xFF735699);

class YourRewardsPage extends StatelessWidget {
  const YourRewardsPage({super.key});

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Badge Section
                    _buildBadgeProgressSection(controller).paddingXY(X: 16.rw),

                    // Tabs
                    _buildTabs(controller),

                    // Search Bar
                    _buildSearchBar(controller),

                    // Content
                    _buildContent(controller),
                  ],
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
                  controller.totalPoints.toString().replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]},',
                  ),
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
                      width: 2,
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
  }

  Widget _buildSearchBar(YourRewardsController controller) {
    return TextField(
      onChanged: controller.updateSearchQuery,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: AppTextStyles.f16W500().copyWith(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 8.rh),
        suffixIcon: Assets.common.search
            .svg(
              width: 16.rw,
              height: 16.rh,
              colorFilter: ColorFilter.mode(
                const Color(0xFF808080),
                BlendMode.srcIn,
              ),
            )
            .paddingAll(16.rh),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.rw),
          borderSide: BorderSide(color: const Color(0xFFEDEDED), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.rw),
          borderSide: BorderSide(color: const Color(0xFFEDEDED), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.rw),
          borderSide: BorderSide(color: const Color(0xFFEDEDED), width: 1),
        ),
      ),
    ).paddingXY(X: 16.rw, Y: 8.rh);
  }

  Widget _buildContent(YourRewardsController controller) {
    return Obx(() {
      if (controller.selectedTabIndex == 0) {
        return _buildExploreTab(controller);
      } else {
        return _buildMyRewardsTab(controller);
      }
    });
  }

  Widget _buildExploreTab(YourRewardsController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.rw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Suggested for you
          Text(
            'Suggested for you',
            style: AppTextStyles.f14W400().copyWith(color: _textGray),
          ),

          12.rh.heightWidth,

          // Brand logos
          _buildBrandLogos(),

          24.rh.heightWidth,

          // Rewards for you
          Text(
            'Rewards for you',
            style: AppTextStyles.f14W400().copyWith(color: _textGray),
          ),

          12.rh.heightWidth,

          // Category filters
          _buildCategoryFilters(controller),

          16.rh.heightWidth,

          // Reward cards
          _buildRewardCards(controller),

          40.rh.heightWidth,
        ],
      ),
    );
  }

  Widget _buildMyRewardsTab(YourRewardsController controller) {
    return const Center(child: Text('My Rewards - Coming Soon'));
  }

  Widget _buildBrandLogos() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildBrandLogo(
            backgroundColor: Colors.white,
            child: Assets.rewards.amazon.svg(width: 88.rw),
          ),

          8.rw.heightWidth,

          _buildBrandLogo(
            backgroundColor: Colors.black,
            child: Assets.rewards.adidas.svg(width: 88.rw),
          ),

          8.rw.heightWidth,

          _buildBrandLogo(
            backgroundColor: const Color(0xFFCD2026),
            child: Assets.rewards.hMLogo.svg(width: 80.rw),
          ),
          8.rw.heightWidth,

          _buildBrandLogo(
            backgroundColor: Colors.white,
            child: Assets.rewards.amazon.svg(width: 88.rw),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandLogo({
    required Color backgroundColor,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 8.rh),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.rw),
      ),
      child: child,
    );
  }

  Widget _buildCategoryFilters(YourRewardsController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: controller.categories.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;
          final isSelected = controller.selectedCategoryIndex == index;

          return Container(
            margin: EdgeInsets.only(right: 8.rw),
            child: GestureDetector(
              onTap: () => controller.selectCategory(index),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.rw,
                  vertical: 8.rh,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? _offBlack : _white,
                  borderRadius: BorderRadius.circular(24.rw),
                  border: Border.all(
                    color: isSelected ? _offBlack : _borderGray,
                  ),
                ),
                child: Text(
                  category,
                  style: AppTextStyles.f14W400().copyWith(
                    color: isSelected ? _white : _offBlack,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRewardCards(YourRewardsController controller) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.rw,
        mainAxisSpacing: 8.rh,
        childAspectRatio: 50 / 94,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return RedeemCard(index: index);
      },
    );
  }
}
