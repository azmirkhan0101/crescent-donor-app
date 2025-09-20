import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/notification/controllers/notification_controller.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationController notificationController = Get.put(
    NotificationController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: CustomAppBar(
        title: "Notifications",
        backgroundColor: const Color(0xFFF7F7F7),
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(child: _buildNotificationList()),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.rh),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.rw),
        child: Row(
          children: List.generate(notificationController.categories.length, (
            index,
          ) {
            final isSelected =
                notificationController.selectedCategoryIndex.value == index;
            return Padding(
              padding: EdgeInsets.only(right: 8.rw),
              child: _buildCategoryChip(
                notificationController.categories[index],
                isSelected,
                () => setState(
                  () => notificationController.selectedCategoryIndex.value =
                      index,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 8.rh),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF000C0B) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: isSelected
              ? null
              : Border.all(color: const Color(0xFFEDEDED), width: 1),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF000C0B),
            fontSize: 14.rfs,
            fontFamily: 'Inter Display',
            fontWeight: FontWeight.w400,
            height: 1.29,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    final groups = notificationController.filteredNotificationGroups;

    if (groups.isEmpty || groups.every((g) => g.notifications.isEmpty)) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.rw),
      itemCount: groups.length,
      itemBuilder: (context, groupIndex) {
        final group = groups[groupIndex];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (groupIndex > 0) SizedBox(height: 24.rh),
            _buildGroupHeader(group.title),
            SizedBox(height: 16.rh),
            ...group.notifications.map(
              (notification) => Padding(
                padding: EdgeInsets.only(bottom: 12.rh),
                child: _buildNotificationCard(notification),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGroupHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: const Color(0xFF000C0B),
        fontSize: 16.rfs,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/common/alert.svg',
            width: 64.rw,
            height: 64.rh,
            colorFilter: const ColorFilter.mode(
              Color(0xFF808080),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: 16.rh),
          Text(
            'No notifications yet',
            style: AppTextStyles.f16W500().copyWith(
              color: const Color(0xFF808080),
            ),
          ),
          SizedBox(height: 8.rh),
          Text(
            'We\'ll notify you when something happens',
            style: AppTextStyles.f14W400().copyWith(
              color: const Color(0xFF808080),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Container(
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: notification.isAlert
            ? const Color(0xFFFFF5F5) // Light red background for alerts
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: notification.isReminder
            ? Border.all(color: const Color(0xFFE5F7E5), width: 1)
            : Border.all(color: const Color(0xFFEDEDED), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNotificationIcon(notification),
              SizedBox(width: 12.rw),
              Expanded(child: _buildNotificationContent(notification)),
            ],
          ),
          if (notification.isReminder && notification.reminderDate != null)
            _buildReminderSection(notification.reminderDate!),
        ],
      ),
    );
  }

  Widget _buildNotificationIcon(NotificationItem notification) {
    Color backgroundColor;
    SvgGenImage svgGenImage;
    Color iconColor = "#000C0B".hexColor;

    switch (notification.type) {
      case NotificationType.campaigns:
        backgroundColor = const Color(0xFFADDFFF);
        svgGenImage = Assets.common.campaignLoveBox;
        break;
      case NotificationType.impact:
        backgroundColor = const Color(0xFFFFEE99);
        svgGenImage = Assets.common.heartCircle;
        break;
      case NotificationType.donations:
        backgroundColor = const Color(0xFFA6F6E6);
        svgGenImage = Assets.common.heartOnHand;
        break;
      case NotificationType.rewards:
        backgroundColor = const Color(0xFFFFBFDF);
        svgGenImage = Assets.common.starFilled;
        break;
      case NotificationType.alert:
        backgroundColor = const Color(0xFFF0323C);
        svgGenImage = Assets.common.alert;
        iconColor = Colors.white;
        break;
      case NotificationType.system:
        backgroundColor = const Color(0xFFF0323C);
        svgGenImage = Assets.common.alert;
        iconColor = Colors.white;
        break;
    }

    return Container(
      width: 40.rw,
      height: 40.rh,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: svgGenImage
          .svg(
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            fit: BoxFit.cover,
          )
          .paddingAll(10.rw),
      // child: Icon(iconPath, color: iconColor, size: 20.rw),
    );
  }

  Widget _buildNotificationContent(NotificationItem notification) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (notification.hasRedDot) _buildRedDotIndicator(),
            SizedBox(width: 8.rw),
            Text(
              notification.title,
              style: TextStyle(
                color: const Color(0xFF000C0B),
                fontSize: 16.rfs,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        SizedBox(height: 4.rh),
        Text(
          notification.description,
          style: TextStyle(
            color: const Color(0xFF6B7280),
            fontSize: 14.rfs,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter',
            height: 1.4,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8.rh),
        Text(
          _formatTimestamp(notification.timestamp),
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 12.rfs,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildRedDotIndicator() {
    return Container(
      width: 8.rw,
      height: 8.rh,
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildReminderSection(String reminderDate) {
    return Container(
      margin: EdgeInsets.only(top: 12.rh, left: 52.rw),
      padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 8.rh),
      decoration: BoxDecoration(
        color: const Color(0xFFE5F7E5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule, color: const Color(0xFF059669), size: 16.rw),
          SizedBox(width: 6.rw),
          Text(
            reminderDate,
            style: TextStyle(
              color: const Color(0xFF059669),
              fontSize: 12.rfs,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday • ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')} PM';
    } else {
      return '${timestamp.day} ${_getMonthName(timestamp.month)} ${timestamp.year} • ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')} PM';
    }
  }

  String _getMonthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month];
  }
}

// Data Models
class NotificationGroup {
  final String title;
  final List<NotificationItem> notifications;

  NotificationGroup({required this.title, required this.notifications});
}

class NotificationItem {
  final String title;
  final String description;
  final DateTime timestamp;
  final bool isRead;
  final NotificationType type;
  final bool hasRedDot;
  final String? reminderDate;
  final bool isReminder;
  final bool isAlert;

  NotificationItem({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.isRead,
    required this.type,
    this.hasRedDot = false,
    this.reminderDate,
    this.isReminder = false,
    this.isAlert = false,
  });
}

enum NotificationType { impact, rewards, donations, campaigns, system, alert }
