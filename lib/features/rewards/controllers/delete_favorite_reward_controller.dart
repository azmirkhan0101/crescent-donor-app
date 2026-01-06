import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteFavoriteRewardController extends GetxController {
  final _isDeleting = false.obs;
  final _errorMessage = ''.obs;

  RxBool get isDeleting => _isDeleting;
  RxString get errorMessage => _errorMessage;

  Future<bool> deleteFavoriteReward(String rewardId) async {
    _isDeleting.value = true;
    _errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      "POST",
      ApiUrl.url('favorite/add'),
      body: {"reward": rewardId},
      withAuth: true,
    );

    _isDeleting.value = false;

    return response.fold(
      (err) {
        _errorMessage.value = err.message ?? 'An unexpected error occurred.';
        debugPrint('Add Favorite Reward Error: ${err.message}');
        return false;
      },
      (res) {
        return true;
      },
    );
  }
}
