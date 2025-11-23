import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/network_image/network_image.dart';
import 'package:cresent_charge_user_app/core/helper/url_parser/image_url_parser.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/get_profile_controller.dart';
import 'package:cresent_charge_user_app/features/profile/models/profile_model.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Menu item data model
class MenuItemData {
  final String icon;
  final String title;
  final VoidCallback onTap;

  MenuItemData({required this.icon, required this.title, required this.onTap});
}

/// Profile Page
///
/// This page displays user profile information, settings, and account management.
/// Users can update their personal details and app preferences.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Get.find<GetProfileController>().profile;
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.rw),
                child: Column(
                  children: [
                    SizedBox(height: 16.rh),

                    // Profile Header Section
                    _buildProfileHeader(context, profile.value),

                    SizedBox(height: 16.rh),

                    // Menu Items Section
                    _buildMenuItems(context),
                  ],
                ),
              ),
            ),

            // Logout Button
            _buildLogoutButton(context),

            SizedBox(height: 80.rh),
          ],
        ),
      ),
    );
  }

  /// Build profile header with avatar and user info
  Widget _buildProfileHeader(BuildContext context, ProfileModel? profile) {
    return Column(
      children: [
        // Profile Avatar
        Center(
          child: CustomNetworkImage(
            imageUrl: parseImageUrl(profile?.image ?? ''),
            height: 120.rh,
            width: 120.rw,
            borderRadius: BorderRadius.circular(60.rw),
          ),
        ),

        SizedBox(height: 15.rh),

        // User Info Section
        SizedBox(
          width: 327.rw,
          child: Column(
            children: [
              // Name and Edit Profile Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile?.name ?? 'N/A',
                        style: TextStyle(
                          fontFamily: DonationFonts.interDisplay,
                          fontSize: 24.rfs,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000C0B),
                        ),
                      ),
                      SizedBox(height: 4.rh),
                      Text(
                        profile?.auth.email ?? 'N/A',
                        style: TextStyle(
                          fontFamily: DonationFonts.interDisplay,
                          fontSize: 12.rfs,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => context.pushNamed(RoutePath.editProfile),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.rw,
                        vertical: 8.rh,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBE9EC),
                        borderRadius: BorderRadius.circular(32.rw),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontFamily: DonationFonts.interDisplay,
                          fontSize: 12.rfs,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF000C0B),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.rh),

              // Bio Text
              SizedBox(
                width: double.infinity,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: DonationFonts.interDisplay,
                      fontSize: 12.rfs,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF000C0B),
                      height: 1.33,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Turning spare change into big change since ',
                      ),
                      TextSpan(
                        text: '2021',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontFamily: DonationFonts.interDisplay,
                        ),
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build menu items section
  Widget _buildMenuItems(BuildContext context) {
    final menuItems = [
      MenuItemData(
        icon: Assets.common.alert.path, // Using alert for notifications
        title: 'Notifications',
        onTap: () {
          context.pushNamed(RoutePath.notificationSettings);
        },
      ),
      MenuItemData(
        icon: Assets.common.timer.path, // Using timer for transaction history
        title: 'Transaction History',
        onTap: () {
          context.pushNamed(RoutePath.transactionHistory);
        },
      ),
      MenuItemData(
        icon: Assets.common.gift.path, // Using gift for change password
        title: 'Change Password',
        onTap: () {
          context.pushNamed(RoutePath.changePassword);
        },
      ),
      // MenuItemData(
      //   icon: Assets.common.calendar.path,
      //   title: 'Subscriptions',
      //   onTap: () {
      //     context.pushNamed(RoutePath.subscription);
      //   },
      // ),
      MenuItemData(
        icon: Assets.common.globe.path, // Using globe for terms & conditions
        title: 'Terms & Conditions',
        onTap: () {},
      ),
    ];

    return Column(
      children: menuItems.map((item) => _buildMenuItem(item)).toList(),
    );
  }

  /// Build individual menu item
  Widget _buildMenuItem(MenuItemData item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 8.rh),
        padding: EdgeInsets.all(16.rw),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.rw),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            SvgPicture.asset(
              item.icon,
              width: 20.rw,
              height: 20.rh,
              colorFilter: const ColorFilter.mode(
                Color(0xFF000C0B),
                BlendMode.srcIn,
              ),
            ),

            SizedBox(width: 8.rw),

            // Title
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontFamily: DonationFonts.interDisplay,
                  fontSize: 14.rfs,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF000C0B),
                ),
              ),
            ),

            // Chevron
            Transform.rotate(
              angle: 3.14159, // 180 degrees to flip arrow-left to arrow-right
              child: SvgPicture.asset(
                Assets.common.arrowLeft.path,
                width: 20.rw,
                height: 20.rh,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF000C0B),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build logout button
  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 56.rw),
      padding: EdgeInsets.symmetric(horizontal: 24.rw, vertical: 16.rh),
      decoration: BoxDecoration(
        color: const Color(0xFFF0323C).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.rw),
        border: Border.all(color: const Color(0xFFF0323C), width: 1),
      ),
      child: Center(
        child: Text(
          'Logout',
          style: TextStyle(
            fontFamily: DonationFonts.familjenGrotesk,
            fontSize: 18.rfs,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF0323C),
            letterSpacing: -0.36,
          ),
        ),
      ),
    ).onTap(() {
      AppStorageService.clearAll();
      context.goNamed(RoutePath.login);
    });
  }
}
