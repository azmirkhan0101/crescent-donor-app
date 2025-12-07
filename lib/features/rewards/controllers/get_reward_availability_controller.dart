import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class RewardAvailabilityModel {
  final bool isAvailable;
  final int remainingCount;
  final bool userCanAfford;
  final int userBalance;
  final bool hasAlreadyClaimed;

  RewardAvailabilityModel.fromJson(Map<String, dynamic> json)
    : isAvailable = json['isAvailable'],
      remainingCount = json['remainingCount'],
      userCanAfford = json['userCanAfford'],
      userBalance = json['userBalance'],
      hasAlreadyClaimed = json['hasAlreadyClaimed'];
}

class RewardAvailabilityResponse {
  final bool success;
  final String message;
  final RewardAvailabilityModel data;

  RewardAvailabilityResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'],
      message = json['message'],
      data = RewardAvailabilityModel.fromJson(json['data']);
}

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
