// import 'package:donor/core/helper/tost_message/toast_message.dart';
// import 'package:donor/features/payment/models/basiq_accounts_model.dart';
// import 'package:donor/service/api_url.dart';
// import 'package:donor/service/network_helper.dart';
// import 'package:get/get.dart';

// class SaveBasiqConnectionController extends GetxController {
//   final _isLoading = false.obs;
//   final _errorMessage = ''.obs;

//   RxBool get isLoading => _isLoading;
//   RxString get errorMessage => _errorMessage;

//   Future<bool> saveConnection(BasiqAccount connectionData) async {
//     _isLoading.value = true;
//     _errorMessage.value = '';

//     final response = await Get.find<NetworkHelper>().request(
//       'POST',
//       ApiUrl.saveBasiqConnection,
//       body: connectionData.toJson(),
//       withAuth: true,
//     );
//     _isLoading.value = false;

//     return response.fold(
//       (error) {
//         _errorMessage.value = error.message ?? 'Failed to save connection';
//         ToastMsg.error(_errorMessage.value);
//         return false;
//       },
//       (data) {
//         ToastMsg.success('Connection saved successfully');
//         return true;
//       },
//     );
//   }
// }
