import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/donation_components.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/donation_sections.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DonationConstants.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header section with profile and points
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 8.rh),
                  DonationHeader(
                    pointsEarned: '16000',
                    filterText: 'Last 30 Days',
                    onFilterTap: _showFilterOptions,
                  ),
                  SizedBox(height: DonationConstants.paddingVertical.rh),
                ],
              ),
            ),

            // Overview Section
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const OverviewSection(),
                  SizedBox(height: DonationConstants.paddingVertical.rh),
                ],
              ),
            ),

            // Track Progress Section
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SectionHeader(title: 'Track Progress'),
                  SizedBox(height: DonationConstants.sectionSpacing.rh),
                  SectionContainer(
                    child: ProgressTrackingCard(
                      totalAmount: '120.75',
                      avgDailyAmount: '4.025',
                      donationStreak: '36',
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
                  SectionContainer(
                    child: UpcomingDonationCard(
                      scheduledDate: '17 July - 10:00 AM',
                      organizationName: 'Hope for Learning Foundation',
                      organizationLocation: 'Sydney, Australia',
                      donationAmount: '5.50',
                    ),
                  ),
                  SizedBox(height: DonationConstants.paddingVertical.rh),
                ],
              ),
            ),

            // Badges Section
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const BadgesSection(),
                  SizedBox(height: DonationConstants.paddingVertical.rh),
                ],
              ),
            ),

            // Bottom padding for navigation bar
            SliverToBoxAdapter(child: SizedBox(height: 100.rh)),
          ],
        ),
      ),
    );
  }

  /// Shows filter options bottom sheet
  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
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
            _buildFilterOption('Last 7 Days'),
            _buildFilterOption('Last 30 Days', isSelected: true),
            _buildFilterOption('Last 3 Months'),
            _buildFilterOption('Last Year'),
            SizedBox(height: 20.rh),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String text, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        // Handle filter selection
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.rh),
        decoration: BoxDecoration(
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
