// import 'package:cresent_charge_user_app/service/api_url.dart';
// import 'package:cresent_charge_user_app/service/network_helper.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';

// class SecureRoundupResumeController extends GetxController {
//   RxBool isResuming = false.obs;
//   RxString errorMessage = ''.obs;

//   Future<bool> resumeRoundup(String roundUpId) async {
//     isResuming.value = true;
//     errorMessage.value = '';

//     final body = {'roundUpId': roundUpId};

//     final result = await Get.find<NetworkHelper>().request(
//       'POST',
//       ApiUrl.resumeRoundup,
//       body: body,
//       withAuth: true,
//     );

//     isResuming.value = false;

//     return result.fold(
//       (failure) {
//         errorMessage.value = failure.message ?? 'Failed to resume roundup';
//         debugPrint('Resume roundup error: ${errorMessage.value}');
//         return false;
//       },
//       (data) {
//         debugPrint('Resume roundup response data: $data');
//         return true;
//       },
//     );
//   }
// }
