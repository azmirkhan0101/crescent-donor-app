import 'package:cresent_charge_user_app/core/helper/date_time_converter/date_time_converter.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_my_claimed_rewards_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  int selectedFilterIndex = 0;
  final List<String> filters = ['All', 'Claimed', 'Redeemed', 'Expired'];

  @override
  Widget build(BuildContext context) {
    return GetX<GetMyClaimedRewardsController>(
      initState: (state) {
        state.controller!.fetchMyClaimedRewards();
      },
      builder: (controller) {
        /// If loading, show a loading indicator
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        /// If data is empty, show empty state
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

        /// If there's an error, show the error message
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.rw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter chips
              SizedBox(
                height: 40.rh,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    final isSelected = selectedFilterIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilterIndex = index;
                        });
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: isSelected
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
                            Text(
                              filters[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter Display',
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                height: 1.29,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },

                  separatorBuilder: (context, index) {
                    return SizedBox(width: 8.rw);
                  },
                ),
              ),

              16.rh.heightWidth,

              // Reward Cards List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.claimedRewards.length,
                itemBuilder: (context, index) {
                  bool isExpired(String dateTime) {
                    DateTime expiresAt = DateTime.parse(
                      dateTime,
                    ).add(const Duration(days: 30));
                    return DateTime.now().isAfter(expiresAt);
                  }

                  return _buildRewardCard(
                    brandIconUrl: controller.claimedRewards[index].rewardImage,
                    title: controller.claimedRewards[index].title,
                    redemptionDate:
                        DateConverter.isoStringToFormattedDate(
                          controller.claimedRewards[index].claimedAt ?? '',
                        ) ??
                        'N/A',
                    status:
                        isExpired(
                          controller.claimedRewards[index].claimedAt ?? '',
                        )
                        ? RewardStatus.expired
                        : controller.claimedRewards[index].type == 'in-store'
                        ? RewardStatus.usedInStore
                        : RewardStatus.emailSent,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 12.rh);
                },
              ),

              // Column(
              //   children: [
              //     _buildRewardCard(
              //       title: '10% off on Groceries',
              //       redemptionDate: '28 May 2025',
              //       status: RewardStatus.usedInStore,
              //     ),

              //     12.rh.heightWidth,

              //     _buildRewardCard(
              //       title: 'Free Movie Ticket for Two',
              //       redemptionDate: '12 June 2025',
              //       status: RewardStatus.emailSent,
              //     ),

              //     12.rh.heightWidth,

              //     _buildRewardCard(
              //       title: '\$25 Credit for Ride-Sharing',
              //       redemptionDate: '30 July 2025',
              //       status: RewardStatus.expired,
              //     ),

              //     12.rh.heightWidth,

              //     _buildRewardCard(
              //       title: 'Complimentary Coffee & Pastry',
              //       redemptionDate: '15 August 2025',
              //       status: RewardStatus.usedInStore,
              //     ),

              //     12.rh.heightWidth,

              //     _buildRewardCard(
              //       title: '50% off Online Fitness Class',
              //       redemptionDate: '05 September 2025',
              //       status: RewardStatus.emailSent,
              //     ),
              //   ],
              // ),
              40.rh.heightWidth,
            ],
          ),
        );
      },
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
                  child: Image.network(
                    brandIconUrl ?? '',
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

enum RewardStatus { emailSent, expired, usedInStore }
