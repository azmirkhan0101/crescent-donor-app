import 'package:cresent_charge_user_app/features/donation/controllers/get_roundup_controller.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Update Round-Up Controller
///
/// Handles updating round-up configuration settings
///
/// Features:
/// - Update monthly threshold
/// - Update special message
/// - Track loading and error states
class UpdateRoundupController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;

  /// Update round-up configuration
  ///
  /// [roundupId] - ID of the round-up configuration to update
  /// [monthlyThreshold] - New monthly threshold amount (optional)
  /// [specialMessage] - New special message (optional)
  ///
  /// Returns true if successful, false otherwise
  Future<bool> updateRoundupConfig({
    required String roundupId,
    double? monthlyThreshold,
    String? specialMessage,
  }) async {
    if (monthlyThreshold == null && specialMessage == null) {
      errorMessage.value = 'At least one field must be provided to update';
      debugPrint('❌ Update failed: No fields provided');
      return false;
    }

    isLoading.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    final body = <String, dynamic>{};
    if (monthlyThreshold != null) {
      body['monthlyThreshold'] = monthlyThreshold;
    }
    if (specialMessage != null) {
      body['specialMessage'] = specialMessage;
    }

    debugPrint('📤 Updating round-up config: $body');

    final response = await Get.find<NetworkHelper>().request(
      'PATCH',
      ApiUrl.updateRoundupConfig(roundupId),
      body: body,
      withAuth: true,
    );

    isLoading.value = false;

    return response.fold(
      (error) {
        errorMessage.value =
            error.message ?? 'Failed to update round-up config';
        debugPrint('❌ Error updating round-up config: ${error.message}');
        return false;
      },
      (data) {
        debugPrint('✅ Round-up config updated successfully: $data');
        successMessage.value =
            data['message'] as String? ?? 'Round-up updated successfully';

        // Optionally refresh the GetRoundupController if it exists
        if (Get.isRegistered<GetRoundupController>()) {
          Get.find<GetRoundupController>().fetchRoundupConfig();
        }

        return true;
      },
    );
  }

  /// Clear error and success messages
  void clearMessages() {
    errorMessage.value = '';
    successMessage.value = '';
  }
}
