import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_reward_detail_controller.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteFavoriteRewardController extends GetxController {
  final _getRewardDetailController = Get.find<GetRewardDetailController>();
  final _isDeleting = false.obs;
  final _errorMessage = ''.obs;

  RxBool get isDeleting => _isDeleting;
  RxString get errorMessage => _errorMessage;

  Future<bool> deleteFavoriteReward(String rewardId) async {
    _isDeleting.value = true;
    _errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      "DELETE",
      ApiUrl.url('favorite/remove/$rewardId'),
      body: {"reward": rewardId},
      withAuth: true,
    );

    _isDeleting.value = false;

    return response.fold(
      (err) {
        _errorMessage.value = err.message ?? 'An unexpected error occurred.';
        debugPrint('Add Favorite Reward Error: ${err.message}');
        ToastMsg.error(_errorMessage.value);
        return false;
      },
      (res) async {
        debugPrint('Delete Favorite Reward Success: $rewardId');
        // Immediately update favorite state for instant UI feedback
        _getRewardDetailController.isFavorite.value = false;
        ToastMsg.success('Removed from favorites successfully!');
        // Refresh from server to sync full state
        await _getRewardDetailController.fetchRewardDetail(rewardId);
        return true;
      },
    );
  }
}
