import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';

/// Home Page
///
/// The main dashboard of the app displaying welcome message, impact tracking,
/// cause categories, verified charities, and donation opportunities.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.rw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.rh.heightWidth, // Top spacing
              _buildHeader(),
              24.rh.heightWidth,
              _buildImpactSection(),
              32.rh.heightWidth,
              _buildCauseCategories(),
              32.rh.heightWidth,
              _buildVerifiedCharities(),
              32.rh.heightWidth,
              _buildDonateForCause(),
              100.rh.heightWidth, // Bottom spacing for navigation
            ],
          ),
        ),
      ),
    );
  }

  /// Build the header with welcome message, profile, and notification
  Widget _buildHeader() {
    return Row(
      children: [
        // Profile image
        Container(
          width: 48.rw,
          height: 48.rh,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF8B5CF6),
          ),
          child: Center(
            child: Assets.home.profileImage.svg(width: 32.rw, height: 32.rh),
          ),
        ),
        16.rw.heightWidth,
        // Welcome text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome back!",
                style: AppTextStyles.f14W400().copyWith(
                  color: const Color(0xFF64748B),
                  fontSize: 14.rfs,
                ),
              ),
              4.rh.heightWidth,
              Text(
                "Talha S.",
                style: AppTextStyles.baseStyle().copyWith(
                  fontSize: 20.rfs,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        // Search and notification icons
        Row(
          children: [
            Container(
              width: 40.rw,
              height: 40.rh,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.rw),
              ),
              child: Center(
                child: Assets.home.search.svg(width: 20.rw, height: 20.rh),
              ),
            ),
            12.rw.heightWidth,
            Container(
              width: 40.rw,
              height: 40.rh,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.rw),
              ),
              child: Center(
                child: Stack(
                  children: [
                    Assets.home.notification.svg(width: 20.rw, height: 20.rh),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Assets.home.redDot.svg(width: 8.rw, height: 8.rh),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build the impact tracking section
  Widget _buildImpactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "You're making real change!",
          style: AppTextStyles.baseStyle().copyWith(
            fontSize: 24.rfs,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        8.rh.heightWidth,
        Text(
          "Track your impact, explore causes, and donate on your terms.",
          style: AppTextStyles.f14W400().copyWith(
            color: const Color(0xFF64748B),
            fontSize: 16.rfs,
          ),
        ),
      ],
    );
  }

  /// Build the cause categories chips
  Widget _buildCauseCategories() {
    final categories = [
      {"icon": "💧", "label": "Water", "color": const Color(0xFFDDEFFF)},
      {"icon": "📚", "label": "Education", "color": const Color(0xFFD4F8D4)},
      {"icon": "🍯", "label": "Food", "color": const Color(0xFFFFF2D4)},
      {"icon": "👫", "label": "Youth", "color": const Color(0xFFE0F7FA)},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Container(
            margin: EdgeInsets.only(right: 12.rw),
            padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 12.rh),
            decoration: BoxDecoration(
              color: category["color"] as Color,
              borderRadius: BorderRadius.circular(20.rw),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  category["icon"] as String,
                  style: TextStyle(fontSize: 16.rfs),
                ),
                8.rw.heightWidth,
                Text(
                  category["label"] as String,
                  style: AppTextStyles.baseStyle().copyWith(
                    fontSize: 14.rfs,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Build the verified charities section
  Widget _buildVerifiedCharities() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Verified Charities",
              style: AppTextStyles.baseStyle().copyWith(
                fontSize: 20.rfs,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              "View all",
              style: AppTextStyles.f14W400().copyWith(
                color: const Color(0xFF8B5CF6),
                fontSize: 14.rfs,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        16.rh.heightWidth,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildCharityCard(
                "Hope for Learning Foundation",
                "South Asia",
                "🎓 Education",
                const Color(0xFFFFB5B5),
                Assets.home.varifiedCharitiesBlog1.path,
              ),
              12.rw.heightWidth,
              _buildCharityCard(
                "Healing Hands International",
                "Sydney, Australia",
                "🏥 Health",
                const Color(0xFFE6D7FF),
                Assets.home.varifiedCharitiesBlog2.path,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build individual charity card
  Widget _buildCharityCard(
    String title,
    String location,
    String category,
    Color backgroundColor,
    String imagePath,
  ) {
    return Container(
      width: 200.rw,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.rw),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Charity image/icon
          Container(
            width: double.infinity,
            height: 120.rh,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.rw),
                topRight: Radius.circular(16.rw),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 8.rh,
                  right: 8.rw,
                  child: Container(
                    padding: EdgeInsets.all(8.rw),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Assets.home.premiumCheckmark.svg(
                      width: 16.rw,
                      height: 16.rh,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.rw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: AppTextStyles.f14W400().copyWith(
                    color: const Color(0xFF10B981),
                    fontSize: 12.rfs,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                4.rh.heightWidth,
                Text(
                  title,
                  style: AppTextStyles.baseStyle().copyWith(
                    fontSize: 16.rfs,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                4.rh.heightWidth,
                Text(
                  location,
                  style: AppTextStyles.f14W400().copyWith(
                    color: const Color(0xFF64748B),
                    fontSize: 12.rfs,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build the donate for cause section
  Widget _buildDonateForCause() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Donate for Cause",
              style: AppTextStyles.baseStyle().copyWith(
                fontSize: 20.rfs,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              "View all",
              style: AppTextStyles.f14W400().copyWith(
                color: const Color(0xFF8B5CF6),
                fontSize: 14.rfs,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        16.rh.heightWidth,
        Column(
          children: [
            _buildDonationCard(
              "Bringing education to rural villages.",
              "🍯 Food",
              "\$8,328",
              "+983 People have already donated",
              Assets.home.donateCauseBanner1.path,
            ),
            16.rh.heightWidth,
            _buildDonationCard(
              "Healing Hands International",
              "🎓 Education",
              "\$8,328",
              "+983 People have already donated",
              Assets.home.donateCauseBanner2.path,
            ),
          ],
        ),
      ],
    );
  }

  /// Build individual donation card
  Widget _buildDonationCard(
    String title,
    String category,
    String amount,
    String donors,
    String imagePath,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.rw),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Campaign image
          Container(
            width: double.infinity,
            height: 180.rh,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.rw),
                topRight: Radius.circular(16.rw),
              ),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 12.rh,
                  left: 12.rw,
                  child: Container(
                    padding: EdgeInsets.all(8.rw),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Assets.home.premiumCheckmark.svg(
                      width: 24.rw,
                      height: 24.rh,
                    ),
                  ),
                ),
                Positioned(
                  top: 12.rh,
                  right: 12.rw,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.rw,
                      vertical: 6.rh,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF2D4),
                      borderRadius: BorderRadius.circular(12.rw),
                    ),
                    child: Text(
                      category,
                      style: AppTextStyles.f14W400().copyWith(
                        color: Colors.black,
                        fontSize: 12.rfs,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Campaign details
          Padding(
            padding: EdgeInsets.all(16.rw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.baseStyle().copyWith(
                    fontSize: 18.rfs,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                16.rh.heightWidth,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.rw),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDEFFF),
                    borderRadius: BorderRadius.circular(12.rw),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Donations",
                        style: AppTextStyles.f14W400().copyWith(
                          color: const Color(0xFF64748B),
                          fontSize: 14.rfs,
                        ),
                      ),
                      4.rh.heightWidth,
                      Row(
                        children: [
                          // Profile images stack
                          SizedBox(
                            width: 80.rw,
                            height: 24.rh,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  child: Container(
                                    width: 24.rw,
                                    height: 24.rh,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          Assets.home.user1.path,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 16.rw,
                                  child: Container(
                                    width: 24.rw,
                                    height: 24.rh,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          Assets.home.user2.path,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 32.rw,
                                  child: Container(
                                    width: 24.rw,
                                    height: 24.rh,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          Assets.home.user3.path,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 48.rw,
                                  child: Container(
                                    width: 24.rw,
                                    height: 24.rh,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          Assets.home.user4.path,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          8.rw.heightWidth,
                          Text(
                            donors,
                            style: AppTextStyles.f14W400().copyWith(
                              color: const Color(0xFF64748B),
                              fontSize: 12.rfs,
                            ),
                          ),
                        ],
                      ),
                      8.rh.heightWidth,
                      Text(
                        amount,
                        style: AppTextStyles.baseStyle().copyWith(
                          fontSize: 28.rfs,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
