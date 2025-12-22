import 'package:cresent_charge_user_app/features/notification/models/notification_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Get Notifications Controller
///
/// Handles fetching and managing user notifications with pagination support.
///
/// Features:
/// - Fetch notifications with pagination
/// - Load more notifications
/// - Refresh notifications
/// - Track unread count
/// - Filter by notification type
class GetNotificationsController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var errorMessage = ''.obs;
  var meta = Rx<NotificationMeta?>(null);

  // Pagination
  var currentPage = 1.obs;
  var pageLimit = 10;

  /// Fetch notifications from API
  ///
  /// [page] - Page number to fetch (default: 1)
  /// [limit] - Number of items per page (default: 10)
  /// [refresh] - If true, clears existing notifications before fetching
  Future<void> fetchNotifications({
    int page = 1,
    int? limit,
    bool refresh = false,
  }) async {
    if (refresh) {
      isLoading.value = true;
      notifications.clear();
      currentPage.value = 1;
    } else if (page > 1) {
      isLoadingMore.value = true;
    } else {
      isLoading.value = true;
    }

    errorMessage.value = '';

    final queryParams = {
      'page': page.toString(),
      'limit': (limit ?? pageLimit).toString(),
    };

    final url = Uri.parse(
      ApiUrl.getNotifications,
    ).replace(queryParameters: queryParams).toString();

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      url,
      withAuth: true,
    );

    isLoading.value = false;
    isLoadingMore.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'Failed to fetch notifications';
        debugPrint('❌ Error fetching notifications: ${error.message}');
      },
      (data) {
        debugPrint('✅ Notifications API Response: $data');
        final notificationsResponse = NotificationsResponse.fromJson(data);
        debugPrint(
          '📋 Fetched ${notificationsResponse.data.length} notifications',
        );

        if (refresh || page == 1) {
          notifications.value = notificationsResponse.data;
        } else {
          notifications.addAll(notificationsResponse.data);
        }

        meta.value = notificationsResponse.meta;
        currentPage.value = page;

        debugPrint(
          'Notifications fetched: ${notificationsResponse.data.length} items, '
          'Page: $page/${notificationsResponse.meta.totalPages}',
        );
      },
    );
  }

  /// Load more notifications (next page)
  Future<void> loadMore() async {
    if (meta.value == null || !meta.value!.hasNextPage || isLoadingMore.value) {
      return;
    }

    final nextPage = currentPage.value + 1;
    await fetchNotifications(page: nextPage);
  }

  /// Refresh notifications (pull to refresh)
  Future<void> refreshNotifications() async {
    await fetchNotifications(refresh: true);
  }

  /// Get unread notifications count
  int get unreadCount =>
      notifications.where((notification) => notification.isUnread).length;

  /// Get unread notifications
  List<NotificationModel> get unreadNotifications =>
      notifications.where((notification) => notification.isUnread).toList();

  /// Get read notifications
  List<NotificationModel> get readNotifications =>
      notifications.where((notification) => notification.isSeen).toList();

  /// Filter notifications by type
  List<NotificationModel> filterByType(NotificationType type) {
    return notifications
        .where((notification) => notification.notificationType == type)
        .toList();
  }

  /// Get notifications by types
  List<NotificationModel> getNotificationsByTypes(List<String> types) {
    return notifications
        .where((notification) => types.contains(notification.type))
        .toList();
  }

  /// Mark notification as read (local only - you may need to call API)
  void markAsRead(String notificationId) {
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      // Note: You may need to call an API endpoint to mark as read on backend
      debugPrint('Mark notification as read: $notificationId');
      // TODO: Call backend API to mark as read
    }
  }

  /// Check if has more notifications to load
  bool get hasMore => meta.value?.hasNextPage ?? false;

  /// Get total notifications count
  int get totalCount => meta.value?.total ?? 0;
}
