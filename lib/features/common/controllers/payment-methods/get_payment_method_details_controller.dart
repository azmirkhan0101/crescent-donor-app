// import 'package:cresent_charge_user_app/features/organization/models/payment_method_model.dart';
// import 'package:cresent_charge_user_app/service/api_url.dart';
// import 'package:cresent_charge_user_app/service/network_helper.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';

// /// Model for Payment Method Details Response
// class PaymentMethodDetailsResponse {
//   final bool success;
//   final String message;
//   final PaymentMethodModel data;

//   PaymentMethodDetailsResponse({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   factory PaymentMethodDetailsResponse.fromJson(Map<String, dynamic> json) {
//     return PaymentMethodDetailsResponse(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//       data: PaymentMethodModel.fromJson(json['data']),
//     );
//   }
// }

// class GetPaymentMethodDetailsController extends GetxController {
//   final _networkHelper = Get.find<NetworkHelper>();

//   RxBool isLoading = false.obs;
//   RxString errorMessage = ''.obs;
//   Rx<PaymentMethodModel?> paymentMethodDetails = Rx<PaymentMethodModel?>(null);

//   Future<bool> getPaymentMethodDetails(String paymentMethodId) async {
//     isLoading.value = true;
//     errorMessage.value = '';

//     final result = await _networkHelper.request(
//       'GET',
//       ApiUrl.getPaymentMethodDetails(paymentMethodId),
//       withAuth: true,
//       parser: (data) => PaymentMethodDetailsResponse.fromJson(data),
//     );

//     isLoading.value = false;

//     return result.fold(
//       (failure) {
//         errorMessage.value =
//             failure.message ?? 'Failed to get payment method details';
//         debugPrint('Get payment method details error: ${errorMessage.value}');
//         return false;
//       },
//       (response) {
//         paymentMethodDetails.value = response.data;
//         debugPrint('Get payment method details response: ${response.data.id}');
//         return true;
//       },
//     );
//   }

//   void clearData() {
//     paymentMethodDetails.value = null;
//     errorMessage.value = '';
//   }
// }
