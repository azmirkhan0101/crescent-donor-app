import 'package:cresent_charge_user_app/features/organization/models/payment_method_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

/// Model for Set Default Payment Method Response
class SetDefaultPaymentMethodResponse {
  final bool success;
  final String message;
  final PaymentMethodModel data;

  SetDefaultPaymentMethodResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SetDefaultPaymentMethodResponse.fromJson(Map<String, dynamic> json) {
    return SetDefaultPaymentMethodResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: PaymentMethodModel.fromJson(json['data']),
    );
  }
}

class SetDefaultPaymentMethodController extends GetxController {
  final _networkHelper = Get.find<NetworkHelper>();

  RxBool isSetting = false.obs;
  RxString errorMessage = ''.obs;
  Rx<PaymentMethodModel?> updatedPaymentMethod = Rx<PaymentMethodModel?>(null);

  Future<bool> setDefaultPaymentMethod(String paymentMethodId) async {
    isSetting.value = true;
    errorMessage.value = '';

    final result = await _networkHelper.request(
      'PATCH',
      ApiUrl.setDefaultPaymentMethod(paymentMethodId),
      withAuth: true,
      parser: (data) => SetDefaultPaymentMethodResponse.fromJson(data),
    );

    isSetting.value = false;

    return result.fold(
      (failure) {
        errorMessage.value =
            failure.message ?? 'Failed to set default payment method';
        debugPrint('Set default payment method error: ${errorMessage.value}');
        return false;
      },
      (response) {
        updatedPaymentMethod.value = response.data;
        debugPrint(
          'Set default payment method response: ${response.data.id} set as default',
        );
        return true;
      },
    );
  }

  void clearData() {
    updatedPaymentMethod.value = null;
    errorMessage.value = '';
  }
}
