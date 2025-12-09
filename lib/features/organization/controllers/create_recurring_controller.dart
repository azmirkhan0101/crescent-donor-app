import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateRecurringController extends GetxController {
  final RxBool isSaving = false.obs;
  final RxString errorMessage = ''.obs;

  Future<bool> createScheduledDonation({
    required String organizationId,
    required String causeId,
    required num amount,
    required String frequency,
    required String paymentMethodId,
    bool coverFees = false,
    String? customIntervalUnit,
    int? customIntervalValue,
    String? specialMessage,
  }) async {
    isSaving.value = true;
    errorMessage.value = '';

    final body = <String, dynamic>{
      'organizationId': organizationId,
      'causeId': causeId,
      'amount': amount,
      'frequency': frequency,
      'paymentMethodId': paymentMethodId,
      'coverFees': coverFees,
    };
    if (specialMessage != null && specialMessage.isNotEmpty) {
      body['specialMessage'] = specialMessage;
    }
    if (frequency == 'custom') {
      body['customInterval'] = {
        'unit': customIntervalUnit,
        'value': customIntervalValue,
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
