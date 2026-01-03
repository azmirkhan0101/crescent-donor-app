import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/notification_settings_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Notification Settings Page
///
/// This page allows users to manage their notification preferences including
/// push notifications, donation updates, and rewards & perks notifications.
class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  // Notification settings state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.rw),
        child: GetX<NotificationSettingsController>(
          init: Get.put(NotificationSettingsController()),
          initState: (state) {
            state.controller!.getNotificationSettings();
          },

          builder: (controller) {
            return Column(
              children: [
                SizedBox(height: 16.rh),

                // Push Notifications Setting
                _buildNotificationSetting(
                  icon: Assets
                      .common
                      .notificationBell
                      .path, // Using alert as bell icon
                  title: 'Push Notifications',
                  description:
                      'Manage what updates you want to hear about from Crescent Change.',
                  isEnabled: controller.pushNotificationsEnabled.value,
                  onToggle: (value) {
                    controller.togglePushNotifications(value);
                  },
                ),

                SizedBox(height: 16.rh),

                // Donation Updates Setting
                _buildNotificationSetting(
                  icon: Assets
                      .common
                      .donationOutlineIcon
                      .path, // Using gift as donation icon
                  title: 'Donation Updates',
                  description:
                      'Get notified when your donation is sent or when a recurring one is coming up.',
                  isEnabled:
                      controller.donationUpdateNNotificationEnabled.value,
                  onToggle: (value) {
                    controller.toggleDonationUpdateNotification(value);
                  },
                ),

                SizedBox(height: 16.rh),

                // Rewards & Perks Setting
                _buildNotificationSetting(
                  icon:
                      Assets.common.starOutline.path, // Using star for rewards
                  title: 'Rewards & Perks',
                  description:
                      'We\'ll ping you when you earn rewards, perks, or kindness streaks!',
                  isEnabled: controller.rewardsAndPerksEnabled.value,
                  onToggle: (value) {
                    controller.toggleRewardsNotification(value);
                  },
                ),

                SizedBox(height: 24.rh),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Build app bar with back button and title
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF7F7F7),
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
      title: Text(
        'Notifications',
        style: TextStyle(
          fontFamily: DonationFonts.familjenGrotesk,
          fontSize: 20.rfs,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF000C0B),
          letterSpacing: -0.2,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build individual notification setting row
  Widget _buildNotificationSetting({
    required String icon,
    required String title,
    required String description,
    required bool isEnabled,
    required Function(bool) onToggle,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.rw),
        border: Border.all(color: const Color(0xFFE4E4E4), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            margin: EdgeInsets.only(top: 2.rh),
            child: SvgPicture.asset(
              icon,
              width: 20.rw,
              height: 20.rh,
              colorFilter: const ColorFilter.mode(
                Color(0xFF000C0B),
                BlendMode.srcIn,
              ),
            ),
          ),

          SizedBox(width: 8.rw),

          // Title and Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: 14.rfs,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF000C0B),
                    height: 1.43,
                  ),
                ),

                SizedBox(height: 4.rh),

                Text(
                  description,
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: 14.rfs,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    height: 1.43,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.rw),

          // Toggle Switch
          _buildCustomToggle(isEnabled: isEnabled, onToggle: onToggle),
        ],
      ),
    );
  }

  /// Build custom toggle switch matching Figma design
  Widget _buildCustomToggle({
    required bool isEnabled,
    required Function(bool) onToggle,
  }) {
    return GestureDetector(
      onTap: () => onToggle(!isEnabled),
      child: Container(
        width: 36,
        height: 18,
        decoration: BoxDecoration(
          color: isEnabled ? const Color(0xFF1AC461) : const Color(0xFF000C0B),
          borderRadius: BorderRadius.circular(100),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: isEnabled ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: isEnabled ? 2 : 2,
              vertical: 2,
            ),
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

/// Notification setting item data model
class NotificationSettingItem {
  final String icon;
  final String title;
  final String description;
  final bool isEnabled;

  NotificationSettingItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.isEnabled,
  });
}
