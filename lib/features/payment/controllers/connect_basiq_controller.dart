import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class ConnectBasiqController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var url = ''.obs;

  Future<bool> connectBasiq() async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'POST',
      ApiUrl.connectBasiq,
      withAuth: true,
      parser: (data) => data['data'] as Map<String, dynamic>?,
    );

    isLoading.value = false;

    return response.fold(
      (error) {
        errorMessage.value = error.message ?? 'Failed to connect to Basiq';
        ToastMsg.error(error.message ?? 'Failed to connect to Basiq');
        return false;
      },
      (data) {
        // Handle successful response if needed
        if (data != null && data.containsKey('url')) {
          url.value = data['url'] as String;
        }
        return true;
      },
    );
  }
}
