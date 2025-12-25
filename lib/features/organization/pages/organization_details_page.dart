import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/home/widgets/org_details_total_donate_card.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/donate_now_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/organization_controller.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/donation_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/impact_card_widget.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/organization_header_widget.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/overview_section_widget.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrganizationDetailsPage extends StatefulWidget {
  const OrganizationDetailsPage({super.key, required this.organizationId});
  final String organizationId;

  @override
  State<OrganizationDetailsPage> createState() =>
      _OrganizationDetailsPageState();
}

class _OrganizationDetailsPageState extends State<OrganizationDetailsPage> {
  // final orgController = Get.find<OrganizationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: CustomAppBar(
        title: 'Organization Details',
        backgroundColor: const Color(0xFFF7F7F7),
      ),
      body: GetX<OrganizationController>(
        initState: (state) {
          state.controller!.fetchOrganizationDetails(widget.organizationId);
        },
        builder: (controller) {
          final organizationDetails = controller.organizationDetails.value;

          if (controller.error.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.error.value),
                  ElevatedButton(
                    onPressed: () => controller.fetchOrganizationDetails(
                      widget.organizationId,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!controller.isLoadingOrgById.value &&
              organizationDetails == null) {
            return const Center(child: Text('Organization not found'));
          }

          return RefreshIndicator(
            onRefresh: () =>
                controller.fetchOrganizationDetails(widget.organizationId),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.rw),
              child: Skeletonizer(
                enabled: controller.isLoadingOrgById.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrganizationHeaderWidget(
                      // organization: organizationDetails!,
                      coverImage: organizationDetails?.coverImage,
                      logoImage: organizationDetails?.logoImage,
                      name: organizationDetails?.name,
                      address: organizationDetails?.address,
                      state: organizationDetails?.state,
                      aboutUs:
                          "Turning hope into opportunity through education.",
                    ),
                    SizedBox(height: 16.rh),
                    ImpactCardWidget(
                      impactText: 'Supported over 3,25,000 students since 2021',
                      // impactText: organizationDetails.aboutUs,
                    ),
                    SizedBox(height: 16.rh),
                    OrgDetailTotalDonationsCard(
                      color: const Color(0xFFEAF7EB),
                      totalDonatedAmount:
                          organizationDetails?.totalDonationAmount.toDouble() ??
                          0.0,
                      totalDonors: organizationDetails?.totalDonation ?? 0,
                      recentDonorsImageUrl: [
                        ...organizationDetails?.recentDonors
                                .map((donor) => donor.donorImage)
                                .toList() ??
                            [],
                      ],
                      // organizationDetails?.recentDonors ?? [],
                    ),
                    SizedBox(height: 16.rh),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Overview', style: AppTextStyles.f16W500())
                          .fontFamily(AppStrings.familjenGrotesk)
                          .fontWeight(FontWeight.w600),
                    ),
                    SizedBox(height: 12.rh),

                    /// Overview Section
                    OverviewSectionWidget(
                      mission:
                          controller.organizationDetails.value?.aboutUs ?? '',
                      causes:
                          controller.organizationDetails.value?.causes ?? [],
                    ),
                    SizedBox(height: 100.rh), // Space for bottom button
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) =>
            _buildBottomDonateButton(context).paddingXY(X: 56.rw),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBottomDonateButton(BuildContext context) {
    OrganizationController controller = Get.find<OrganizationController>();
    DonateNowController donateNowController = Get.find<DonateNowController>();

    return GestureDetector(
      onTap: () {
        // Update organizationId before opening bottom sheet
        final currentOrgId = controller.organizationDetails.value?.id;
        if (currentOrgId != null) {
          donateNowController.organizationId.value = currentOrgId;
        }

        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.85,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, scrollController) => DonationBottomSheet(
              organizationName:
                  controller.organizationDetails.value?.name ?? 'N/A',
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.rh),
        decoration: BoxDecoration(
          color: const Color(0xFF000C0B),
          borderRadius: BorderRadius.circular(12.rw),
        ),
        child: Text(
          'Donate Now',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Familjen Grotesk',
            fontSize: 18.rfs,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
