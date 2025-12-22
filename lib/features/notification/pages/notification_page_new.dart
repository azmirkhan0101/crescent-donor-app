import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/notification/controllers/get_notifications_controller.dart';
import 'package:cresent_charge_user_app/features/notification/models/notification_model.dart';
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
  final GetNotificationsController notificationController = Get.put(
    GetNotificationsController(),
  );

  final categories = [
    'All',
    'Impact',
    'Rewards',
    'Donations',
    'Campaigns',
    'System',
  ];

  final selectedCategoryIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    // Fetch notifications on page load
    notificationController.fetchNotifications(refresh: true);
  }

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
        child: Obx(
          () => Row(
            children: List.generate(categories.length, (index) {
              final isSelected = selectedCategoryIndex.value == index;
              return Padding(
                padding: EdgeInsets.only(right: 8.rw),
                child: _buildCategoryChip(
                  categories[index],
                  isSelected,
                  () => selectedCategoryIndex.value = index,
                ),
              );
            }),
          ),
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
    return Obx(() {
      if (notificationController.isLoading.value &&
          notificationController.notifications.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      final filteredNotifications = _getFilteredNotifications();
      final groups = _groupNotificationsByTime(filteredNotifications);

      if (groups.isEmpty) {
        return _buildEmptyState();
      }

      return RefreshIndicator(
        onRefresh: () => notificationController.refreshNotifications(),
        child: ListView.builder(
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
        ),
      );
    });
  }

  /// Get filtered notifications based on selected category
  List<NotificationModel> _getFilteredNotifications() {
    final selectedCategory = categories[selectedCategoryIndex.value];

    if (selectedCategory == 'All') {
      return notificationController.notifications;
    }

    // Map category names to notification types
    final typeMapping = {
      'Impact': ['donation_success', 'scheduled_donation', 'donation_failed'],
      'Rewards': ['new_reward', 'reward_claimed'],
      'Donations': ['donation_success', 'scheduled_donation'],
      'Campaigns': ['campaign', 'new_campaign'],
      'System': ['system', 'alert'],
    };

    final types = typeMapping[selectedCategory] ?? [];
    return notificationController.notifications
        .where((n) => types.contains(n.type))
        .toList();
  }

  /// Group notifications by time (Today, Yesterday, This Week, etc.)
  List<NotificationGroup> _groupNotificationsByTime(
    List<NotificationModel> notifications,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final thisWeekStart = today.subtract(Duration(days: now.weekday - 1));

    final todayNotifs = <NotificationModel>[];
    final yesterdayNotifs = <NotificationModel>[];
    final thisWeekNotifs = <NotificationModel>[];
    final olderNotifs = <NotificationModel>[];

    for (final notif in notifications) {
      final notifDate = DateTime(
        notif.createdAt.year,
        notif.createdAt.month,
        notif.createdAt.day,
      );

      if (notifDate.isAtSameMomentAs(today)) {
        todayNotifs.add(notif);
      } else if (notifDate.isAtSameMomentAs(yesterday)) {
        yesterdayNotifs.add(notif);
      } else if (notifDate.isAfter(thisWeekStart) &&
          notifDate.isBefore(yesterday)) {
        thisWeekNotifs.add(notif);
      } else {
        olderNotifs.add(notif);
      }
    }

    final groups = <NotificationGroup>[];
    if (todayNotifs.isNotEmpty) {
      groups.add(NotificationGroup(title: 'Today', notifications: todayNotifs));
    }
    if (yesterdayNotifs.isNotEmpty) {
      groups.add(
        NotificationGroup(title: 'Yesterday', notifications: yesterdayNotifs),
      );
    }
    if (thisWeekNotifs.isNotEmpty) {
      groups.add(
        NotificationGroup(title: 'This Week', notifications: thisWeekNotifs),
      );
    }
    if (olderNotifs.isNotEmpty) {
      groups.add(NotificationGroup(title: 'Older', notifications: olderNotifs));
    }

    return groups;
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

  Widget _buildNotificationCard(NotificationModel notification) {
    final notifType = _getNotificationType(notification.type);
    final isAlert =
        notification.type.contains('failed') ||
        notification.type.contains('alert');

    return Container(
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: isAlert ? const Color(0xFFFFF5F5) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEDEDED), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNotificationIcon(notifType, isAlert),
          SizedBox(width: 12.rw),
          Expanded(child: _buildNotificationContent(notification)),
        ],
      ),
    );
  }

  /// Map notification type string to enum
  NotificationType _getNotificationType(String type) {
    switch (type.toLowerCase()) {
      case 'donation_success':
      case 'scheduled_donation':
      case 'donation_failed':
        return NotificationType.donations;
      case 'new_reward':
      case 'reward_claimed':
        return NotificationType.rewards;
      case 'points_earned':
      case 'badge_earned':
        return NotificationType.impact;
      case 'campaign':
      case 'new_campaign':
        return NotificationType.campaigns;
      case 'alert':
        return NotificationType.alert;
      default:
        return NotificationType.system;
    }
  }

  Widget _buildNotificationIcon(NotificationType type, bool isAlert) {
    Color backgroundColor;
    SvgGenImage svgGenImage;
    Color iconColor = "#000C0B".hexColor;

    if (isAlert) {
      backgroundColor = const Color(0xFFF0323C);
      svgGenImage = Assets.common.alert;
      iconColor = Colors.white;
    } else {
      switch (type) {
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
        case NotificationType.system:
          backgroundColor = const Color(0xFFF0323C);
          svgGenImage = Assets.common.alert;
          iconColor = Colors.white;
          break;
      }
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
    );
  }

  Widget _buildNotificationContent(NotificationModel notification) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (!notification.isSeen) _buildRedDotIndicator(),
            if (!notification.isSeen) SizedBox(width: 8.rw),
            Expanded(
              child: Text(
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
            ),
          ],
        ),
        SizedBox(height: 4.rh),
        Text(
          notification.message,
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
          _formatTimestamp(notification.createdAt),
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

// Data Models - Kept for grouping structure
class NotificationGroup {
  final String title;
  final List<NotificationModel> notifications;

  NotificationGroup({required this.title, required this.notifications});
}

enum NotificationType { impact, rewards, donations, campaigns, system, alert }
