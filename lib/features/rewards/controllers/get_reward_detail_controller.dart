import 'package:cresent_charge_user_app/features/rewards/models/reward_details_models.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GetRewardDetailController extends GetxController {
  var rewardDetail = Rx<RewardDetailsModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var redeemptionCode = ''.obs;
  var redeemptionMethods = Rx<InStoreRedemptionMethods?>(null);
  var isFavorite = false.obs; // Track favorite state separately

  Future<bool> fetchRewardDetail(String rewardId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      ApiUrl.getRewardDetails(rewardId),
      withAuth: true,
    );

    isLoading.value = false;

    return response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        isFavorite.value = false;
        debugPrint('Error fetching reward detail: ${error.message}');
        return false;
      },
      (data) {
        // final rewardDetailResponse = RewardDetailsModel.fromJson(data['data']);
        rewardDetail.value = RewardDetailsModel.fromJson(data['data']);
        // Update favorite state from API response
        isFavorite.value = rewardDetail.value?.isAlreadySaved ?? false;

        if (rewardDetail.value?.claimDetails != null) {
          redeemptionCode.value =
              rewardDetail.value?.claimDetails?.assignedCode ?? '';
          redeemptionMethods.value =
              rewardDetail.value?.inStoreRedemptionMethods;
        } else {
          redeemptionCode.value = '';
          redeemptionMethods.value = null;
        }
        debugPrint(
          'Reward detail fetched successfully: ${rewardDetail.value?.title}',
        );
        debugPrint('isFavorite: ${isFavorite.value}');
        return true;
      },
    );
  }
}
