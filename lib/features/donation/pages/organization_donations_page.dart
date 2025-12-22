import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_recurring_org_state_controller.dart';
import 'package:cresent_charge_user_app/features/donation/models/recurring_org_state_data_model.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/organization_donations_widgets.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrganizationDonationsPage extends StatelessWidget {
  final String organizationId;

  const OrganizationDonationsPage({super.key, required this.organizationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DonationConstants.backgroundColor,
      appBar: _buildAppBar(context),
      body: GetX<GetRecurringOrgStateController>(
        initState: (state) {
          if (organizationId.isNotEmpty) {
            state.controller?.fetchRecurringOrgState(organizationId);
          }
        },
        builder: (controller) {
          final organizationData =
              controller.recurringOrgStateDataModel.value?.organization;
          return SingleChildScrollView(
            padding: EdgeInsets.only(
              top: DonationConstants.paddingVertical.rh,
              left: DonationConstants.paddingHorizontal.rw,
              right: DonationConstants.paddingHorizontal.rw,
              bottom: 100.rh, // Extra space for bottom navigation
            ),
            child: Skeletonizer(
              enabled: controller.isLoading.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Organization Card
                  Skeletonizer(
                    enabled: controller.isLoading.value,
                    child: OrganizationDetailCard(
                      coverImageUrl: organizationData?.coverImage,
                      logoUrl: organizationData?.logoImage,
                      orgName: organizationData?.name,
                      serviceType: organizationData?.serviceType,
                      state: organizationData?.state,
                      aboutUs: organizationData?.aboutUs,
                      // tags: [],
                      // isVerified: false,
                    ),
                  ),

                  SizedBox(height: 20.rh),

                  // Recent Donations Section
                  _buildRecentDonationsSection(
                    recurringStateData:
                        controller.recurringOrgStateDataModel.value,
                  ),
                ],
              ),
            ),
          );
        },
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
  Widget _buildRecentDonationsSection({
    required RecurringOrgStateDataModel? recurringStateData,
  }) {
    final previousDonations = recurringStateData?.previousDonations ?? [];
    final upcomingDonations = recurringStateData?.upcomingDonations ?? [];
    return Column(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Upcoming Donations
              if (upcomingDonations.isNotEmpty) ...[
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

                // ...upcomingDonations.map((donation)=> Padding(
                //       padding: EdgeInsets.only(bottom: 8.rh),
                //       child: OrganizationDonationItem(
                //         donation: donation,
                //         isUpcoming: true,
                //       ),
                //     )),
                ...upcomingDonations.map(
                  (donation) => Padding(
                    padding: EdgeInsets.only(bottom: 8.rh),
                    child: OrganizationDonationItem(
                      upcomingModel: donation,
                      isUpcoming: true,
                    ),
                  ),
                ),

                SizedBox(height: 12.rh),
              ],

              // Previous Donations
              if (previousDonations.isNotEmpty) ...[
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

                ...previousDonations.map(
                  (donation) => Padding(
                    padding: EdgeInsets.only(bottom: 12.rh),
                    child: OrganizationDonationItem(
                      previousModel: donation,
                      isUpcoming: false,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
