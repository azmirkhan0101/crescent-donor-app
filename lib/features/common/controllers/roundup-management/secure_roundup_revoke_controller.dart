// import 'package:cresent_charge_user_app/service/api_url.dart';
// import 'package:cresent_charge_user_app/service/network_helper.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';

// class SecureRoundupRevokeController extends GetxController {
//   RxBool isRevoking = false.obs;
//   RxString errorMessage = ''.obs;

//   Future<bool> revokeConsent(String bankConnectionId) async {
//     isRevoking.value = true;
//     errorMessage.value = '';

//     final result = await Get.find<NetworkHelper>().request(
//       'POST',
//       ApiUrl.revokeRoundupConsent(bankConnectionId),
//       withAuth: true,
//     );

//     isRevoking.value = false;

//     return result.fold(
//       (failure) {
//         errorMessage.value = failure.message ?? 'Failed to revoke consent';
//         debugPrint('Revoke consent error: ${errorMessage.value}');
//         return false;
//       },
//       (data) {
//         debugPrint('Revoke consent response data: $data');
//         return true;
//       },
//     );
//   }
// }
