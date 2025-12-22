import 'package:cresent_charge_user_app/features/donation/controllers/get_roundup_controller.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Cancel Round-Up Controller
///
/// Handles cancelling round-up configuration
///
/// Features:
/// - Cancel round-up with reason
/// - Track loading and error states
/// - Auto-refresh config after cancellation
class CancelRoundupController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;

  /// Cancel round-up configuration
  ///
  /// [roundupId] - ID of the round-up configuration to cancel
  /// [reason] - Reason for cancellation
  ///
  /// Returns true if successful, false otherwise
  Future<bool> cancelRoundupConfig({
    required String roundupId,
    required String reason,
  }) async {
    if (reason.trim().isEmpty) {
      errorMessage.value = 'Cancellation reason is required';
      debugPrint('❌ Cancel failed: No reason provided');
      return false;
    }

    isLoading.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    final body = {'reason': reason};

    debugPrint('📤 Cancelling round-up config: $body');

    final response = await Get.find<NetworkHelper>().request(
      'POST',
      ApiUrl.cancelRoundupConfig(roundupId),
      body: body,
      withAuth: true,
    );

    isLoading.value = false;

    return response.fold(
      (error) {
        errorMessage.value = error.message ?? 'Failed to cancel round-up';
        debugPrint('❌ Error cancelling round-up: ${error.message}');
        return false;
      },
      (data) {
        debugPrint('✅ Round-up cancelled successfully: $data');
        successMessage.value =
            data['message'] as String? ?? 'Round-up cancelled successfully';

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
