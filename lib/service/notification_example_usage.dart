import 'package:cresent_charge_user_app/service/firebase_notification_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Example Controller showing Firebase Notification Service usage
///
/// This demonstrates common notification scenarios:
/// - Getting FCM token on login
/// - Sending token to backend
/// - Listening to token refresh
/// - Subscribing to topics
/// - Deleting token on logout
///
/// IMPLEMENTATION NOTE:
/// The FcmTokenController is already integrated in HomePage.
/// It automatically sends the FCM token to backend when the home page loads.
/// See: lib/features/notification/controllers/fcm_token_controller.dart
/// See: lib/features/home/pages/home_page.dart
class NotificationExampleController extends GetxController {
  final _notificationService = FirebaseNotificationService.instance;

  @override
  void onInit() {
    super.onInit();
    _setupTokenRefreshListener();
  }

  /// Example 1: Get FCM token after login
  Future<void> onUserLogin() async {
    try {
      final fcmToken = await _notificationService.getToken();

      if (fcmToken != null) {
        debugPrint('FCM Token: $fcmToken');

        // Send token to your backend
        // await apiService.updateUserFcmToken(fcmToken);

        // Subscribe to general notifications
        await _notificationService.subscribeToTopic('all_users');

        debugPrint('User subscribed to notifications');
      }
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
    }
  }

  /// Example 2: Listen to token refresh
  void _setupTokenRefreshListener() {
    _notificationService.onTokenRefresh((newToken) {
      debugPrint('FCM Token refreshed: $newToken');
      // TODO: Send updated token to backend
      // apiService.updateUserFcmToken(newToken);
    });
  }

  /// Example 3: Subscribe to specific topics based on user preferences
  Future<void> subscribeToNotificationTopics({
    required bool donationUpdates,
    required bool rewardUpdates,
  }) async {
    try {
      if (donationUpdates) {
        await _notificationService.subscribeToTopic('donations');
      } else {
        await _notificationService.unsubscribeFromTopic('donations');
      }

      if (rewardUpdates) {
        await _notificationService.subscribeToTopic('rewards');
      } else {
        await _notificationService.unsubscribeFromTopic('rewards');
      }

      debugPrint('Notification preferences updated');
    } catch (e) {
      debugPrint('Error updating notification topics: $e');
    }
  }

  /// Example 4: Delete token on logout
  Future<void> onUserLogout() async {
    try {
      // Unsubscribe from all topics
      await _notificationService.unsubscribeFromTopic('all_users');
      await _notificationService.unsubscribeFromTopic('donations');
      await _notificationService.unsubscribeFromTopic('rewards');

      // Delete FCM token
      await _notificationService.deleteToken();

      debugPrint('FCM token deleted, user logged out');
    } catch (e) {
      debugPrint('Error during logout: $e');
    }
  }
}

/// Backend API Integration Example
///
/// Add this method to your API service to send FCM token to backend
class NotificationApiExample {
  /// Send FCM token to backend
  ///
  /// Example endpoint: POST /api/users/fcm-token
  /// Body: { "fcm_token": "user_device_token" }
  Future<void> updateUserFcmToken(String fcmToken) async {
    try {
      // Example using your NetworkHelper
      // final response = await Get.find<NetworkHelper>().request(
      //   'POST',
      //   '/api/users/fcm-token',
      //   data: {'fcm_token': fcmToken},
      //   withAuth: true,
      // );
      //
      // response.fold(
      //   (error) => debugPrint('Error updating FCM token: ${error.message}'),
      //   (data) => debugPrint('FCM token updated successfully'),
      // );

      debugPrint('TODO: Implement FCM token update API call');
    } catch (e) {
      debugPrint('Error updating FCM token: $e');
    }
  }
}

/// Notification Payload Examples
///
/// These are examples of what your backend should send

// Example 1: Simple notification
const simpleNotification = '''
{
  "notification": {
    "title": "Welcome to Crescent Charge!",
    "body": "Start making a difference today"
  }
}
''';

// Example 2: Notification with custom navigation
const navigationNotification = '''
{
  "notification": {
    "title": "New Reward Available!",
    "body": "You've earned 100 points from your donation"
  },
  "data": {
    "type": "reward",
    "route": "/rewards",
    "id": "reward_123"
  }
}
''';

// Example 3: Donation notification
const donationNotification = '''
{
  "notification": {
    "title": "Donation Successful",
    "body": "Your donation has been processed"
  },
  "data": {
    "type": "donation",
    "route": "/donations/history",
    "donationId": "don_456"
  }
}
''';

// Example 4: Topic-based notification (sent to all subscribers)
const topicNotification = '''
{
  "topic": "all_users",
  "notification": {
    "title": "App Update Available",
    "body": "Update now to get the latest features"
  },
  "data": {
    "type": "app_update",
    "route": "/settings"
  }
}
''';
