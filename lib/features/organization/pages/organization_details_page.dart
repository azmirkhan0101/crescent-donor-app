import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/features/home/widgets/total_donations_card.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/organization_details_controller.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/donation_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/impact_card_widget.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/organization_header_widget.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/overview_section_widget.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OrganizationDetailsPage extends StatelessWidget {
  final String? organizationId;

  const OrganizationDetailsPage({super.key, this.organizationId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrganizationDetailsController>(
      init: OrganizationDetailsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: CustomAppBar(
            title: 'Organization Details',
            backgroundColor: const Color(0xFFF7F7F7),
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.error.value.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.error.value),
                    ElevatedButton(
                      onPressed: () => controller.refreshData(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final organization = controller.organization.value;
            if (organization == null) {
              return const Center(child: Text('Organization not found'));
            }

            return RefreshIndicator(
              onRefresh: controller.refreshData,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.rw),
                child: Column(
                  children: [
                    OrganizationHeaderWidget(organization: organization),
                    SizedBox(height: 16.rh),
                    ImpactCardWidget(
                      impactText: controller.getOrganizationImpact(),
                    ),
                    SizedBox(height: 16.rh),
                    TotalDonationsCard(color: const Color(0xFFEAF7EB)),
                    SizedBox(height: 16.rh),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Overview', style: AppTextStyles.f16W500())
                          .fontFamily(AppStrings.familjenGrotesk)
                          .fontWeight(FontWeight.w600),
                    ),
                    SizedBox(height: 12.rh),
                    OverviewSectionWidget(
                      mission: controller.getOrganizationMission(),
                      causes: controller.getOrganizationCauses(),
                    ),
                    SizedBox(height: 100.rh), // Space for bottom button
                  ],
                ),
              ),
            );
          }),
          floatingActionButton: Builder(
            builder: (context) => GetBuilder<OrganizationDetailsController>(
              builder: (controller) =>
                  _buildBottomDonateButton(controller, context),
            ).paddingXY(X: 56.rw),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
      centerTitle: true,
      leading: Container(
        margin: EdgeInsets.all(8.rw),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFEDEDED)),
          borderRadius: BorderRadius.circular(24.rw),
        ),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(
            'assets/common/arrow-left.svg',
            width: 20.rw,
            height: 20.rh,
            colorFilter: const ColorFilter.mode(
              Color(0xFF000C0B),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
      title: Text('Organization Details', style: AppTextStyles.f20w600()),
    );
  }

  Widget _buildBottomDonateButton(
    OrganizationDetailsController controller,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        controller.onDonateNowTapped();
        _showDonationBottomSheet(controller, context);
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

  void _showDonationBottomSheet(
    OrganizationDetailsController controller,
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => DonationBottomSheet(
          organizationName: controller.getOrganizationName(),
        ),
      ),
    );
  }
}
