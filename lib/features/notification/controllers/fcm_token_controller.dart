import 'dart:io';

import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/firebase_notification_service.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// FCM Token Controller
///
/// Handles FCM token management and backend synchronization.
/// Updates the backend whenever the FCM token is generated or refreshed.
class FcmTokenController extends GetxController {
  var isTokenSent = false.obs;
  var errorMessage = ''.obs;

  final _notificationService = FirebaseNotificationService.instance;

  @override
  void onInit() {
    super.onInit();
    _setupTokenRefreshListener();
  }

  /// Send FCM token to backend
  Future<void> sendFcmTokenToBackend() async {
    try {
      final fcmToken = await _notificationService.getToken();

      if (fcmToken == null || fcmToken.isEmpty) {
        debugPrint('FCM token is null or empty, cannot send to backend');
        return;
      }

      final deviceType = _getDeviceType();

      debugPrint('Sending FCM token to backend: $fcmToken');
      debugPrint('Device type: $deviceType');

      final response = await Get.find<NetworkHelper>().request(
        'PATCH',
        ApiUrl.updateFcmToken,
        body: {'fcmToken': fcmToken, 'deviceType': deviceType},
        withAuth: true,
      );

      response.fold(
        (error) {
          errorMessage.value = error.message ?? 'Failed to update FCM token';
          isTokenSent.value = false;
          debugPrint('Error sending FCM token: ${error.message}');
          debugPrint('Error details: ${error.toString()}');
        },
        (data) {
          isTokenSent.value = true;
          errorMessage.value = '';
          debugPrint('FCM token sent successfully to backend');
          debugPrint('Response: $data');
        },
      );
    } catch (e, stackTrace) {
      debugPrint('Error in sendFcmTokenToBackend: $e');
      debugPrint('Stack trace: $stackTrace');
      errorMessage.value = 'Error sending FCM token: $e';
      isTokenSent.value = false;
    }
  }

  /// Setup listener for token refresh
  void _setupTokenRefreshListener() {
    _notificationService.onTokenRefresh((newToken) {
      debugPrint('FCM Token refreshed, sending to backend: $newToken');
      sendFcmTokenToBackend();
    });
  }

  /// Get device type based on platform
  String _getDeviceType() {
    if (kIsWeb) {
      return 'web';
    } else if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    }
    return 'unknown';
  }

  /// Delete FCM token from backend (call on logout)
  Future<void> deleteFcmToken() async {
    try {
      await _notificationService.deleteToken();
      isTokenSent.value = false;
      debugPrint('FCM token deleted');
    } catch (e) {
      debugPrint('Error deleting FCM token: $e');
    }
  }
}
