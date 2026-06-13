import 'package:cresent_charge_user_app/features/donation/controllers/donation_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_badges_progress_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/badges_section.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/calender_sections.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/donation_components.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/overview_section.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/section_header.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_point_balance_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../profile/controllers/get_profile_controller.dart';

/// Donation Page
///
/// This page displays donation overview, progress tracking, calendar, and achievements.
/// Users can track their contributions, view donation history, and manage future donations.
class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final donationController = Get.find<DonationController>();
  final getBalanceController = Get.find<GetPointBalanceController>();
  final getBadgesProgressController = Get.find<GetBadgesProgressController>();
  final getProfileController = Get.isRegistered<GetProfileController>()
      ? Get.find<GetProfileController>() : Get.put(GetProfileController());

  Future<void> _refreshData() async {
    await Future.wait([
      donationController.fetchClientStats(roundupId: donationController.roundUpIds.isNotEmpty ? donationController.roundUpIds.first : ""),
      getBalanceController.fetchUserPoints(),
      getBadgesProgressController.fetchBadgesProgress(),
    ]);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: DonationConstants.backgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          color: DonationConstants.primaryPurple,
          child: CustomScrollView(
            slivers: [
              // Header section with profile and points
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 8.rh),
                    Obx(() {
                      return DonationHeader(
                        // profileImageUrl:
                        //     getBalanceController.balance.value?.user?.image,
                        profileImageUrl:
                        getProfileController.profile.value?.image ?? "",
                        pointsEarned:
                            getBalanceController.balance.value?.currentBalance
                                .toString() ??
                            '0',
                        filterText: donationController.selectedFilter.value,
                        onFilterTap: _showFilterOptions,
                      );
                    }),

                    SizedBox(height: 20.rh),
                  ],
                ),
              ),

              // Overview Section
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const OverviewSection(),
                    SizedBox(height: 20.rh),
                  ],
                ),
              ),

              // Track Progress Section
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SectionHeader(title: 'Track Progress'),
                    SizedBox(height: DonationConstants.sectionSpacing.rh),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: DonationConstants.paddingHorizontal.rw,
                      ),
                      child: ProgressTrackingCard(
                        // totalAmount: '120.75',
                        // avgDailyAmount: '4.025',
                        // donationStreak: '36',
                      ),
                    ),
                    SizedBox(height: DonationConstants.paddingVertical.rh),
                  ],
                ),
              ),

              // Calendar Section
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const CalendarSection(),
                    SizedBox(height: DonationConstants.paddingVertical.rh),
                  ],
                ),
              ),

              // Upcoming Donations Section
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SectionHeader(title: 'Upcoming Donations'),
                    SizedBox(height: DonationConstants.sectionSpacing.rh),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: DonationConstants.paddingHorizontal.rw,
                      ),
                      child: GetX<DonationController>(
                        builder: (controller) {
                          final upcomingDonations =
                              controller.clientStats.value?.upcomingDonations ??
                              [];
                          if (upcomingDonations.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return SizedBox(
                            height: 165.rh,
                            child: ListView.separated(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    DonationConstants.paddingHorizontal.rw,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: upcomingDonations.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: DonationConstants.cardSpacing.rw,
                                );
                              },
                              itemBuilder: (context, index) {
                                final donation = upcomingDonations[index];
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width - 48,
                                  child: UpcomingDonationCard(
                                    scheduledDate: DateFormat(
                                      'd MMM - hh:mm a',
                                    ).format(DateTime.parse(donation.nextDate)),
                                    organizationName: donation.organizationName,
                                    organizationLocation:
                                        '${donation.organizationAddress}, ${donation.organizationState}',
                                    donationAmount: donation.amount.toString(),
                                    organizationImage:
                                        donation.organizationLogo,
                                  ),
                                );
                              },
                            ),
                          );
                          // final donation = upcomingDonations.first;
                          // return UpcomingDonationCard(
                          //   scheduledDate: DateFormat(
                          //     'd MMM - hh:mm a',
                          //   ).format(DateTime.parse(donation.nextDate)),
                          //   organizationName: donation.organizationName,
                          //   organizationLocation:
                          //       '${donation.organizationAddress}, ${donation.organizationState}',
                          //   donationAmount: donation.amount.toString(),
                          //   organizationImage: donation.organizationLogo,
                          // );
                        },
                      ),
                    ),
                    SizedBox(height: DonationConstants.paddingVertical.rh),
                  ],
                ),
              ),

              // Badges Section
              SliverToBoxAdapter(child: const BadgesSection()),

              // Bottom padding for navigation bar
              SliverToBoxAdapter(child: SizedBox(height: 100.rh)),
            ],
          ),
        ),
      ),
    );
  }

  /// Shows filter options bottom sheet
  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: DonationConstants.cardWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.rw)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.rw),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Donations',
              style: TextStyle(
                fontFamily: DonationFonts.familjenGrotesk,
                fontSize: 18.rfs,
                fontWeight: FontWeight.w600,
                color: DonationConstants.offBlack,
              ),
            ),
            SizedBox(height: 20.rh),
            _buildFilterOption('Total'),
            _buildFilterOption('Last 30 Days'),
            SizedBox(height: 20.rh),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String text) {
    final controller = Get.find<DonationController>();
    final isSelected = controller.selectedFilter.value == text;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Update the filter value
        controller.selectedFilter.value = text;
        context.pop();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.rh),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[100] : null,
          border: Border(
            bottom: BorderSide(color: DonationConstants.lightGray, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                fontFamily: DonationFonts.interDisplay,
                fontSize: 16.rfs,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? DonationConstants.primaryPurpleDark
                    : DonationConstants.offBlack,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                size: 20.rfs,
                color: DonationConstants.primaryPurpleDark,
              ),
          ],
        ),
      ),
    );
  }
}
