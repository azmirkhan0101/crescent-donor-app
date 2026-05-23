import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/recurring_states_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/recurring_donations_widgets.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helper/extension/context_extension.dart';

/// Recurring Donations Page
///
/// Shows recurring donation summary and list of organizations
class RecurringDonationsPage extends StatelessWidget {
  const RecurringDonationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.rw),
          child: GetX<RecurringStatesController>(
            initState: (state) {
              Get.find<RecurringStatesController>().fetchRecurringStates();
            },
            builder: (controller) {
              // if (controller.isLoading.value) {
              //   return Center(
              //     child: CircularProgressIndicator(
              //       color: AppColors.primaryColor,
              //     ),
              //   );
              // }

              return Skeletonizer(
                enabled: controller.isLoading.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.rh),

                    // Summary Card
                    RecurringSummaryCard(
                      totalAmount:
                          controller
                              .recurringStates
                              .value
                              ?.todaysRecurringAmount ??
                          0,
                      weeklyAmount:
                          controller
                              .recurringStates
                              .value
                              ?.totalWeeklyRecurringAmount ??
                          0,
                      organizationCount:
                          controller.recurringStates.value?.organizationCount ??
                          0,
                    ),

                    SizedBox(height: 20.rh),

                    // Organizations Section
                    Text(
                      'Organizations',
                      style: TextStyle(
                        fontFamily: DonationFonts.familjenGrotesk,
                        fontSize: isTab ? 8.sp : 20.rfs,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF171717),
                        height: 24 / 20,
                      ),
                    ),

                    SizedBox(height: 12.rh),

                    // Organizations List
                    Skeletonizer(
                      enabled: controller.isLoading.value,
                      child: Column(
                        children:
                            controller.recurringStates.value?.donations
                                .map(
                                  (donation) => Padding(
                                    padding: EdgeInsets.only(bottom: 8.rh),
                                    child: RecurringOrganizationCard(
                                      donation: donation,
                                      onTap: () {
                                        context.pushNamed(
                                          RoutePath.organizationDonations,
                                          extra: {
                                            'organizationId':
                                                donation.organizationDetails.id,
                                          },
                                        );
                                      },
                                      // onTap: () => controller.onDonationTapped(donation),
                                    ),
                                  ),
                                )
                                .toList() ??
                            [],
                      ),
                    ),

                    SizedBox(height: 100.rh), // Bottom padding for safe area
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    bool isTab = context.isTab;
    return AppBar(
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: DonationConstants.offBlack,
          size: isTab ? 40 : 24.rw,
        ),
        onPressed: () => context.pop(),
      ),
      title: Text(
        'Recurring',
        style: TextStyle(
          fontFamily: DonationFonts.familjenGrotesk,
          fontSize: isTab ? 8.sp : 20.rfs,
          fontWeight: FontWeight.w700,
          color: DonationConstants.offBlack,
          height: 24 / 20,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings,
            color: DonationConstants.offBlack,
            size: isTab ? 40 : 20.rw,
          ),
          onPressed: () {
            // Handle settings tap
            context.pushNamed(RoutePath.settings, extra: {
              'isRecurring': true,
              'roundUpId': ""
            },);
          },
        ),
      ],
    );
  }
}
