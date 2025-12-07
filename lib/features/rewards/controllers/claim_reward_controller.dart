import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ClaimRewardRequest {
  final String preferredCodeType;

  ClaimRewardRequest({required this.preferredCodeType});

  Map<String, dynamic> toJson() {
    return {'preferredCodeType': preferredCodeType};
  }
}

class ClaimRewardSuccessResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  ClaimRewardSuccessResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'],
      message = json['message'],
      data = json['data'];
}

class ClaimRewardController extends GetxController {
  final NetworkHelper networkHelper = Get.find<NetworkHelper>();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;
  var claimResult = Rx<Map<String, dynamic>?>(null);

  Future<bool> claimReward(String rewardId, String preferredCodeType) async {
    isLoading.value = true;
    errorMessage.value = '';
    successMessage.value = '';
    claimResult.value = null;

    final requestBody = ClaimRewardRequest(
      preferredCodeType: preferredCodeType,
    );

    final response = await networkHelper.request(
      'POST',
      ApiUrl.claimReward(rewardId),
      body: requestBody.toJson(),
      withAuth: true,
    );

    isLoading.value = false;

    return response.fold(
      (error) {
        // Handle error response - use error message directly
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error claiming reward: ${error.message}');
        return false;
      },
      (data) {
        // Handle success response
        try {
          final successResponse = ClaimRewardSuccessResponse.fromJson(data);
          successMessage.value = successResponse.message;
          claimResult.value = successResponse.data;
          debugPrint('Reward claimed successfully: ${successResponse.message}');
          return true;
        } catch (e) {
          // Fallback for unexpected success format
          successMessage.value = 'Reward claimed successfully';
          claimResult.value = data;
          debugPrint('Reward claimed successfully');
          return true;
        }
      },
    );
  }
}
