import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

/// Model for RoundUp Transaction
class RoundUpTransaction {
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

  RoundUpTransaction({
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
  });

  factory RoundUpTransaction.fromJson(Map<String, dynamic> json) {
    return RoundUpTransaction(
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
    );
  }
}

/// Model for RoundUp Transactions Response
class RoundUpTransactionsResponse {
  final bool success;
  final String message;
  final List<RoundUpTransaction> data;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  RoundUpTransactionsResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory RoundUpTransactionsResponse.fromJson(Map<String, dynamic> json) {
    return RoundUpTransactionsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((item) => RoundUpTransaction.fromJson(item))
          .toList(),
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 20,
      totalPages: json['totalPages'] ?? 0,
    );
  }
}

class RoundUpTransactionsController extends GetxController {
  final _networkHelper = Get.find<NetworkHelper>();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxList<RoundUpTransaction> transactions = <RoundUpTransaction>[].obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;
  RxInt totalTransactions = 0.obs;

  Future<bool> fetchTransactions({
    String? status,
    int? page = 1,
    int? limit = 20,
    int? month,
    int? year,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _networkHelper.request(
      'GET',
      ApiUrl.getRoundupTransactions(
        status: status,
        page: page,
        limit: limit,
        month: month,
        year: year,
      ),
      withAuth: true,
      parser: (data) => RoundUpTransactionsResponse.fromJson(data),
    );

    isLoading.value = false;

    return result.fold(
      (failure) {
        errorMessage.value = failure.message ?? 'Failed to load transactions';
        debugPrint('Fetch transactions error: ${errorMessage.value}');
        return false;
      },
      (response) {
        if (page == 1) {
          transactions.value = response.data;
        } else {
          transactions.addAll(response.data);
        }
        currentPage.value = response.page;
        totalPages.value = response.totalPages;
        totalTransactions.value = response.total;
        debugPrint(
          'Fetch transactions response: ${response.data.length} transactions loaded',
        );
        return true;
      },
    );
  }

  Future<void> loadMoreTransactions({
    String? status,
    int? month,
    int? year,
  }) async {
    if (currentPage.value >= totalPages.value || isLoading.value) return;

    await fetchTransactions(
      status: status,
      page: currentPage.value + 1,
      limit: 20,
      month: month,
      year: year,
    );
  }

  void clearTransactions() {
    transactions.clear();
    currentPage.value = 1;
    totalPages.value = 1;
    totalTransactions.value = 0;
    errorMessage.value = '';
  }
}
