// import 'package:cresent_charge_user_app/service/api_url.dart';
// import 'package:cresent_charge_user_app/service/network_helper.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';

// /// Model for RoundUp Transactions Summary
// class RoundUpTransactionsSummary {
//   final int totalTransactions;
//   final double totalAmount;
//   final int successfulTransactions;
//   final double successfulAmount;
//   final int failedTransactions;
//   final double failedAmount;
//   final int pendingTransactions;
//   final double pendingAmount;
//   final Map<String, dynamic> monthlyBreakdown;

//   RoundUpTransactionsSummary({
//     required this.totalTransactions,
//     required this.totalAmount,
//     required this.successfulTransactions,
//     required this.successfulAmount,
//     required this.failedTransactions,
//     required this.failedAmount,
//     required this.pendingTransactions,
//     required this.pendingAmount,
//     required this.monthlyBreakdown,
//   });

//   factory RoundUpTransactionsSummary.fromJson(Map<String, dynamic> json) {
//     return RoundUpTransactionsSummary(
//       totalTransactions: json['totalTransactions'] ?? 0,
//       totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
//       successfulTransactions: json['successfulTransactions'] ?? 0,
//       successfulAmount: (json['successfulAmount'] as num?)?.toDouble() ?? 0.0,
//       failedTransactions: json['failedTransactions'] ?? 0,
//       failedAmount: (json['failedAmount'] as num?)?.toDouble() ?? 0.0,
//       pendingTransactions: json['pendingTransactions'] ?? 0,
//       pendingAmount: (json['pendingAmount'] as num?)?.toDouble() ?? 0.0,
//       monthlyBreakdown: json['monthlyBreakdown'] ?? {},
//     );
//   }
// }

// /// Model for RoundUp Transactions Summary Response
// class RoundUpTransactionsSummaryResponse {
//   final bool success;
//   final String message;
//   final RoundUpTransactionsSummary data;

//   RoundUpTransactionsSummaryResponse({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   factory RoundUpTransactionsSummaryResponse.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     return RoundUpTransactionsSummaryResponse(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//       data: RoundUpTransactionsSummary.fromJson(json['data']),
//     );
//   }
// }

// class RoundUpTransactionsSummaryController extends GetxController {
//   final _networkHelper = Get.find<NetworkHelper>();

//   RxBool isLoading = false.obs;
//   RxString errorMessage = ''.obs;
//   Rx<RoundUpTransactionsSummary?> summary = Rx<RoundUpTransactionsSummary?>(
//     null,
//   );

//   Future<bool> fetchSummary() async {
//     isLoading.value = true;
//     errorMessage.value = '';

//     final result = await _networkHelper.request(
//       'GET',
//       ApiUrl.getRoundupTransactionsSummary,
//       withAuth: true,
//       parser: (data) => RoundUpTransactionsSummaryResponse.fromJson(data),
//     );

//     isLoading.value = false;

//     return result.fold(
//       (failure) {
//         errorMessage.value = failure.message ?? 'Failed to load summary';
//         debugPrint('Fetch summary error: ${errorMessage.value}');
//         return false;
//       },
//       (response) {
//         summary.value = response.data;
//         debugPrint(
//           'Fetch summary response: ${response.data.totalTransactions} total transactions',
//         );
//         return true;
//       },
//     );
//   }
// }
