import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class OneTimeDonationController extends GetxController {
  final RxBool isProcessing = false.obs;
  final RxString errorMessage = ''.obs;
  final NetworkHelper _networkHelper = Get.find<NetworkHelper>();

  /// Process a one-time donation
  Future<void> processDonation() async {
    isProcessing.value = true;
    errorMessage.value = '';

    final result = await _networkHelper.request(
      'POST',
      ApiUrl.oneTimeDonationCreate,
      body: {
        'organizationId': '',
        'amount': 3,
        "currency": "usd",
        "causeId": "",
        "paymentMethodId": "",
        "specialMessage": "",
      },
      parser: (data) => data,
    );

    result.fold(
      (failure) {
        errorMessage.value = failure.message ?? 'Failed to process donation';
      },
      (response) {
        if (response is Map<String, dynamic> && response['success'] == true) {
          // Donation processed successfully
        } else {
          errorMessage.value =
              response['message'] ?? 'Failed to process donation';
        }
      },
    );
  }
}
