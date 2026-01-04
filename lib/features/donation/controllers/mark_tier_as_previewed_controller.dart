import 'package:cresent_charge_user_app/features/donation/controllers/get_badges_progress_controller.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Make tier as previewed controller
///
/// Handles making tier as previewed
///
/// Features:
/// - Make tier as previewed
/// - Track loading and error states
/// - Auto-refresh tier after making it as previewed
class MarkTierAsPreviewedController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;

  /// Make tier as previewed
  ///
  /// [badgeId] - ID of the badge to make tier as previewed
  /// [tier] - Tier to make as previewed
  ///
  /// Returns true if successful, false otherwise
  Future<bool> makeTierAsPreviewed({
    required String tier,
    required String badgeId,
  }) async {
    if (badgeId.trim().isEmpty) {
      errorMessage.value = 'Badge ID is required';
      debugPrint('❌ Making tier as previewed failed: No badge ID provided');
      return false;
    }

    if (tier.trim().isEmpty) {
      errorMessage.value = 'Tier is required';
      debugPrint('❌ Making tier as previewed failed: No tier provided');
      return false;
    }

    isLoading.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    final body = {"tier": tier, "badgeId": badgeId};

    debugPrint('📤 Making tier as previewed: $body');

    final response = await Get.find<NetworkHelper>().request(
      'PATCH',
      ApiUrl.url('badges/mark-as-previewed'),
      body: body,
      withAuth: true,
    );

    isLoading.value = false;

    return response.fold(
      (error) {
        errorMessage.value =
            error.message ?? 'Failed to make tier as previewed';
        debugPrint('❌ Error making tier as previewed: ${error.message}');
        return false;
      },
      (data) {
        debugPrint('✅ Tier made as previewed successfully: $data');
        successMessage.value =
            data['message'] as String? ?? 'Tier made as previewed successfully';

        // Optionally refresh the GetRoundupController if it exists
        if (Get.isRegistered<GetBadgesProgressController>()) {
          Get.find<GetBadgesProgressController>().fetchBadgesProgress();
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
