import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/home/wigets/total_donations_card.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            _buildOverviewSection(),
            SizedBox(height: 100.rh), // Space for bottom button
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomDonateButton(),
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
      title: Text(
        'Organization Details',
        style: TextStyle(
          fontFamily: 'Familjen Grotesk',
          fontSize: 20.rfs,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF000C0B),
        ),
      ),
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
                    _buildBadge(Icons.account_balance, Colors.orange),
                    SizedBox(width: 8.rw),
                    _buildBadge(Icons.mosque, const Color(0xFF9D68DE)),
                    SizedBox(width: 8.rw),
                    _buildBadge(Icons.book, const Color(0xFF7790E0)),
                    SizedBox(width: 8.rw),
                    _buildEducationTag(),
                  ],
                ),
                // child: Container(
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 8,
                //     vertical: 4,
                //   ),
                //   clipBehavior: Clip.antiAlias,
                //   decoration: ShapeDecoration(
                //     color: const Color(0xFFDAFFDB),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(24),
                //     ),
                //   ),
                //   child: Text(
                //     "📚 Education",
                //     style: TextStyle(
                //       color: const Color(0xFF000C0B),
                //       fontSize: 10,
                //       fontFamily: 'Inter Display',
                //       fontWeight: FontWeight.w400,
                //       height: 1.20,
                //     ),
                //   ),
                // ),
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
                        style: TextStyle(
                          fontFamily: 'Familjen Grotesk',
                          fontSize: 18.rfs,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF000C0B),
                        ),
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
                            color: Colors.black.withOpacity(0.1),
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

  Widget _buildBadge(IconData icon, Color color) {
    return Container(
      width: 20.rw,
      height: 20.rh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.rw),
      ),
      child: Icon(icon, color: color, size: 12.rfs),
    );
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
          Container(
            width: 20.rw,
            height: 20.rh,
            decoration: BoxDecoration(
              color: const Color(0xFF0F7A15),
              borderRadius: BorderRadius.circular(10.rw),
            ),
            child: Icon(Icons.lightbulb, color: Colors.white, size: 12.rfs),
          ),
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

  Widget _buildDonationStatsCard() {
    return Container(
      padding: EdgeInsets.all(8.rw),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF7EB),
        border: Border.all(color: const Color(0xFFEDEDED)),
        borderRadius: BorderRadius.circular(8.rw),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Total Donations',
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 14.rfs,
                  color: const Color(0xFF000C0B),
                  height: 1.29,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.rh),
          Row(
            children: [
              // User avatars
              SizedBox(
                width: 40.rw,
                height: 16.rh,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: _buildUserAvatar(const Color(0xFFFFC2B8)),
                    ),
                    Positioned(
                      left: 8.rw,
                      child: _buildUserAvatar(const Color(0xFFF6D3BD)),
                    ),
                    Positioned(
                      left: 16.rw,
                      child: _buildUserAvatar(const Color(0xFFEDBBD6)),
                    ),
                    Positioned(
                      left: 24.rw,
                      child: _buildUserAvatar(const Color(0xFFF0F3F4)),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4.rw),
              Text(
                '+983 People have already donated',
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 12.rfs,
                  color: const Color(0xFF657271),
                  height: 1.33,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.rh),
          Text(
            '\$8,328',
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 20.rfs,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF000C0B),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar(Color color) {
    return Container(
      width: 16.rw,
      height: 16.rh,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: const Color(0xFFE4E4E4)),
        borderRadius: BorderRadius.circular(8.rw),
      ),
    );
  }

  Widget _buildOverviewSection() {
    return Container(
      padding: EdgeInsets.all(12.rw),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE4E4E4)),
        borderRadius: BorderRadius.circular(16.rw),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: TextStyle(
              fontFamily: 'Familjen Grotesk',
              fontSize: 16.rfs,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF000C0B),
            ),
          ),
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
    return Container(
      padding: EdgeInsets.all(16.rw),
      decoration: const BoxDecoration(color: Colors.white),
      child: SafeArea(
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
      ),
    );
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
