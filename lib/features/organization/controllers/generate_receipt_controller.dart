// import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
// import 'package:cresent_charge_user_app/features/organization/models/receipt_model.dart';
// import 'package:cresent_charge_user_app/service/api_url.dart';
// import 'package:cresent_charge_user_app/service/network_helper.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';

// /// Generate Receipt Controller
// ///
// /// Handles generating receipts for donations
// class GenerateReceiptController extends GetxController {
//   var isGenerating = false.obs;
//   var errorMessage = ''.obs;
//   var generatedReceipt = Rx<ReceiptModel?>(null);

//   /// Generate receipt for a donation
//   Future<bool> generateReceipt({
//     String? donationId,
//     String? donorId,
//     String? organizationId,
//     String? causeId,
//     double? amount,
//     String? currency,
//     String? donationType,
//     String? donationDate,
//     String? paymentMethod,
//     bool? taxDeductible,
//     String? abnNumber,
//     bool? zakatEligible,
//     String? specialMessage,
//   }) async {
//     isGenerating.value = true;
//     errorMessage.value = '';

//     final Map<String, dynamic> requestBody = {
//       "donationId": donationId,
//       "donorId": donorId,
//       "organizationId": organizationId,
//       "causeId": causeId,
//       "amount": amount,
//       "currency": currency,
//       "donationType": donationType,
//       "donationDate": donationDate,
//       "paymentMethod": paymentMethod,
//       "taxDeductible": taxDeductible,
//       "abnNumber": abnNumber,
//       "zakatEligible": zakatEligible,
//       "specialMessage": specialMessage,
//     };

//     final response = await Get.find<NetworkHelper>().request(
//       'POST',
//       ApiUrl.generateReceipt,
//       body: requestBody,
//       withAuth: true,
//     );

//     isGenerating.value = false;

//     return response.fold(
//       (error) {
//         errorMessage.value = error.message ?? 'Failed to generate receipt';
//         debugPrint('Error generating receipt: ${error.message}');
//         ToastMsg.error(errorMessage.value);
//         return false;
//       },
//       (data) {
//         final receiptResponse = ReceiptResponse.fromJson(data);
//         generatedReceipt.value = receiptResponse.data;
//         debugPrint('Receipt generated successfully');
//         ToastMsg.success('Receipt generated successfully');
//         return true;
//       },
//     );
//   }

//   /// Clear generated receipt data
//   void clearGeneratedReceipt() {
//     generatedReceipt.value = null;
//     errorMessage.value = '';
//   }
// }
