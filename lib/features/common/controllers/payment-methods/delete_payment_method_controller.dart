// import 'package:cresent_charge_user_app/service/api_url.dart';
// import 'package:cresent_charge_user_app/service/network_helper.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';

// /// Model for Delete Payment Method Response
// class DeletePaymentMethodResponse {
//   final bool success;
//   final String message;

//   DeletePaymentMethodResponse({required this.success, required this.message});

//   factory DeletePaymentMethodResponse.fromJson(Map<String, dynamic> json) {
//     return DeletePaymentMethodResponse(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//     );
//   }
// }

// class DeletePaymentMethodController extends GetxController {
//   final _networkHelper = Get.find<NetworkHelper>();

//   RxBool isDeleting = false.obs;
//   RxString errorMessage = ''.obs;

//   Future<bool> deletePaymentMethod(String paymentMethodId) async {
//     isDeleting.value = true;
//     errorMessage.value = '';

//     final result = await _networkHelper.request(
//       'DELETE',
//       ApiUrl.deletePaymentMethod(paymentMethodId),
//       withAuth: true,
//       parser: (data) => DeletePaymentMethodResponse.fromJson(data),
//     );

//     isDeleting.value = false;

//     return result.fold(
//       (failure) {
//         errorMessage.value =
//             failure.message ?? 'Failed to delete payment method';
//         debugPrint('Delete payment method error: ${errorMessage.value}');
//         return false;
//       },
//       (response) {
//         debugPrint(
//           'Delete payment method response: Payment method deleted successfully',
//         );
//         return true;
//       },
//     );
//   }

//   void clearData() {
//     errorMessage.value = '';
//   }
// }
