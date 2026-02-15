import 'package:cresent_charge_user_app/core/helper/date_time_converter/date_time_converter.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_all_favorite_reward_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_my_claimed_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/utils/show_rewards_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/reward_details_bottom_sheet.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

// Define colors from Figma design
const Color _offBlack = Color(0xFF000C0B);
const Color _textGray = Color(0xFF818F8D);
const Color _borderGray = Color(0xFFEDEDED);

class MyRewardsTabView extends StatefulWidget {
  const MyRewardsTabView({super.key});

  @override
  State<MyRewardsTabView> createState() => _MyRewardsTabViewState();
}

class _MyRewardsTabViewState extends State<MyRewardsTabView> {
  late GetMyClaimedRewardsController controller;
  late GetAllFavoriteRewardController favoriteController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<GetMyClaimedRewardsController>();
    favoriteController = Get.find<GetAllFavoriteRewardController>();
    // Fetch claimed rewards on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchMyClaimedRewards();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Main content with filters always visible
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.rw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter chips - always visible
          SizedBox(
            height: 40.rh,
            child: Obx(
              // () => ListView.separated(
              //   scrollDirection: Axis.horizontal,
              //   itemCount: controller.statusOptions.length,
              //   itemBuilder: (context, index) {
              //     final status = controller.statusOptions[index];
              //     final isSelected =
              //         controller.selectedStatus.value == status;
              //     return GestureDetector(
              //       onTap: () {
              //         controller.filterByStatus(status);
              //       },
              //       child: Container(
              //         height: 40,
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 16,
              //           vertical: 12,
              //         ),
              //         clipBehavior: Clip.antiAlias,
              //         decoration: ShapeDecoration(
              //           color: isSelected
              //               ? const Color(0xFF000C0B)
              //               : const Color(0xFFEAE9EB),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(24),
              //           ),
              //         ),
              //         child: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           spacing: 4,
              //           children: [
              //             Text(
              //               status[0].toUpperCase() + status.substring(1),
              //               style: TextStyle(
              //                 color: isSelected
              //                     ? Colors.white
              //                     : Colors.black,
              //                 fontSize: 14,
              //                 fontFamily: 'Inter Display',
              //                 fontWeight: isSelected
              //                     ? FontWeight.w600
              //                     : FontWeight.w400,
              //                 height: 1.29,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              //   separatorBuilder: (context, index) {
              //     return SizedBox(width: 8.rw);
              //   },
              // ),
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(controller.statusOptions.length, (index) {
                      final status = controller.statusOptions[index];
                      final isSelected =
                          controller.selectedStatus.value == status;
                      return GestureDetector(
                        onTap: () {
                          controller.filterByStatus(status);
                        },
                        child: Container(
                          height: 40.rh,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.rw,
                            vertical: 12.rh,
                          ),
                          margin: EdgeInsets.only(
                            right: index == controller.statusOptions.length - 1
                                ? 0
                                : 8.rw,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: isSelected
                                ? const Color(0xFF000C0B)
                                : const Color(0xFFEAE9EB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.rw),
                            ),
                          ),
                          child: Text(
                            status[0].toUpperCase() + status.substring(1),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: 14.rfs,
                              fontFamily: 'Inter Display',
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              height: 1.29,
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(width: 8.w,),
                    // Favorite chip
                    GestureDetector(
                      onTap: () {
                        controller.toggleFavoriteFilter();
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          //vertical: 12,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: controller.isFavoriteFilter.value
                              ? const Color(0xFF000C0B)
                              : const Color(0xFFEAE9EB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 4,
                          children: [
                            // Icon(
                            //   Icons.favorite,
                            //   size: 16,
                            //   color: controller.isFavoriteFilter.value
                            //       ? Colors.white
                            //       : Colors.black,
                            // ),
                            Text(
                              'Saved',
                              style: TextStyle(
                                color: controller.isFavoriteFilter.value
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter Display',
                                fontWeight: controller.isFavoriteFilter.value
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                height: 1.29,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          16.rh.heightWidth,

          /// Conditional display: Favorites or Claimed Rewards
          Obx(() {
            final isFavoriteView = controller.isFavoriteFilter.value;

            if (isFavoriteView) {
              // Show favorite rewards
              if (favoriteController.isLoading.value) {
                // Loading state for favorites
                return const Center(child: CircularProgressIndicator());
              }

              if (favoriteController.errorMessage.value.isNotEmpty) {
                // Error state for favorites
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.rw),
                    child: Text(
                      favoriteController.errorMessage.value,
                      style: TextStyle(fontSize: 14.rfs, color: _textGray),
                    ),
                  ),
                );
              }

              // Empty state for favorites
              if (favoriteController.favoriteRewards.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.rw),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 64.rw,
                          color: const Color(0xFFB3B3B3),
                        ),
                        SizedBox(height: 16.rh),
                        Text(
                          'No favorites yet',
                          style: TextStyle(
                            fontSize: 20.rfs,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Familjen Grotesk',
                            color: _offBlack,
                            letterSpacing: -0.2,
                          ),
                        ),
                        SizedBox(height: 8.rh),
                        Text(
                          'Tap the heart icon on rewards to save your favorites here.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.rfs,
                            fontFamily: 'Inter Display',
                            color: _textGray,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Display favorite rewards using the same card design
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: favoriteController.favoriteRewards.length,
                itemBuilder: (context, index) {
                  final favoriteReward =
                      favoriteController.favoriteRewards[index];

                  return GestureDetector(
                    onTap: () {
                      showRewardsBottomSheet(
                        context,
                        RewardDetailsBottomSheet(
                          rewardId: favoriteReward.reward ?? '',
                          userStatus: favoriteReward.user,
                        ),
                      );
                    },
                    child: _buildRewardCard(
                      brandIconUrl: favoriteReward.image,
                      title: favoriteReward.title ?? 'Untitled',
                      redemptionDate:
                          DateConverter.isoStringToFormattedDate(
                            favoriteReward.startDate?.toIso8601String() ?? '',
                          ) ??
                          'N/A',
                      status:
                          RewardStatus.favorite, // Default status for favorites
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 12.rh);
                },
              );
            }

            // Show claimed rewards (default view)
            if (controller.claimedRewards.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(32.rw),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.card_giftcard_outlined,
                        size: 64.rw,
                        color: const Color(0xFFB3B3B3),
                      ),
                      SizedBox(height: 16.rh),
                      Text(
                        'No rewards yet',
                        style: TextStyle(
                          fontSize: 20.rfs,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Familjen Grotesk',
                          color: _offBlack,
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: 8.rh),
                      Text(
                        'You haven\'t claimed any rewards yet.\nKeep donating to earn points and unlock amazing rewards!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.rfs,
                          fontFamily: 'Inter Display',
                          color: _textGray,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Display claimed rewards
            return Skeletonizer(
              enabled: controller.isLoading.value,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.claimedRewards.length,
                itemBuilder: (context, index) {
                  final reward = controller.claimedRewards[index];

                  // Map API status to RewardStatus enum
                  late RewardStatus statusEnum;
                  if (reward.status == 'expired') {
                    statusEnum = RewardStatus.expired;
                  } else if (reward.status == 'redeemed' &&
                      reward.isEmailSent) {
                    statusEnum = RewardStatus.emailSent;
                  } else if (reward.status == 'redeemed' &&
                      !reward.isEmailSent) {
                    statusEnum = RewardStatus.usedInStore;
                  } else {
                    // For 'claimed' or 'cancelled' status
                    statusEnum = reward.isEmailSent
                        ? RewardStatus.emailSent
                        : RewardStatus.usedInStore;
                  }

                  return _buildRewardCard(
                    brandIconUrl: reward.rewardImage,
                    title: reward.title,
                    redemptionDate:
                        DateConverter.isoStringToFormattedDate(
                          reward.claimedAt ?? '',
                        ) ??
                        'N/A',
                    status: statusEnum,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 12.rh);
                },
              ),
            );
          }),

          40.rh.heightWidth,
        ],
      ),
    );
  }

  Widget _buildRewardCard({
    required String title,
    required String redemptionDate,
    required RewardStatus status,
    String? brandIconUrl,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.rw),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.rw),
        border: Border.all(color: _borderGray, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main content row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand icon
              Container(
                width: 32.rw,
                height: 32.rh,
                // padding: EdgeInsets.all(8.rw),
                decoration: const BoxDecoration(
                  color: _offBlack,
                  shape: BoxShape.circle,
                ),

                child: ClipOval(
                  child: (brandIconUrl?.isNotEmpty ?? false)
                      ? Image.network(
                          brandIconUrl!,
                          width: 16.rw,
                          height: 16.rh,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.image_not_supported,
                              size: 16.rw,
                              color: Colors.white,
                            );
                          },
                        )
                      : Icon(
                          Icons.image_not_supported,
                          size: 16.rw,
                          color: Colors.white,
                        ),
                ),
              ),

              12.rw.heightWidth,

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: TextStyle(
                        color: _offBlack,
                        fontSize: 16.rfs,
                        fontFamily: 'Inter Display',
                        fontWeight: FontWeight.w500,
                        height: 1.25,
                      ),
                    ),

                    8.rh.heightWidth,

                    // Redemption date
                    Text(
                      'Redemption Date: $redemptionDate',
                      style: TextStyle(
                        color: _textGray,
                        fontSize: 12.rfs,
                        fontFamily: 'Inter Display',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          8.rh.heightWidth,

          // Status tag
          _buildStatusTag(status),
        ],
      ),
    );
  }

  Widget _buildStatusTag(RewardStatus status) {
    Color backgroundColor;
    Color textColor;
    IconData iconData;
    String statusText;

    switch (status) {
      case RewardStatus.emailSent:
        backgroundColor = const Color(0xFF9DF2C1).withOpacity(0.5);
        textColor = const Color(0xFF049758);
        iconData = Icons.mail_outline;
        statusText = 'Email Sent';
        break;
      case RewardStatus.expired:
        backgroundColor = const Color(0xFFF0323C).withOpacity(0.08);
        textColor = const Color(0xFFF0323C);
        iconData = Icons.error_outline;
        statusText = 'Expired';
        break;
      case RewardStatus.usedInStore:
        backgroundColor = const Color(0xFFFEE88B).withOpacity(0.5);
        textColor = const Color(0xFFA18200);
        iconData = Icons.store_outlined;
        statusText = 'Used In Store';
        break;
      case RewardStatus.favorite:
        backgroundColor = const Color(0xFFFFE0E0).withOpacity(0.5);
        textColor = const Color(0xFFFF0000);
        iconData = Icons.favorite;
        statusText = 'Favorite';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 4.rh),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24.rw),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, size: 16.rfs, color: textColor),

          4.rw.heightWidth,

          Text(
            statusText,
            style: TextStyle(
              color: textColor,
              fontSize: 12.rfs,
              fontFamily: 'Inter Display',
              fontWeight: FontWeight.w500,
              height: 1.17,
            ),
          ),
        ],
      ),
    );
  }
}

enum RewardStatus { emailSent, expired, usedInStore, favorite }
