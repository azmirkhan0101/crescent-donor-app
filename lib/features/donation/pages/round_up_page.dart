import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_roundup_orgs_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/round_up_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/round_up_widgets.dart';
import 'package:cresent_charge_user_app/features/home/widgets/verified_charity_card.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RoundUpPage extends StatelessWidget {
  const RoundUpPage({super.key});

  Future<void> _getRoundupStats() async {
    final controller = Get.find<RoundUpController>();
    final getRoundupOrgController = Get.find<GetRoundupOrgsController>();
    bool success = await getRoundupOrgController.fetchOrgs();
    if (success) {
      String roundUpId = getRoundupOrgController.orgs.first.roundupId;
      await controller.fetchRoundupStats(roundUpId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final roundUpController = Get.find<RoundUpController>();
    return GetX<GetRoundupOrgsController>(
      init: Get.find<GetRoundupOrgsController>(),
      initState: (state) => _getRoundupStats(),
      builder: (getRoundupOrgController) {
        final roundupStats = roundUpController.roundupStats.value;
        return Scaffold(
          backgroundColor: DonationConstants.backgroundColor,
          appBar: CustomAppBar(
            backgroundColor: DonationConstants.backgroundColor,
            title: 'Round Up',
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  context.pushNamed(
                    RoutePath.settings,
                    extra: {
                      'isRecurring': false,
                      'roundUpId': getRoundupOrgController.orgs.first.roundupId,
                    },
                  );
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async => await _getRoundupStats(),
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
                      () => roundUpController.showDetailedProgress.value
                          ? Skeletonizer(
                              enabled:
                                  roundUpController.isLoadingRoundupStats.value,
                              child: RoundUpProgressChart(
                                totalAmount:
                                    roundupStats?.currentRoundupBalance ?? 0.0,
                                progressPercentage:
                                    roundupStats?.roundupPercentage ?? 0,
                                todaysRoundUp:
                                    roundupStats?.todaysRoundupAmount ?? 0.0,
                                daysLeft: roundupStats?.daysLeft ?? 0,
                                controller: roundUpController,
                                orgName: roundupStats?.organizationName ?? "",
                              ),
                            )
                          : Skeletonizer(
                              enabled:
                                  roundUpController.isLoadingRoundupStats.value,
                              child: RoundUpCard(
                                currentAmount:
                                    roundUpController
                                        .roundupStats
                                        .value
                                        ?.currentRoundupBalance ??
                                    0.0,
                                targetAmount:
                                    roundUpController
                                        .roundupStats
                                        .value
                                        ?.monthlyThreshold
                                        .toDouble() ??
                                    0.0,
                                recentlyRoundedUp:
                                    roundUpController
                                        .roundupStats
                                        .value
                                        ?.lastTransactionAmount ??
                                    0.0,
                                controller: roundUpController,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 20.rh),

                  // Donated To Section
                  Skeletonizer(
                    enabled: getRoundupOrgController.isLoading.value,
                    child: Padding(
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

                          SizedBox(
                            height: 220.rh,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: getRoundupOrgController.orgs.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 8.rw),
                              itemBuilder: (context, index) {
                                final org = getRoundupOrgController.orgs[index];
                                return VerifiedCharityCard(
                                  id: org.organizationId,
                                  title: org.orgName,
                                  location: org.address,
                                  category: org.serviceType,
                                  backgroundColor: Colors.transparent,
                                  imagePath: org.logoImage,
                                  onTap: () async {
                                    // get state by roundupId
                                    final roundupId = org.roundupId;
                                    await roundUpController.fetchRoundupStats(
                                      roundupId,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
