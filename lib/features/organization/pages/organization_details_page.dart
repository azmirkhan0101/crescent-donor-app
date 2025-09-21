import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/donation_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/home/widgets/total_donations_card.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class OrganizationDetailsPage extends StatefulWidget {
  final String? organizationId;

  const OrganizationDetailsPage({super.key, this.organizationId});

  @override
  State<OrganizationDetailsPage> createState() =>
      _OrganizationDetailsPageState();
}

class _OrganizationDetailsPageState extends State<OrganizationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.rw),
        child: Column(
          children: [
            _buildOrganizationCard(),
            SizedBox(height: 16.rh),
            _buildImpactCard(),
            SizedBox(height: 16.rh),
            // _buildDonationStatsCard(),
            TotalDonationsCard(color: const Color(0xFFEAF7EB)),
            SizedBox(height: 16.rh),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Overview', style: AppTextStyles.f16W500())
                  .fontFamily(AppStrings.familjenGrotesk)
                  .fontWeight(FontWeight.w600),
            ),
            SizedBox(height: 12.rh),
            _buildOverviewSection(),
            SizedBox(height: 100.rh), // Space for bottom button
          ],
        ),
      ),
      floatingActionButton: _buildBottomDonateButton().paddingXY(X: 56.rw),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
          onPressed: () => Navigator.pop(context),
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

  Widget _buildOrganizationCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEDEDED)),
        borderRadius: BorderRadius.circular(12.rw),
      ),
      child: Column(
        children: [
          // Header Image with Profile Overlay
          Stack(
            children: [
              184.rh.heightWidth,
              Container(
                width: double.infinity,
                height: 144.rh,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.rw)),
                  image: DecorationImage(
                    image: AssetImage(Assets.home.donateCauseBanner1.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// Profile image
              Positioned(
                bottom: 0.rh,
                left: 8.rw,
                child: Container(
                  width: 80,
                  height: 80,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.home.donateCauseProfile2.path),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFEAE9EB) /* Colors-Light-Gray */,
                      ),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
              ),

              /// Category Label
              Positioned(
                bottom: 4.rh,
                right: 8.rw,
                child: Row(
                  children: [
                    _buildBadge(Assets.home.starBadg.path),
                    SizedBox(width: 8.rw),
                    _buildBadge(Assets.home.zakat.path),
                    SizedBox(width: 8.rw),
                    _buildBadge(Assets.home.cresentLight.path),
                    SizedBox(width: 8.rw),
                    _buildEducationTag(),
                  ],
                ),
              ),
            ],
          ),

          8.rh.heightWidth,
          // Content Section
          Padding(
            padding: EdgeInsets.all(16.rw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with Verification
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Hope for Learning Foundation',
                        style: AppTextStyles.f18W600(),
                      ),
                    ),
                    Container(
                      width: 20.rw,
                      height: 20.rh,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC08FFF),
                        borderRadius: BorderRadius.circular(10.rw),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            offset: const Offset(0, 1),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12.rfs,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.rh),

                // Location
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.rw,
                    vertical: 4.rh,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F7F9),
                    border: Border.all(color: const Color(0xFFEDEDED)),
                    borderRadius: BorderRadius.circular(24.rw),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('🌍', style: TextStyle(fontSize: 10.rfs)),
                      SizedBox(width: 4.rw),
                      Text(
                        'South Asia',
                        style: TextStyle(
                          fontFamily: 'Inter Display',
                          fontSize: 12.rfs,
                          color: const Color(0xFF000C0B),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8.rh),

                // Description
                Text(
                  'Turning hope into opportunity through education.',
                  style: TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 12.rfs,
                    color: const Color(0xFF000C0B),
                    height: 1.33,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(dynamic icon) {
    return icon is String
        ? SvgPicture.asset(icon, width: 12.rw, height: 12.rh)
        : Icon(icon, size: 12.rfs);
  }

  Widget _buildEducationTag() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 4.rh),
      decoration: BoxDecoration(
        color: const Color(0xFFDAFFDB),
        border: Border.all(color: const Color(0xFFEDEDED)),
        borderRadius: BorderRadius.circular(24.rw),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('📚', style: TextStyle(fontSize: 10.rfs)),
          SizedBox(width: 4.rw),
          Text(
            'Education',
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 10.rfs,
              color: const Color(0xFF000C0B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactCard() {
    return Container(
      padding: EdgeInsets.all(8.rw),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF7EB),
        border: Border.all(color: const Color(0xFFEDEDED)),
        borderRadius: BorderRadius.circular(8.rw),
      ),
      child: Row(
        children: [
          Assets.home.lightbulb.svg(width: 20.rw, height: 20.rw),
          SizedBox(width: 8.rw),
          Expanded(
            child: Text(
              'Supported over 3,25,000 students since 2021',
              style: TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 14.rfs,
                color: const Color(0xFF000C0B),
                height: 1.29,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewSection() {
    return Container(
      padding: EdgeInsets.all(12.rw),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.rw),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.rh),
          Text(
            'The Hope For Learning Foundation is committed to giving every child—no matter where they\'re from—a fair shot at success. By bridging education gaps, they empower underserved communities globally with access, tools, and opportunity.',
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 14.rfs,
              color: const Color(0xFF000C0B),
              height: 1.43,
            ),
          ),
          SizedBox(height: 12.rh),
          Text(
            'Causes We Support',
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 16.rfs,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF000C0B),
            ),
          ),
          SizedBox(height: 12.rh),
          _buildCauseItem(
            '📘',
            'Education Support',
            'Tutoring, mentorship, and youth development programs to help students thrive academically and emotionally.',
          ),
          SizedBox(height: 12.rh),
          _buildCauseItem(
            '🏫',
            'School Infrastructure',
            'Building and upgrading safe, inclusive learning environments equipped for modern education.',
          ),
          SizedBox(height: 12.rh),
          _buildCauseItem(
            '💡',
            'Essential Utilities',
            'Keeping schools running with electricity, water, and basic necessities—so learning never stops.',
          ),
        ],
      ),
    );
  }

  Widget _buildCauseItem(String emoji, String title, String description) {
    return Padding(
      padding: EdgeInsets.only(left: 8.rw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: TextStyle(fontSize: 14.rfs)),
              SizedBox(width: 8.rw),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 14.rfs,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF000C0B),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.rh),
          Padding(
            padding: EdgeInsets.only(left: 22.rw),
            child: Text(
              description,
              style: TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 12.rfs,
                color: const Color(0xFF000C0B),
                height: 1.33,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomDonateButton() {
    return GestureDetector(
      onTap: () => _showDonationBottomSheet(),
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

  void _showDonationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) =>
            DonationBottomSheet(organizationName: _getOrganizationName()),
      ),
    );
  }

  String _getOrganizationName() {
    // Return organization name - you can modify this based on your data structure
    return 'Hope for Learning Foundation';
  }
}

// Data Models (preserved from original implementation)
class OrganizationData {
  final String id;
  final String name;
  final String description;
  final String location;
  final String category;
  final String logoUrl;
  final String bannerUrl;
  final bool verified;
  final double rating;
  final String totalDonations;
  final int activeCampaigns;
  final String beneficiaries;
  final int establishedYear;
  final String website;
  final String email;
  final String phone;
  final String mission;
  final List<ImpactItem> impact;
  final List<UpdateItem> recentUpdates;

  OrganizationData({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.category,
    required this.logoUrl,
    required this.bannerUrl,
    required this.verified,
    required this.rating,
    required this.totalDonations,
    required this.activeCampaigns,
    required this.beneficiaries,
    required this.establishedYear,
    required this.website,
    required this.email,
    required this.phone,
    required this.mission,
    required this.impact,
    required this.recentUpdates,
  });
}

class ImpactItem {
  final IconData icon;
  final String title;
  final String description;

  ImpactItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class UpdateItem {
  final String title;
  final String description;
  final String date;
  final String imageUrl;

  UpdateItem({
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
  });
}
