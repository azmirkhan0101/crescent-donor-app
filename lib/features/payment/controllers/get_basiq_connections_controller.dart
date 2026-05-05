// import 'package:donor/core/helper/tost_message/toast_message.dart';
// import 'package:donor/features/payment/models/basiq_accounts_model.dart';
// import 'package:donor/service/api_url.dart';
// import 'package:donor/service/network_helper.dart';
// import 'package:get/get.dart';

// class GetBasiqConnectionsController extends GetxController {
//   final _connections = <BasiqAccount>[].obs;
//   final _isLoading = false.obs;
//   final _errorMessage = ''.obs;

//   RxList<BasiqAccount> get connections => _connections;
//   RxBool get isLoading => _isLoading;
//   RxString get errorMessage => _errorMessage;

//   Future<bool> fetchConnections() async {
//     _isLoading.value = true;
//     _errorMessage.value = '';

//     final response = await Get.find<NetworkHelper>().request(
//       'GET',
//       ApiUrl.getBasiqConnections,
//       withAuth: true,
//     );
//     _isLoading.value = false;

//     return response.fold(
//       (error) {
//         _errorMessage.value = error.message ?? 'Failed to fetch connections';
//         ToastMsg.error(_errorMessage.value);
//         return false;
//       },
//       (data) {
//         List<dynamic> dataList = data['data'] ?? [];
//         // Parse the data and update _connections
//         if (dataList.isNotEmpty) {
//           _connections.value = dataList
//               .map((item) => BasiqAccount.fromJson(item))
//               .toList();
//         }
//         return true;
//       },
//     );
//   }
// }
