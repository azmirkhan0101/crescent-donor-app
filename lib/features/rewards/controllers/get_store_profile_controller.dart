import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/rewards/models/store_profile_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GetStoreProfileController extends GetxController {
  var storeProfile = Rx<StoreProfileModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchStoreProfile(String storeId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final url = ApiUrl.getBusinessDetails(storeId);

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      url,
      withAuth: true,
    );

    isLoading.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error fetching store profile: ${error.message}');
        ToastMsg.error(errorMessage.value);
      },
      (data) {
        storeProfile.value = StoreProfileModel.fromJson(data['data']);
      },
    );
  }
}
