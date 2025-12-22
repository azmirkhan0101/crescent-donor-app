import 'package:cresent_charge_user_app/features/rewards/models/reward_details_models.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GetRewardDetailController extends GetxController {
  var rewardDetail = Rx<RewardDetailsModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchRewardDetail(String rewardId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      ApiUrl.getRewardDetails(rewardId),
      withAuth: true,
    );

    isLoading.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error fetching reward detail: ${error.message}');
      },
      (data) {
        final rewardDetailResponse = RewardDetailsModel.fromJson(data['data']);
        rewardDetail.value = rewardDetailResponse;
        debugPrint(
          'Reward detail fetched successfully: ${rewardDetail.value?.title}',
        );
      },
    );
  }
}
