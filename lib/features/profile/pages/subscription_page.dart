import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';

/// Subscription Page
///
/// This page displays subscription plans and features for users to upgrade
/// their experience with premium features and benefits.
class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  // Selected plan (0 = Free, 1 = 6 Months)
  int _selectedPlan = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Overlay
          _buildBackgroundImage(),

          // Content
          SafeArea(
            child: Column(
              children: [
                // App Bar
                _buildAppBar(),
                16.rh.heightWidth,
                // Header Section
                _buildHeaderSection(),
                Spacer(),

                _buildSubscriptionContent(),
              ],
            ).paddingX(20.rw),
          ),
        ],
      ),
    );
  }

  /// Build background image with gradient overlay
  Widget _buildBackgroundImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/profile/background-image.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.7),
              Colors.black.withValues(alpha: 0.0),
              Colors.black.withValues(alpha: 0.0),
              Colors.black,
            ],
            stops: const [0.0, 0.5, 0.82, 1.0],
          ),
        ),
      ),
    );
  }

  /// Build app bar with back button and title
  Widget _buildAppBar() {
    return Container(
      height: 64.rh,
      padding: EdgeInsets.symmetric(horizontal: 16.rw),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: EdgeInsets.all(12.rw),
              child: SvgPicture.asset(
                Assets.common.arrowLeft.path,
                width: 20.rw,
                height: 20.rh,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          // Title
          Expanded(
            child: Text(
              'Subscriptions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: DonationFonts.familjenGrotesk,
                fontSize: 20.rfs,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.2,
              ),
            ),
          ),

          // Space for symmetry
          SizedBox(width: 44.rw),
        ],
      ),
    );
  }

  /// Build header section with title and description
  Widget _buildHeaderSection() {
    return Column(
      children: [
        Text(
          'Start making an effortless impact',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: 32.rfs,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.125,
          ),
        ),

        SizedBox(height: 16.rh),

        Text(
          'Give your way, grow your impact, unlock little wins as you go.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: 16.rfs,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            height: 1.25,
          ),
        ),
      ],
    );
  }

  /// Build subscription content with features and plans
  Widget _buildSubscriptionContent() {
    return Column(
      children: [
        // Features Section
        _buildFeaturesSection(),

        SizedBox(height: 20.rh),

        // Subscription Plans
        _buildSubscriptionPlans(),

        SizedBox(height: 20.rh),

        // Subscribe Button
        _buildSubscribeButton(),
      ],
    );
  }

  /// Build features section with three feature icons
  Widget _buildFeaturesSection() {
    return Column(
      children: [
        Row(
          children: [
            // Feature 1: Monthly Impact
            Expanded(
              child: _buildFeatureItem(
                icon: Assets.common.gift.path,
                backgroundColor: const Color(0xFFE6D4FF),
                title: 'Make an impact monthly, effortlessly',
              ),
            ),

            SizedBox(width: 8.rw),

            // Feature 2: Brand Rewards
            Expanded(
              child: _buildFeatureItem(
                icon: Assets.profile.exclusiveBrandReward.path,
                backgroundColor: const Color(0xFFB5E0FF),
                title: 'Unlock exclusive brand rewards',
              ),
            ),

            SizedBox(width: 8.rw),

            // Feature 3: Perks & Badges
            Expanded(
              child: _buildFeatureItem(
                icon: Assets.common.starFilled.path,
                backgroundColor: const Color(0xFFFFE8FD),
                title: 'Get surprise perks & milestone badge',
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build individual feature item
  Widget _buildFeatureItem({
    required String icon,
    required Color backgroundColor,
    required String title,
  }) {
    return Column(
      children: [
        // Icon Container
        Container(
          padding: EdgeInsets.all(10.rw),
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            icon,
            width: 24.rw,
            height: 24.rh,
            colorFilter: const ColorFilter.mode(
              Color(0xFF000C0B),
              BlendMode.srcIn,
            ),
          ),
        ),

        SizedBox(height: 12.rh),

        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: 12.rfs,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFEBE9EC),
            height: 1.33,
          ),
        ),
      ],
    );
  }

  /// Build subscription plans section
  Widget _buildSubscriptionPlans() {
    return Row(
      children: [
        // Free Plan
        Expanded(
          child: _buildPlanCard(
            planIndex: 0,
            title: 'Free',
            price: '\$0.00',
            subtitle: 'Stay on Free Plan',
            description: 'Stay on Free Plan.',
            isSelected: _selectedPlan == 0,
          ),
        ),

        SizedBox(width: 8.rw),

        // 6 Months Plan
        Expanded(
          child: _buildPlanCard(
            planIndex: 1,
            title: '6 Months',
            price: '\$40.00',
            description: '',
            features: ['Save 20%.', 'Free 1 Week Trial.'],
            isSelected: _selectedPlan == 1,
          ),
        ),
      ],
    );
  }

  /// Build individual plan card
  Widget _buildPlanCard({
    required int planIndex,
    required String title,
    required String price,
    String? subtitle,
    required String description,
    List<String>? features,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = planIndex;
        });
      },
      child: Container(
        height: 164.rh,
        padding: EdgeInsets.all(16.rw),
        decoration: BoxDecoration(
          color: const Color(0xFF000C0B),
          borderRadius: BorderRadius.circular(18.rw),
          border: isSelected
              ? Border.all(color: const Color(0xFFD1FF43), width: 2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: 16.rfs,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.25,
                  ),
                ),

                SizedBox(height: 12.rh),

                if (subtitle != null)
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: DonationFonts.interDisplay,
                        fontSize: 20.rfs,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(text: price),
                        const TextSpan(text: ' '),
                        TextSpan(text: subtitle),
                      ],
                    ),
                  )
                else
                  Text(
                    price,
                    style: TextStyle(
                      fontFamily: DonationFonts.interDisplay,
                      fontSize: 20.rfs,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
              ],
            ),

            // Features or Description
            if (features != null && features.isNotEmpty)
              Column(
                children: features
                    .map((feature) => _buildFeatureBullet(feature))
                    .toList(),
              )
            else
              Text(
                description,
                style: TextStyle(
                  fontFamily: DonationFonts.interDisplay,
                  fontSize: 14.rfs,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFEBE9EC),
                  height: 1.29,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Build feature bullet point
  Widget _buildFeatureBullet(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.rh),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 8.rw,
            height: 8.rh,
            decoration: BoxDecoration(
              color: const Color(0xFFD1FF43),
              borderRadius: BorderRadius.circular(2.rw),
            ),
          ),

          SizedBox(width: 8.rw),

          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: DonationFonts.interDisplay,
                fontSize: 14.rfs,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFEBE9EC),
                height: 1.29,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build subscribe button
  Widget _buildSubscribeButton() {
    return SizedBox(
      width: 263.rw,
      height: 52.rh,
      child: ElevatedButton(
        onPressed: _handleSubscribe,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD1FF43),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.rw),
          ),
        ),
        child: Text(
          'Subscribe',
          style: TextStyle(
            fontFamily: DonationFonts.familjenGrotesk,
            fontSize: 18.rfs,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF000C0B),
            letterSpacing: -0.36,
          ),
        ),
      ),
    );
  }

  /// Build home indicator
  Widget _buildHomeIndicator() {
    return SizedBox(
      height: 21.rh,
      child: Center(
        child: Container(
          width: 139.rw,
          height: 5.rh,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100.rw),
          ),
        ),
      ),
    );
  }

  /// Handle subscribe button press
  void _handleSubscribe() {
    // TODO: Implement subscription logic based on selected plan
    final planName = _selectedPlan == 0 ? 'Free Plan' : '6 Months Plan';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected $planName'),
        backgroundColor: const Color(0xFFD1FF43),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
