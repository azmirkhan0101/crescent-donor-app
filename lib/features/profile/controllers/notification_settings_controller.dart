import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/profile/models/notification_settings_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationSettingsController extends GetxController {
  var pushNotificationsEnabled = true.obs;
  var donationUpdateNNotificationEnabled = true.obs;
  var rewardsAndPerksEnabled = true.obs;

  void togglePushNotifications(bool value) async {
    pushNotificationsEnabled.value = value;
    if (value == false) {
      donationUpdateNNotificationEnabled.value = false;
      rewardsAndPerksEnabled.value = false;
    }

    await Duration(milliseconds: 100).delay();

    await updateNotificationSettings();
  }

  void toggleDonationUpdateNotification(bool value) async {
    donationUpdateNNotificationEnabled.value = value;
    if (value == true) {
      pushNotificationsEnabled.value = true;
    }

    await Duration(milliseconds: 100).delay();

    await updateNotificationSettings();
  }

  void toggleRewardsNotification(bool value) async {
    rewardsAndPerksEnabled.value = value;
    if (value == true) {
      pushNotificationsEnabled.value = true;
    }

    await Duration(milliseconds: 100).delay();

    await updateNotificationSettings();
  }

  /// get notification settings
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var notificationSettingsData = NotificationSettingsModel().obs;

  Future<bool> getNotificationSettings() async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      "GET",
      ApiUrl.notificationSettings,
      withAuth: true,
    );
    isLoading.value = false;

    return response.fold(
      (l) {
        errorMessage.value = l.message ?? 'Notification settings fetch failed';

        debugPrint('Error fetching notification settings: ${l.message}');
        ToastMsg.error(errorMessage.value);
        return false;
      },
      (r) {
        final notificationSettings = NotificationSettingsModel.fromJson(
          r['data'],
        );
        notificationSettingsData.value = notificationSettings;
        pushNotificationsEnabled.value =
            notificationSettings.pushNotifications ?? false;
        donationUpdateNNotificationEnabled.value =
            notificationSettings.donations ?? false;
        rewardsAndPerksEnabled.value =
            notificationSettings.rewardsAndPerks ?? false;
        return true;
      },
    );
  }

  /// Update notification settings
  var isUpdating = false.obs;
  var updateErrorMessage = ''.obs;

  Future<bool> updateNotificationSettings() async {
    isUpdating.value = true;
    updateErrorMessage.value = '';

    Map<String, bool> requestBody = {
      "pushNotifications": pushNotificationsEnabled.value,
      "donations": donationUpdateNNotificationEnabled.value,
      "rewardsAndPerks": rewardsAndPerksEnabled.value,
    };

    final response = await Get.find<NetworkHelper>().request(
      "PATCH",
      ApiUrl.notificationSettings,
      body: requestBody,
    );
    isUpdating.value = false;

    return response.fold(
      (l) {
        updateErrorMessage.value =
            l.message ?? 'Notification settings update failed';
        debugPrint('Error updating notification settings: ${l.message}');
        ToastMsg.error(updateErrorMessage.value);
        return false;
      },
      (r) {
        final notificationSettings = NotificationSettingsModel.fromJson(
          r['data'],
        );
        pushNotificationsEnabled.value =
            notificationSettings.pushNotifications ?? false;
        donationUpdateNNotificationEnabled.value =
            notificationSettings.donations ?? false;
        rewardsAndPerksEnabled.value =
            notificationSettings.rewardsAndPerks ?? false;
        return true;
      },
    );
  }
}
