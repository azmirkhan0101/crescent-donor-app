import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class SecureRoundupSwitchCharityController extends GetxController {
  RxBool isSwitching = false.obs;
  RxString errorMessage = ''.obs;

  Future<bool> switchCharity({
    required String roundUpId,
    required String newOrganizationId,
    required String newCauseId,
  }) async {
    isSwitching.value = true;
    errorMessage.value = '';

    final body = {
      'roundUpId': roundUpId,
      'newOrganizationId': newOrganizationId,
      'newCauseId': newCauseId,
    };

    final result = await Get.find<NetworkHelper>().request(
      'POST',
      ApiUrl.switchRoundupCharity,
      body: body,
      withAuth: true,
    );

    isSwitching.value = false;

    return result.fold(
      (failure) {
        errorMessage.value = failure.message ?? 'Failed to switch charity';
        debugPrint('Switch charity error: ${errorMessage.value}');
        return false;
      },
      (data) {
        debugPrint('Switch charity response data: $data');
        return true;
      },
    );
  }
}
