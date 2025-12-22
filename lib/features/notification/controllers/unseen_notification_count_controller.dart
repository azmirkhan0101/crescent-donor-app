import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Unseen Notification Count Controller
///
/// Handles fetching and managing the count of unseen notifications.
/// Used to display notification badge on home page.
class UnseenNotificationCountController extends GetxController {
  var unseenCount = 0.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUnseenCount();
  }

  /// Fetch unseen notification count from API
  Future<void> fetchUnseenCount() async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      ApiUrl.unseenNotificationCount,
      withAuth: true,
    );

    isLoading.value = false;

    response.fold(
      (error) {
        errorMessage.value =
            error.message ?? 'Failed to fetch unseen notification count';
        debugPrint(
          'Error fetching unseen notification count: ${error.message}',
        );
      },
      (data) {
        unseenCount.value = data['data'] as int;
        debugPrint('Unseen notification count: ${unseenCount.value}');
      },
    );
  }

  /// Check if there are unseen notifications
  bool get hasUnseenNotifications => unseenCount.value > 0;

  /// Refresh unseen count
  Future<void> refresh() async {
    await fetchUnseenCount();
  }

  /// Reset unseen count to 0 (call after viewing notifications)
  void resetCount() {
    unseenCount.value = 0;
  }
}
