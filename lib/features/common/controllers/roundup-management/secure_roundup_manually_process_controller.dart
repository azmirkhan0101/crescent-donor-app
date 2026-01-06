// import 'package:cresent_charge_user_app/service/api_url.dart';
// import 'package:cresent_charge_user_app/service/network_helper.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';

// class SecureRoundupManuallyProcessController extends GetxController {
//   RxBool isProcessing = false.obs;
//   RxString errorMessage = ''.obs;

//   Future<bool> manuallyProcessRoundupDonation({
//     required String roundUpId,
//     required String specialMessage,
//   }) async {
//     isProcessing.value = true;
//     errorMessage.value = '';

//     final body = {'roundUpId': roundUpId, 'specialMessage': specialMessage};

//     final result = await Get.find<NetworkHelper>().request(
//       'POST',
//       ApiUrl.processMonthlyDonation,
//       body: body,
//       withAuth: true,
//     );

//     isProcessing.value = false;

//     return result.fold(
//       (failure) {
//         errorMessage.value =
//             failure.message ?? 'Failed to process monthly donation';
//         debugPrint('Process monthly donation error: ${errorMessage.value}');
//         return false;
//       },
//       (data) {
//         debugPrint('Process monthly donation response data: $data');
//         return true;
//       },
//     );
//   }
// }
