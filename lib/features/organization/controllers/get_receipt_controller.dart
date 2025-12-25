// import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
// import 'package:cresent_charge_user_app/features/organization/models/receipt_model.dart';
// import 'package:cresent_charge_user_app/service/api_url.dart';
// import 'package:cresent_charge_user_app/service/network_helper.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';

// /// Get Receipt Controller
// ///
// /// Handles fetching and managing receipt details
// class GetReceiptController extends GetxController {
//   var receipt = Rx<ReceiptModel?>(null);
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;

//   /// Fetch receipt from API
//   Future<bool> fetchReceipt(String receiptId) async {
//     isLoading.value = true;
//     errorMessage.value = '';

//     final response = await Get.find<NetworkHelper>().request(
//       'GET',
//       ApiUrl.getReceipt(receiptId),
//       withAuth: true,
//     );

//     isLoading.value = false;

//     return response.fold(
//       (error) {
//         errorMessage.value = error.message ?? 'Failed to fetch receipt';
//         debugPrint('Error fetching receipt: ${error.message}');
//         ToastMsg.error(errorMessage.value);
//         return false;
//       },
//       (data) {
//         final receiptResponse = ReceiptResponse.fromJson(data);
//         receipt.value = receiptResponse.data;
//         debugPrint('Receipt fetched successfully');
//         return true;
//       },
//     );
//   }
// }
