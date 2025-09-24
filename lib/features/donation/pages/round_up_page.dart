import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/round_up_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/round_up_widgets.dart';
import 'package:cresent_charge_user_app/features/home/controllers/charities_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Round Up Page
///
/// Displays detailed round up information including progress chart,
/// donated organizations, and recent activity
class RoundUpPage extends StatelessWidget {
  const RoundUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoundUpController>(
      init: RoundUpController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: DonationConstants.backgroundColor,
          appBar: CustomAppBar(
            backgroundColor: DonationConstants.backgroundColor,
            title: 'Round Up',
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.rh),

                // Progress Chart Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.rw),
                  child: Obx(
                    () => controller.showDetailedProgress.value
                        ? DetailedProgressChart(
                            totalAmount: 120.75,
                            progressPercentage: 60,
                            todaysRoundUp: 0.5,
                            daysLeft: 6,
                            controller: controller,
                          )
                        : RoundUpProgressChart(
                            currentAmount: 30,
                            targetAmount: 50,
                            recentlyRoundedUp: 0.5,
                            controller: controller,
                          ),
                  ),
                ),

                SizedBox(height: 20.rh),

                // Donated To Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.rw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Donated to',
                        style: TextStyle(
                          fontFamily: DonationFonts.familjenGrotesk,
                          fontSize: 20.rfs,
                          fontWeight: FontWeight.w600,
                          color: DonationConstants.offBlack,
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: 12.rh),

                      // Organizations horizontal list
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              Get.find<CharitiesController>().verifiedCharities,
                        ),
                      ),
                      // SizedBox(
                      //   height: 220.rh,
                      //   child: ListView.separated(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: controller.donatedOrganizations.length,
                      //     separatorBuilder: (context, index) =>
                      //         SizedBox(width: 8.rw),
                      //     itemBuilder: (context, index) {
                      //       final org = controller.donatedOrganizations[index];
                      //       return DonatedOrganizationCard(
                      //         imageUrl: org.imageUrl,
                      //         name: org.name,
                      //         location: org.location,
                      //         category: org.category,
                      //         categoryColor: org.categoryColor,
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),

                SizedBox(height: 20.rh),

                // Recent Activity Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.rw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Activity',
                        style: TextStyle(
                          fontFamily: DonationFonts.familjenGrotesk,
                          fontSize: 20.rfs,
                          fontWeight: FontWeight.w600,
                          color: DonationConstants.offBlack,
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: 12.rh),

                      // Recent activity list
                      RecentActivityList(
                        activities: controller.recentActivities,
                        controller: controller,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 100.rh), // Bottom padding for safe area
              ],
            ),
          ),
        );
      },
    );
  }
}
