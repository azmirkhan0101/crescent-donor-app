import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogOutController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<bool> logOut(String guestId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await Get.find<NetworkHelper>()
        .request<Map<String, dynamic>>(
          'POST',
          ApiUrl.guestLogOut,
          body: {"guestId": guestId},
          withAuth: true,
          parser: (data) => data as Map<String, dynamic>,
        );
    isLoading.value = false;

    return response.fold(
      (error) {
        errorMessage.value =
            error.message ?? 'Logout failed. Please try again.';
        debugPrint('❌ Logout error: ${error.message}');
        return false;
      },
      (response) {
        // Handle success
        if (response['success'] == true) {
          debugPrint('✅ Logout successful');
          return true;
        } else {
          errorMessage.value =
              response['message'] ?? 'Logout failed. Please try again.';
          debugPrint('❌ Logout failed: ${response['message']}');
          return false;
        }
      },
    );
  }
}
