// import 'package:cresent_charge_user_app/features/organization/models/payment_method_model.dart';
// import 'package:cresent_charge_user_app/service/api_url.dart';
// import 'package:cresent_charge_user_app/service/network_helper.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';

// /// Model for Default Payment Method Response
// class DefaultPaymentMethodResponse {
//   final bool success;
//   final String message;
//   final PaymentMethodModel? data;

//   DefaultPaymentMethodResponse({
//     required this.success,
//     required this.message,
//     this.data,
//   });

//   factory DefaultPaymentMethodResponse.fromJson(Map<String, dynamic> json) {
//     return DefaultPaymentMethodResponse(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//       data: json['data'] != null
//           ? PaymentMethodModel.fromJson(json['data'])
//           : null,
//     );
//   }
// }

// class GetDefaultPaymentMethodController extends GetxController {
//   final _networkHelper = Get.find<NetworkHelper>();

//   RxBool isLoading = false.obs;
//   RxString errorMessage = ''.obs;
//   Rx<PaymentMethodModel?> defaultPaymentMethod = Rx<PaymentMethodModel?>(null);

//   Future<bool> getDefaultPaymentMethod() async {
//     isLoading.value = true;
//     errorMessage.value = '';

//     final result = await _networkHelper.request(
//       'GET',
//       ApiUrl.getDefaultPaymentMethod,
//       withAuth: true,
//       parser: (data) => DefaultPaymentMethodResponse.fromJson(data),
//     );

//     isLoading.value = false;

//     return result.fold(
//       (failure) {
//         errorMessage.value =
//             failure.message ?? 'Failed to get default payment method';
//         debugPrint('Get default payment method error: ${errorMessage.value}');
//         return false;
//       },
//       (response) {
//         defaultPaymentMethod.value = response.data;
//         debugPrint(
//           'Get default payment method response: ${response.data?.id ?? 'No default method'}',
//         );
//         return true;
//       },
//     );
//   }

//   void clearData() {
//     defaultPaymentMethod.value = null;
//     errorMessage.value = '';
//   }
// }
