import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/round_up_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/round_up_widgets.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatelessWidget {
  final RoundUpController controller;

  TransactionHistoryPage({super.key, required this.controller});

  /// List of recent round up activities
  final List<RecentActivity> recentActivities = [
    RecentActivity(
      brandName: 'Adidas',
      brandLogo: Assets.rewards.adidas.path,
      purchaseAmount: 20.5,
      roundUpAmount: 0.5,
      timeAgo: '2 min ago',
      donatedTo: 'Healing Hands International',
      timestamp: 'July 30, 2025 · 2:48 PM',
      brandColor: Colors.black,
      hasDetails: true,
    ),
    RecentActivity(
      brandName: 'Amazon',
      brandLogo: Assets.rewards.amazonA.path,
      purchaseAmount: 44.25,
      roundUpAmount: 0.75,
      timeAgo: '2 min ago',
      donatedTo: "Hope for Learning Foundation",
      timestamp: 'July 30, 2025 · 2:30 PM',
      brandColor: Colors.black,
      hasDetails: false,
    ),
    RecentActivity(
      brandName: 'Amazon',
      brandLogo: Assets.rewards.amazonA.path,
      purchaseAmount: 44.25,
      roundUpAmount: 0.75,
      timeAgo: '2 min ago',
      donatedTo: "Hope for Learning Foundation",
      timestamp: 'July 30, 2025 · 2:30 PM',
      brandColor: Colors.black,
      hasDetails: false,
    ),
    RecentActivity(
      brandName: 'Amazon',
      brandLogo: Assets.rewards.amazonA.path,
      purchaseAmount: 44.25,
      roundUpAmount: 0.75,
      timeAgo: '2 min ago',
      donatedTo: "Hope for Learning Foundation",
      timestamp: 'July 30, 2025 · 2:30 PM',
      brandColor: Colors.black,
      hasDetails: false,
    ),
    RecentActivity(
      brandName: 'Amazon',
      brandLogo: Assets.rewards.amazonA.path,
      purchaseAmount: 44.25,
      roundUpAmount: 0.75,
      timeAgo: '2 min ago',
      donatedTo: "Hope for Learning Foundation",
      timestamp: 'July 30, 2025 · 2:30 PM',
      brandColor: Colors.black,
      hasDetails: false,
    ),
    RecentActivity(
      brandName: 'Amazon',
      brandLogo: Assets.rewards.amazonA.path,
      purchaseAmount: 44.25,
      roundUpAmount: 0.75,
      timeAgo: '2 min ago',
      donatedTo: "Hope for Learning Foundation",
      timestamp: 'July 30, 2025 · 2:30 PM',
      brandColor: Colors.black,
      hasDetails: false,
    ),
  ];

  /// Earlier activities (different date)
  final List<RecentActivity> earlierActivities = [
    RecentActivity(
      brandName: 'H&M',
      brandLogo: Assets.rewards.hMLogo.path,
      purchaseAmount: 16.75,
      roundUpAmount: 0.25,
      timeAgo: '2 days ago',
      donatedTo: 'Paws and Claws Rescue',
      timestamp: 'July 15, 2025 · 11:15 AM',
      brandColor: const Color(0xFFCD2026),
      hasDetails: false,
    ),
    RecentActivity(
      brandName: 'Amazon',
      brandLogo: Assets.rewards.amazonA.path,
      purchaseAmount: 12.15,
      roundUpAmount: 0.85,
      timeAgo: '2 days ago',
      donatedTo: 'Amazon Smile Foundation',
      timestamp: 'July 11, 2025 · 11:15 AM',
      brandColor: Colors.black,
      hasDetails: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: CustomAppBar(
        title: 'Transaction History',
        backgroundColor: Color(0xFFF7F7F7),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16.rh),
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
            mainAxisSize: MainAxisSize.min,
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
              ...recentActivities.asMap().entries.map(
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
                      recentActivities.length +
                      entry.key, // Offset by today's activities length
                  controller: controller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
