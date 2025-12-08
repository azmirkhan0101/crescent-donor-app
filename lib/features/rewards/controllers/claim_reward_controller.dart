import 'package:cresent_charge_user_app/features/rewards/models/claim_reward_models.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ClaimRewardController extends GetxController {
  final NetworkHelper networkHelper = Get.find<NetworkHelper>();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;
  var claimResult = Rx<ClaimRewardData?>(null);

  Future<bool> claimReward(String rewardId, String preferredCodeType) async {
    isLoading.value = true;
    errorMessage.value = '';
    successMessage.value = '';
    claimResult.value = null;

    final requestBody = {'preferredCodeType': preferredCodeType};

    final response = await networkHelper.request(
      'POST',
      ApiUrl.claimReward(rewardId),
      body: requestBody,
      withAuth: true,
    );

    isLoading.value = false;

    return response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error claiming reward: ${error.message}');
        return false;
      },
      (data) {
        try {
          final claimResponse = ClaimRewardResponse.fromJson(data);
          successMessage.value = claimResponse.message;
          claimResult.value = claimResponse.data;
          debugPrint('Reward claimed successfully: ${claimResponse.message}');
          return true;
        } catch (e) {
          successMessage.value = 'Reward claimed successfully';
          debugPrint('Reward claimed successfully');
          return true;
        }
      },
    );
  }
}
