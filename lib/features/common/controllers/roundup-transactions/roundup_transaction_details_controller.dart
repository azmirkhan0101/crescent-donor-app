import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

/// Model for RoundUp Transaction Details Response
class RoundUpTransactionDetailsResponse {
  final bool success;
  final String message;
  final RoundUpTransactionDetails data;

  RoundUpTransactionDetailsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RoundUpTransactionDetailsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return RoundUpTransactionDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: RoundUpTransactionDetails.fromJson(json['data']),
    );
  }
}

/// Model for RoundUp Transaction Details (extends RoundUpTransaction with additional fields)
class RoundUpTransactionDetails {
  final String id;
  final String roundUpId;
  final String userId;
  final String bankConnectionId;
  final String organizationId;
  final String? causeId;
  final String paymentMethodId;
  final double amount;
  final String status;
  final String? transactionId;
  final String? failureReason;
  final String? specialMessage;
  final String createdAt;
  final String? processedAt;
  final String updatedAt;
  final int v;

  // Additional details that might be included in detailed view
  final Map<String, dynamic>? bankConnection;
  final Map<String, dynamic>? organization;
  final Map<String, dynamic>? cause;
  final Map<String, dynamic>? paymentMethod;
  final Map<String, dynamic>? roundUpConfig;

  RoundUpTransactionDetails({
    required this.id,
    required this.roundUpId,
    required this.userId,
    required this.bankConnectionId,
    required this.organizationId,
    this.causeId,
    required this.paymentMethodId,
    required this.amount,
    required this.status,
    this.transactionId,
    this.failureReason,
    this.specialMessage,
    required this.createdAt,
    this.processedAt,
    required this.updatedAt,
    required this.v,
    this.bankConnection,
    this.organization,
    this.cause,
    this.paymentMethod,
    this.roundUpConfig,
  });

  factory RoundUpTransactionDetails.fromJson(Map<String, dynamic> json) {
    return RoundUpTransactionDetails(
      id: json['_id'] ?? '',
      roundUpId: json['roundUpId'] ?? '',
      userId: json['userId'] ?? '',
      bankConnectionId: json['bankConnectionId'] ?? '',
      organizationId: json['organizationId'] ?? '',
      causeId: json['causeId'],
      paymentMethodId: json['paymentMethodId'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? '',
      transactionId: json['transactionId'],
      failureReason: json['failureReason'],
      specialMessage: json['specialMessage'],
      createdAt: json['createdAt'] ?? '',
      processedAt: json['processedAt'],
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      bankConnection: json['bankConnection'],
      organization: json['organization'],
      cause: json['cause'],
      paymentMethod: json['paymentMethod'],
      roundUpConfig: json['roundUpConfig'],
    );
  }
}

class RoundUpTransactionDetailsController extends GetxController {
  final _networkHelper = Get.find<NetworkHelper>();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  Rx<RoundUpTransactionDetails?> transactionDetails =
      Rx<RoundUpTransactionDetails?>(null);

  Future<bool> fetchTransactionDetails(String transactionId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _networkHelper.request(
      'GET',
      ApiUrl.getRoundupTransactionDetails(transactionId),
      withAuth: true,
      parser: (data) => RoundUpTransactionDetailsResponse.fromJson(data),
    );

    isLoading.value = false;

    return result.fold(
      (failure) {
        errorMessage.value =
            failure.message ?? 'Failed to load transaction details';
        debugPrint('Fetch transaction details error: ${errorMessage.value}');
        return false;
      },
      (response) {
        transactionDetails.value = response.data;
        debugPrint(
          'Fetch transaction details response: Transaction ${response.data.id} loaded',
        );
        return true;
      },
    );
  }

  void clearDetails() {
    transactionDetails.value = null;
    errorMessage.value = '';
  }
}
