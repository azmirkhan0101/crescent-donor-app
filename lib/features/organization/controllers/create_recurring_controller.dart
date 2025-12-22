import 'package:cresent_charge_user_app/features/organization/controllers/donate_now_controller.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateRecurringController extends GetxController {
  final donateNowController = Get.find<DonateNowController>();
  final RxBool isSaving = false.obs;
  final RxString errorMessage = ''.obs;

  Future<bool> createScheduledDonation({
    required String paymentMethodId,
    bool coverFees = false,
    // String? customIntervalUnit,
    // int? customIntervalValue,
  }) async {
    isSaving.value = true;
    errorMessage.value = '';

    final body = <String, dynamic>{
      'organizationId': donateNowController.organizationId.value,
      'causeId': donateNowController.selectedCause.value?.id ?? '',
      'amount': donateNowController.amount.value,

      'frequency': donateNowController.selectedFrequency.value,
      "startDate": donateNowController.recurringStartDateTime.value,
      'paymentMethodId': paymentMethodId,
      'coverFees': coverFees,
    };
    if (donateNowController.specialMsgController.text.isNotEmpty) {
      body['specialMessage'] = donateNowController.specialMsgController.text;
    }
    if (donateNowController.selectedFrequency.value == 'custom') {
      body['customInterval'] = {
        'unit': donateNowController.frequencyUnit.value,
        'value': donateNowController.intervalValue.value,
      };
    }

    final result = await Get.find<NetworkHelper>().request(
      'POST',
      ApiUrl.createScheduledDonation,
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
