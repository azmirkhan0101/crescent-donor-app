// import 'package:cresent_charge_user_app/features/home/models/cause_model.dart';
// import 'package:cresent_charge_user_app/service/api_url.dart';
// import 'package:cresent_charge_user_app/service/network_helper.dart';
// import 'package:get/get.dart';

// class CausesController extends GetxController {
//   // Observable variables
//   RxBool isLoading = false.obs;
//   RxString errorMessage = ''.obs;

//   // Store causes data
//   RxList<CauseData> causes = RxList<CauseData>([]);

//   // Fetch all causes from API
//   Future<bool> fetchAllCauses() async {
//     errorMessage.value = '';
//     isLoading.value = true;

//     final result = await Get.find<NetworkHelper>().request(
//       'GET',
//       ApiUrl.getAllCauses,
//       parser: (data) => CauseResponseModel.fromJson(data),
//       withAuth: true,
//     );
//     return result.fold(
//       (err) {
//         errorMessage.value = err.message ?? 'Failed to load causes';
//         return false;
//       },
//       (data) {
//         causes.value = data.data;
//         return true;
//       },
//     );
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     fetchAllCauses();
//   }
// }
