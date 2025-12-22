import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/round_up_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/round_up_widgets.dart';
import 'package:cresent_charge_user_app/features/home/controllers/charities_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class RoundUpPage extends StatelessWidget {
  const RoundUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<RoundUpController>(
      init: RoundUpController(),
      initState: (state) {
        final controller = state.controller!;
        controller.fetchRoundupStats();
      },
      builder: (controller) {
        final roundupStats = controller.roundupStats.value;
        return Scaffold(
          backgroundColor: DonationConstants.backgroundColor,
          appBar: CustomAppBar(
            backgroundColor: DonationConstants.backgroundColor,
            title: 'Round Up',
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  context.pushNamed(RoutePath.settings, extra: false);
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => controller.fetchRoundupStats(),
            color: DonationConstants.primaryPurple,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.rh),

                  // Progress Chart Section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.rw),
                    child: Obx(
                      () => controller.showDetailedProgress.value
                          ? RoundUpProgressChart(
                              totalAmount:
                                  roundupStats?.currentRoundupBalance ?? 0.0,
                              progressPercentage:
                                  roundupStats?.roundupPercentage ?? 0,
                              todaysRoundUp:
                                  roundupStats?.todaysRoundupAmount ?? 0.0,
                              daysLeft: roundupStats?.daysLeft ?? 0,
                              controller: controller,
                            )
                          : RoundUpCard(
                              currentAmount:
                                  controller
                                      .roundupStats
                                      .value
                                      ?.currentRoundupBalance ??
                                  0.0,
                              targetAmount:
                                  controller
                                      .roundupStats
                                      .value
                                      ?.monthlyThreshold
                                      .toDouble() ??
                                  0.0,
                              recentlyRoundedUp:
                                  controller
                                      .roundupStats
                                      .value
                                      ?.lastTransactionAmount ??
                                  0.0,
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
                            spacing: 8.rw,
                            children: Get.find<CharitiesController>()
                                .verifiedCharities,
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
                          // activities: controller.roundupStats.value?.recentTransactions,
                          // controller: controller,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 100.rh), // Bottom padding for safe area
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
