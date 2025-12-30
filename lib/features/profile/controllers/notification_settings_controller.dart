import 'package:get/get.dart';

class NotificationSettingsController extends GetxController {
  var pushNotificationsEnabled = true.obs;
  var donationUpdateNNotificationEnabled = true.obs;
  var newsletterSubscriptionEnabled = false.obs;

  void toggleEmailNotifications(bool value) {
    donationUpdateNNotificationEnabled.value = value;
  }

  void togglePushNotifications(bool value) {
    pushNotificationsEnabled.value = value;
  }

  void toggleNewsletterSubscription(bool value) {
    newsletterSubscriptionEnabled.value = value;
  }
}
