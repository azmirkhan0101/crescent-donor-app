import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BusinessWebsiteCountUpdateController extends GetxController {
  var isCountUpdating = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;

  Future<void> updateWebsiteVisitCount(String storeId) async {
    isCountUpdating.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    final url = ApiUrl.getBusinessDetails(storeId);

    final response = await Get.find<NetworkHelper>().request(
      'PATCH',
      url,
      withAuth: true,
    );

    isCountUpdating.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error updating website visit count: ${error.message}');
        ToastMsg.error(errorMessage.value);
      },
      (data) {
        successMessage.value = 'Website visit count updated successfully';
        debugPrint('Website visit count updated successfully');
      },
    );
  }
}
