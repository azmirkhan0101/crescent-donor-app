import 'package:cresent_charge_user_app/features/rewards/models/reward_availability_models.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GetRewardAvailabilityController extends GetxController {
  final NetworkHelper networkHelper = Get.find<NetworkHelper>();

  var rewardAvailability = Rx<RewardAvailabilityModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> checkRewardAvailability(String rewardId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await networkHelper.request(
      'GET',
      ApiUrl.getRewardAvailability(rewardId),
      withAuth: true,
    );

    isLoading.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error checking reward availability: ${error.message}');
      },
      (data) {
        final availabilityResponse = RewardAvailabilityResponse.fromJson(data);
        rewardAvailability.value = availabilityResponse.data;
        debugPrint('Reward availability checked successfully');
      },
    );
  }
}
