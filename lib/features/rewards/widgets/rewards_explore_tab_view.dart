import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_all_business_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_all_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/your_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/redeem_card.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

// Define colors from Figma design
const Color _offBlack = Color(0xFF000C0B);
const Color _white = Color(0xFFFFFFFF);
const Color _textGray = Color(0xFF515A59);
const Color _borderGray = Color(0xFFEDEDED);

class RewardsExploreTabView extends StatelessWidget {
  const RewardsExploreTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<YourRewardsController>();
    // final getAllRewardsController = Get.find<GetAllRewardsController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.rw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          _buildSearchBar(controller),
          // Suggested for you
          Text(
            'Suggested for you',
            style: AppTextStyles.f14W400().copyWith(color: _textGray),
          ),

          12.rh.heightWidth,

          // Brand logos
          _buildBrandLogos(context),

          24.rh.heightWidth,

          // Rewards for you
          Text(
            'Rewards for you',
            style: AppTextStyles.f14W400().copyWith(color: _textGray),
          ),

          12.rh.heightWidth,

          // Category filters
          Obx(() => _buildCategoryFilters(controller)),

          16.rh.heightWidth,

          // Reward cards
          _buildRewardCards(controller),

          40.rh.heightWidth,
        ],
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
    ).paddingY(8.rh);
  }

  Widget _buildBrandLogos(BuildContext context) {
    return GetX<GetAllBusinessController>(
      init: Get.find<GetAllBusinessController>(),
      initState: (state) {
        state.controller!.fetchBusinessList();
      },
      builder: (controller) {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: _offBlack));
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: AppTextStyles.f14W400().copyWith(color: _textGray),
            ),
          );
        }

        return SizedBox(
          height: 80.rh,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _buildBrandLogo(
                businessName: controller.businessList[index].name,
                // backgroundColor: Colors.black,
                // child: Assets.rewards.adidas.svg(width: 88.rw),
                // onTap: () => _navigateToStoreProfile(
                //   context: context,
                //   storeName: controller.businessList[index].name,
                //   storeDescription: 'Sports & lifestyle store',
                //   storeImage: Assets.rewards.adidas.path,
                //   storeLogo: Assets.rewards.adidas.svg(
                //     width: 40.rw,
                //     height: 40.rh,
                //     colorFilter: const ColorFilter.mode(
                //       Colors.white,
                //       BlendMode.srcIn,
                //     ),
                //   ),
                // ),
                onTap: () {
                  // print(
                  //   'Navigating to store profile of ${controller.businessList[index].id}',
                  // );
                  context.pushNamed(
                    RoutePath.storeProfile,
                    extra: controller.businessList[index].id,
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return 8.rw.width;
            },
            itemCount: controller.businessList.length,
          ),
        );

        // return SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     children: [
        //       _buildBrandLogo(
        //         backgroundColor: Colors.white,
        //         child: Assets.rewards.amazon.svg(width: 88.rw),
        //         onTap: () => _navigateToStoreProfile(
        //           context: context,
        //           storeName: 'Amazon',
        //           storeDescription: 'E-commerce store',
        //           storeImage: Assets.rewards.amazon.path,
        //           storeLogo: Assets.rewards.amazonA.svg(
        //             width: 40.rw,
        //             height: 40.rh,
        //           ),
        //         ),
        //       ),

        //       8.rw.heightWidth,

        //       _buildBrandLogo(
        //         backgroundColor: Colors.black,
        //         child: Assets.rewards.adidas.svg(width: 88.rw),
        //         onTap: () => _navigateToStoreProfile(
        //           context: context,
        //           storeName: 'Adidas',
        //           storeDescription: 'Sports & lifestyle store',
        //           storeImage: Assets.rewards.adidas.path,
        //           storeLogo: Assets.rewards.adidas.svg(
        //             width: 40.rw,
        //             height: 40.rh,
        //             colorFilter: const ColorFilter.mode(
        //               Colors.white,
        //               BlendMode.srcIn,
        //             ),
        //           ),
        //         ),
        //       ),

        //       8.rw.heightWidth,

        //       _buildBrandLogo(
        //         backgroundColor: const Color(0xFFCD2026),
        //         child: Assets.rewards.hMLogo.svg(width: 80.rw),
        //         onTap: () => _navigateToStoreProfile(
        //           context: context,
        //           storeName: 'H&M',
        //           storeDescription: 'Fashion & clothing store',
        //           storeImage: Assets.rewards.hMLogo.path,
        //           storeLogo: Assets.rewards.hMLogo.svg(
        //             width: 40.rw,
        //             height: 40.rh,
        //             colorFilter: const ColorFilter.mode(
        //               Colors.white,
        //               BlendMode.srcIn,
        //             ),
        //           ),
        //         ),
        //       ),
        //       8.rw.heightWidth,

        //       _buildBrandLogo(
        //         backgroundColor: Colors.white,
        //         child: Assets.rewards.amazon.svg(width: 88.rw),
        //         onTap: () => _navigateToStoreProfile(
        //           context: context,
        //           storeName: 'Amazon',
        //           storeDescription: 'E-commerce store',
        //           storeImage: Assets.rewards.amazon.path,
        //           storeLogo: Assets.rewards.amazonA.svg(
        //             width: 40.rw,
        //             height: 40.rh,
        //             colorFilter: const ColorFilter.mode(
        //               Colors.white,
        //               BlendMode.srcIn,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      },
    );
  }

  Widget _buildBrandLogo({
    required String businessName,
    // required Color backgroundColor,
    // required Widget child,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 8.rh),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.rw),
        ),
        child: Center(
          child: Text(
            businessName,
            style: AppTextStyles.f18W600().copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  // void _navigateToStoreProfile({
  //   required BuildContext context,
  //   required String storeName,
  //   required String storeDescription,
  //   required String storeImage,
  //   required Widget storeLogo,
  // }) {
  //   AppRouterExtension.navigateToRoute(
  //     context,
  //     RoutePath.storeProfile,
  //     extra: {
  //       'storeId': storeId,
  //     },
  //   );
  // }

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

  Widget _buildRewardCards(YourRewardsController yourRewardController) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive card height based on screen dimensions
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
          initState: (state) async {
            await state.controller!.fetchRewards(status: 'active');
          },
          builder: (controller) {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator(color: _offBlack));
            }

            if (controller.errorMessage.value.isNotEmpty) {
              return Center(
                child: Text(
                  controller.errorMessage.value,
                  style: AppTextStyles.f14W400().copyWith(color: _textGray),
                ),
              );
            }

            if (controller.rewards.isEmpty) {
              return Center(
                child: Text(
                  'No rewards found',
                  style: AppTextStyles.f14W400().copyWith(color: _textGray),
                ),
              );
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
            );
          },
        );
      },
    );
  }
}
