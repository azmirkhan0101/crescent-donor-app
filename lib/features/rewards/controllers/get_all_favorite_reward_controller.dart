import 'package:cresent_charge_user_app/features/rewards/models/favorite_reword_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetAllFavoriteRewardController extends GetxController {
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;
  final _favoriteRewards = <FavoriteRewardModel>[].obs;

  RxBool get isLoading => _isLoading;
  RxString get errorMessage => _errorMessage;
  RxList<FavoriteRewardModel> get favoriteRewards => _favoriteRewards;

  Future<bool> fetchAllFavoriteRewards() async {
    _isLoading.value = true;
    _errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      "GET",
      ApiUrl.url('/favorite/me?searchTerm=Mostafiz&page=1&limit=10'),
      withAuth: true,
    );

    _isLoading.value = false;

    return response.fold(
      (err) {
        _errorMessage.value = err.message ?? 'An unexpected error occurred.';
        debugPrint('Fetch All Favorite Rewards Error: ${err.message}');
        return false;
      },
      (res) {
        debugPrint('Fetch All Favorite Rewards Success');
        _favoriteRewards.value = (res['data'] as List)
            .map((e) => FavoriteRewardModel.fromJson(e))
            .toList();
        return true;
      },
    );
  }
}
