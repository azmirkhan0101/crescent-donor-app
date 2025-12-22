import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class SaveRoundupController extends GetxController {
  final RxBool isSaving = false.obs;
  final RxString errorMessage = ''.obs;

  Future<bool> saveRoundupConsent({
    required String bankConnectionId,
    required String organizationId,
    required String causeId,
    required double monthlyThreshold,
    required String paymentMethodId,
    String? specialMessage,
    bool coverFees = false,
  }) async {
    isSaving.value = true;
    errorMessage.value = '';

    final body = <String, dynamic>{
      'bankConnectionId': bankConnectionId,
      'organizationId': organizationId,
      'causeId': causeId,
      'monthlyThreshold': monthlyThreshold,
      'paymentMethodId': paymentMethodId,
      'coverFees': coverFees,
      if (specialMessage != null && specialMessage.isNotEmpty)
        'specialMessage': specialMessage,
    };

    final result = await Get.find<NetworkHelper>().request(
      'POST',
      ApiUrl.saveRoundupConsent,
      body: body,
      withAuth: true,
    );

    isSaving.value = false;

    return result.fold(
      (failure) {
        errorMessage.value = failure.message ?? 'Failed to save roundup';
        debugPrint('Save roundup error: ${errorMessage.value}');
        return false;
      },
      (data) {
        debugPrint('Save roundup response data: $data');
        return true;
      },
    );
  }
}
