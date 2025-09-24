import 'package:cresent_charge_user_app/features/donation/controllers/recurring_donations_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/recurring_donations_widgets.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Recurring Donations Page
///
/// Shows recurring donation summary and list of organizations
class RecurringDonationsPage extends StatelessWidget {
  const RecurringDonationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecurringDonationsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: DonationConstants.offBlack,
            size: 24.rw,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Recurring',
          style: TextStyle(
            fontFamily: DonationFonts.familjenGrotesk,
            fontSize: 20.rfs,
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
              size: 20.rw,
            ),
            onPressed: () {
              // Handle settings tap
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.rw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.rh),

              // Summary Card
              RecurringSummaryCard(
                totalAmount: controller.totalWeeklyAmount.value,
                weeklyAmount: controller.weeklyAmount.value,
                organizationCount: controller.recurringDonations.length,
              ),

              SizedBox(height: 20.rh),

              // Organizations Section
              Text(
                'Organizations',
                style: TextStyle(
                  fontFamily: DonationFonts.familjenGrotesk,
                  fontSize: 20.rfs,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF171717),
                  height: 24 / 20,
                ),
              ),

              SizedBox(height: 12.rh),

              // Organizations List
              Obx(
                () => Column(
                  children: controller.recurringDonations
                      .map(
                        (donation) => Padding(
                          padding: EdgeInsets.only(bottom: 8.rh),
                          child: RecurringOrganizationCard(
                            donation: donation,
                            onTap: () => controller.onDonationTapped(donation),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),

              SizedBox(height: 100.rh), // Bottom padding for safe area
            ],
          ),
        ),
      ),
    );
  }
}
