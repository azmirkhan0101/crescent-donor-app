import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFavoriteRewardController extends GetxController {
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;

  RxBool get isLoading => _isLoading;
  RxString get errorMessage => _errorMessage;

  Future<bool> addFavoriteReward(String rewardId) async {
    _isLoading.value = true;
    _errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      "POST",
      ApiUrl.url('favorite/add'),
      body: {"reward": rewardId},
      withAuth: true,
    );

    _isLoading.value = false;

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
