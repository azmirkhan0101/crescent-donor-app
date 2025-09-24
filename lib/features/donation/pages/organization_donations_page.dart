import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/organization_donations_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/organization_donations_widgets.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Organization Donations Page
///
/// Displays detailed view of an organization with recent donation history
/// including upcoming and previous donations with their status
class OrganizationDonationsPage extends StatelessWidget {
  final String? organizationId;

  const OrganizationDonationsPage({super.key, this.organizationId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrganizationDonationsController());

    return Scaffold(
      backgroundColor: DonationConstants.backgroundColor,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: DonationConstants.paddingVertical.rh,
                left: DonationConstants.paddingHorizontal.rw,
                right: DonationConstants.paddingHorizontal.rw,
                bottom: 100.rh, // Extra space for bottom navigation
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Organization Card
                  OrganizationDetailCard(organization: controller.organization),

                  SizedBox(height: 20.rh),

                  // Recent Donations Section
                  _buildRecentDonationsSection(controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build app bar with back and settings buttons
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: DonationConstants.backgroundColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: Container(
          padding: EdgeInsets.all(12.rw),
          child: SvgPicture.asset(
            Assets.common.arrowLeft.path,
            width: 20.rw,
            height: 20.rh,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // TODO: Handle settings action
          },
          icon: Container(
            padding: EdgeInsets.all(12.rw),
            child: Icon(
              Icons.settings,
              size: 20.rw,
              color: DonationConstants.offBlack,
            ),
          ),
        ),
      ],
    );
  }

  /// Build recent donations section with upcoming and previous donations
  Widget _buildRecentDonationsSection(
    OrganizationDonationsController controller,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.rw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(
            'Recent Donations',
            style: TextStyle(
              fontFamily: DonationFonts.familjenGrotesk,
              fontSize: 20.rfs,
              fontWeight: FontWeight.w600,
              color: DonationConstants.offBlack,
              letterSpacing: -0.2,
            ),
          ),

          SizedBox(height: 12.rh),

          // Donations content container
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.rw),
            decoration: BoxDecoration(
              color: DonationConstants.cardWhite,
              borderRadius: BorderRadius.circular(12.rw),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  offset: Offset(0, 2.rh),
                  blurRadius: 5.rw,
                ),
              ],
            ),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upcoming Donations
                  if (controller.upcomingDonations.isNotEmpty) ...[
                    Text(
                      'Upcoming Donations',
                      style: TextStyle(
                        fontFamily: DonationFonts.interDisplay,
                        fontSize: 11.rfs,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.withValues(alpha: 0.6),
                      ),
                    ),

                    SizedBox(height: 8.rh),

                    ...controller.upcomingDonations.map(
                      (donation) => Padding(
                        padding: EdgeInsets.only(bottom: 8.rh),
                        child: OrganizationDonationItem(
                          donation: donation,
                          isUpcoming: true,
                        ),
                      ),
                    ),

                    SizedBox(height: 12.rh),
                  ],

                  // Previous Donations
                  if (controller.previousDonations.isNotEmpty) ...[
                    Text(
                      'Previous Donations',
                      style: TextStyle(
                        fontFamily: DonationFonts.interDisplay,
                        fontSize: 11.rfs,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.withValues(alpha: 0.6),
                      ),
                    ),

                    SizedBox(height: 12.rh),

                    ...controller.previousDonations.map(
                      (donation) => Padding(
                        padding: EdgeInsets.only(bottom: 12.rh),
                        child: OrganizationDonationItem(
                          donation: donation,
                          isUpcoming: false,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
