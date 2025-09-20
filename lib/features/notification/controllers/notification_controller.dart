import 'package:cresent_charge_user_app/features/notification/pages/notification_page.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  var selectedCategoryIndex = 0.obs;

  final List<String> categories = [
    'All',
    'Impact',
    'Rewards',
    'Donations',
    'Campaigns',
    'System',
  ];

  final List<NotificationGroup> notificationGroups = [
    NotificationGroup(
      title: 'New',
      notifications: [
        NotificationItem(
          title: 'Campaign Alert',
          description: 'Penny Appeal just launched a new Ramadan Campaign.',
          timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
          isRead: false,
          type: NotificationType.campaigns,
          hasRedDot: true,
        ),
        NotificationItem(
          title: 'Impact Update',
          description: 'Your spare change planted 2 trees 🌱.',
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isRead: false,
          type: NotificationType.impact,
          hasRedDot: true,
        ),
        NotificationItem(
          title: 'Upcoming Donation',
          description:
              'Your \$25 donation to Penny Appeal tomorrow at 10:00 AM.',
          timestamp: DateTime.now().subtract(const Duration(minutes: 16)),
          isRead: false,
          type: NotificationType.donations,
          hasRedDot: false,
          reminderDate: '17 July - 10:00 AM',
          isReminder: true,
        ),
      ],
    ),
    NotificationGroup(
      title: 'Today',
      notifications: [
        NotificationItem(
          title: 'Rewards',
          description: 'Your Free Coffee reward expires in 24 hours.',
          timestamp: DateTime.now().subtract(const Duration(hours: 4)),
          isRead: true,
          type: NotificationType.rewards,
          hasRedDot: false,
        ),
        NotificationItem(
          title: 'Impact Update',
          description: 'You just helped 3 kids get school meals 🍽️.',
          timestamp: DateTime.now().subtract(const Duration(hours: 6)),
          isRead: true,
          type: NotificationType.impact,
          hasRedDot: false,
        ),
        NotificationItem(
          title: 'Rewards',
          description: 'You\'ve unlocked Silver Tier benefits 🏆.',
          timestamp: DateTime.now().subtract(const Duration(hours: 7)),
          isRead: true,
          type: NotificationType.rewards,
          hasRedDot: false,
        ),
      ],
    ),
    NotificationGroup(
      title: 'Yesterday',
      notifications: [
        NotificationItem(
          title: 'Donation Update',
          description: 'Your \$5 donation went through successfully.',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          isRead: true,
          type: NotificationType.donations,
          hasRedDot: false,
        ),
      ],
    ),
    NotificationGroup(
      title: '16 July',
      notifications: [
        NotificationItem(
          title: 'Donation Update',
          description:
              'Recurring donation to Human Appeal failed. Please update payment.',
          timestamp: DateTime.now().subtract(const Duration(days: 5)),
          isRead: true,
          type: NotificationType.alert,
          hasRedDot: false,
          isAlert: true,
        ),
      ],
    ),
  ];

  List<NotificationGroup> get filteredNotificationGroups {
    if (selectedCategoryIndex == 0) return notificationGroups;

    final NotificationType filterType = switch (selectedCategoryIndex) {
      1 => NotificationType.impact,
      2 => NotificationType.rewards,
      3 => NotificationType.donations,
      4 => NotificationType.campaigns,
      5 => NotificationType.system,
      _ => NotificationType.campaigns,
    };

    List<NotificationGroup> filtered = [];
    for (var group in notificationGroups) {
      var filteredNotifications = group.notifications
          .where((notification) => notification.type == filterType)
          .toList();
      if (filteredNotifications.isNotEmpty) {
        filtered.add(
          NotificationGroup(
            title: group.title,
            notifications: filteredNotifications,
          ),
        );
      }
    }
    return filtered;
  }
}
