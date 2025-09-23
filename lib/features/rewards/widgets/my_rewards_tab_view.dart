import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

// Define colors from Figma design
const Color _offBlack = Color(0xFF000C0B);
const Color _white = Color(0xFFFFFFFF);
const Color _textGray = Color(0xFF818F8D);
const Color _borderGray = Color(0xFFEDEDED);

class MyRewardsTabView extends StatefulWidget {
  const MyRewardsTabView({super.key});

  @override
  State<MyRewardsTabView> createState() => _MyRewardsTabViewState();
}

class _MyRewardsTabViewState extends State<MyRewardsTabView> {
  int selectedFilterIndex = 0;
  final List<String> filters = ['All', 'Active', 'Redeemed', 'Expired'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.rw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter chips
          SizedBox(
            height: 40.rh,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final isSelected = selectedFilterIndex == index;
                return Container(
                  margin: EdgeInsets.only(right: 8.rw),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilterIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.rw,
                        vertical: 8.rh,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? _offBlack : _white,
                        borderRadius: BorderRadius.circular(20.rw),
                        border: Border.all(
                          color: isSelected ? _offBlack : _borderGray,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        filters[index],
                        style: TextStyle(
                          color: isSelected ? _white : _textGray,
                          fontSize: 12.rfs,
                          fontFamily: 'Inter Display',
                          fontWeight: FontWeight.w500,
                          height: 1.33,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          16.rh.heightWidth,

          // Reward Cards List
          Column(
            children: [
              _buildRewardCard(
                title: '10% off on Groceries',
                redemptionDate: '28 May 2025',
                status: RewardStatus.usedInStore,
              ),

              12.rh.heightWidth,

              _buildRewardCard(
                title: 'Free Movie Ticket for Two',
                redemptionDate: '12 June 2025',
                status: RewardStatus.emailSent,
              ),

              12.rh.heightWidth,

              _buildRewardCard(
                title: '\$25 Credit for Ride-Sharing',
                redemptionDate: '30 July 2025',
                status: RewardStatus.expired,
              ),

              12.rh.heightWidth,

              _buildRewardCard(
                title: 'Complimentary Coffee & Pastry',
                redemptionDate: '15 August 2025',
                status: RewardStatus.usedInStore,
              ),

              12.rh.heightWidth,

              _buildRewardCard(
                title: '50% off Online Fitness Class',
                redemptionDate: '05 September 2025',
                status: RewardStatus.emailSent,
              ),
            ],
          ),

          40.rh.heightWidth,
        ],
      ),
    );
  }

  Widget _buildRewardCard({
    required String title,
    required String redemptionDate,
    required RewardStatus status,
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
            color: Colors.black.withOpacity(0.02),
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
                padding: EdgeInsets.all(8.rw),
                decoration: const BoxDecoration(
                  color: _offBlack,
                  shape: BoxShape.circle,
                ),
                child: Assets.rewards.amazonA.svg(
                  width: 16.rw,
                  height: 16.rh,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
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
