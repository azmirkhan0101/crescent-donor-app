import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/round_up_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

/// Round Up Progress Chart Widget
///
/// Displays the current round up progress with a circular design
class RoundUpProgressChart extends StatelessWidget {
  final double currentAmount;
  final double targetAmount;
  final double recentlyRoundedUp;

  const RoundUpProgressChart({
    super.key,
    required this.currentAmount,
    required this.targetAmount,
    required this.recentlyRoundedUp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: DonationConstants.cardWhite,
        borderRadius: BorderRadius.circular(17.15),
        border: Border.all(color: const Color(0xFFEDEDED), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 0.715,
            offset: const Offset(0, 0.715),
          ),
        ],
      ),
      child: Column(
        children: [
          // Circular progress icon
          Container(
            padding: EdgeInsets.all(20.rw),
            decoration: BoxDecoration(
              color: const Color(0xFFD5EDFF),
              borderRadius: BorderRadius.circular(99.rw),
            ),
            child: Assets.common.coins.svg(
              width: 40.rw,
              height: 40.rh,
              colorFilter: const ColorFilter.mode(
                Color(0xFF2196F3),
                BlendMode.srcIn,
              ),
            ),
          ),

          SizedBox(height: 16.rh),

          // Amount text
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '\$${currentAmount.toInt()} ',
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: 24.rfs,
                    fontWeight: FontWeight.w600,
                    color: DonationConstants.offBlack,
                    height: 28 / 24,
                  ),
                ),
                TextSpan(
                  text: 'of \$${targetAmount.toInt()}',
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: 24.rfs,
                    fontWeight: FontWeight.w600,
                    color: DonationConstants.offBlack.withValues(alpha: 0.25),
                    height: 28 / 24,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8.rh),

          // Recently rounded up text
          Text(
            '\$$recentlyRoundedUp recently rounded up',
            style: TextStyle(
              fontFamily: DonationFonts.interDisplay,
              fontSize: 14.rfs,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF818F8D),
              height: 18 / 14,
            ),
          ),
        ],
      ),
    );
  }
}

/// Recent Activity List Widget
///
/// Displays the list of recent round up activities
class RecentActivityList extends StatelessWidget {
  final List<RecentActivity> activities;
  final RoundUpController controller;

  const RecentActivityList({
    super.key,
    required this.activities,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.rw),
      decoration: BoxDecoration(
        color: DonationConstants.cardWhite,
        borderRadius: BorderRadius.circular(12.rw),
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
          // Today section
          Padding(
            padding: EdgeInsets.only(left: 8.rw, bottom: 8.rh),
            child: Text(
              'Today',
              style: TextStyle(
                fontFamily: DonationFonts.interDisplay,
                fontSize: 11.rfs,
                fontWeight: FontWeight.w500,
                color: Colors.grey.withValues(alpha: 0.6),
                height: 16 / 11,
              ),
            ),
          ),

          // Activities list
          ...activities.asMap().entries.map(
            (entry) => ActivityItem(
              activity: entry.value,
              index: entry.key,
              controller: controller,
            ),
          ),

          SizedBox(height: 16.rh),

          // 20 July section (placeholder for earlier activities)
          Padding(
            padding: EdgeInsets.only(left: 8.rw, bottom: 8.rh),
            child: Text(
              '20 July',
              style: TextStyle(
                fontFamily: DonationFonts.interDisplay,
                fontSize: 11.rfs,
                fontWeight: FontWeight.w500,
                color: Colors.grey.withValues(alpha: 0.6),
                height: 16 / 11,
              ),
            ),
          ),

          // Earlier activities from controller
          ...controller.earlierActivities.asMap().entries.map(
            (entry) => ActivityItem(
              activity: entry.value,
              index:
                  activities.length +
                  entry.key, // Offset by today's activities length
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual Activity Item Widget
///
/// Displays a single round up activity
class ActivityItem extends StatelessWidget {
  final RecentActivity activity;
  final int index;
  final RoundUpController controller;

  const ActivityItem({
    super.key,
    required this.activity,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final String activityKey = controller.getActivityKey(activity, index);

    return GetBuilder<RoundUpController>(
      builder: (_) {
        final bool isExpanded = controller.isActivityExpanded(activityKey);

        return GestureDetector(
          onTap: () => controller.toggleActivityExpansion(activityKey),
          child: Container(
            margin: EdgeInsets.only(bottom: 8.rh),
            padding: EdgeInsets.all(8.rw),
            decoration: BoxDecoration(
              color: isExpanded
                  ? const Color(0xFFF9F7F9)
                  : DonationConstants.cardWhite,
              borderRadius: BorderRadius.circular(12.rw),
            ),
            child: Column(
              children: [
                // Main activity row
                Row(
                  children: [
                    // Brand logo
                    Container(
                      width: 44.rw,
                      height: 44.rh,
                      padding: EdgeInsets.all(11.rw),
                      decoration: BoxDecoration(
                        color: activity.brandColor,
                        borderRadius: BorderRadius.circular(22.rw),
                      ),
                      child: SvgPicture.asset(
                        activity.brandLogo,
                        width: 44.rw,
                        height: 44.rh,
                      ),
                    ),

                    // Container(
                    //   width: 44.rw,
                    //   height: 44.rh,
                    //   padding: EdgeInsets.all(11.rw),
                    //   decoration: BoxDecoration(
                    //     color: activity.brandColor,
                    //     borderRadius: BorderRadius.circular(22.rw),
                    //   ),
                    //   child: SvgPicture.asset(activity.brandLogo),
                    // ),
                    SizedBox(width: 8.rw),

                    // Activity details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Brand name and purchase amount
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                activity.brandName,
                                style: TextStyle(
                                  fontFamily: DonationFonts.interDisplay,
                                  fontSize: 14.rfs,
                                  fontWeight: FontWeight.w500,
                                  color: DonationConstants.offBlack,
                                  height: 18 / 14,
                                ),
                              ),
                              Text(
                                '\$${activity.purchaseAmount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontFamily: DonationFonts.interDisplay,
                                  fontSize: 12.rfs,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  height: 16 / 12,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 8.rh),

                          // Time and round up amount
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                activity.timeAgo,
                                style: TextStyle(
                                  fontFamily: DonationFonts.interDisplay,
                                  fontSize: 12.rfs,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  height: 16 / 12,
                                ),
                              ),
                              Text(
                                '+\$${activity.roundUpAmount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontFamily: DonationFonts.interDisplay,
                                  fontSize: 12.rfs,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1AC461),
                                  height: 16 / 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 8.rw),

                    // Chevron icon
                    Assets.common.arrowDown.svg(
                      width: 16.rw,
                      height: 16.rh,
                      colorFilter: ColorFilter.mode(
                        Colors.grey.withValues(alpha: 0.5),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),

                // Additional details for expanded activities
                if (isExpanded) ...[
                  SizedBox(height: 8.rh),

                  // Divider
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: const Color(0xFFEDEDED),
                  ),

                  SizedBox(height: 8.rh),

                  // Donated to information
                  if (activity.donatedTo != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Donated to:',
                          style: TextStyle(
                            fontFamily: DonationFonts.interDisplay,
                            fontSize: 12.rfs,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            height: 16 / 12,
                          ),
                        ),
                        Text(
                          activity.donatedTo!,
                          style: TextStyle(
                            fontFamily: DonationFonts.interDisplay,
                            fontSize: 12.rfs,
                            fontWeight: FontWeight.w400,
                            color: DonationConstants.offBlack,
                            height: 16 / 12,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.rh),
                  ],

                  // Timestamp information
                  if (activity.timestamp != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Timestamp:',
                          style: TextStyle(
                            fontFamily: DonationFonts.interDisplay,
                            fontSize: 12.rfs,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            height: 16 / 12,
                          ),
                        ),
                        Text(
                          activity.timestamp!,
                          style: TextStyle(
                            fontFamily: DonationFonts.interDisplay,
                            fontSize: 12.rfs,
                            fontWeight: FontWeight.w400,
                            color: DonationConstants.offBlack,
                            height: 16 / 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
