class OneTimeDonationResponse {
  final bool success;
  final String message;
  final DonationData? data;

  OneTimeDonationResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory OneTimeDonationResponse.fromJson(Map<String, dynamic> json) {
    return OneTimeDonationResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? DonationData.fromJson(json['data']) : null,
    );
  }
}

class DonationData {
  final String id;
  final int amount;
  final String currency;
  final String organizationId;
  final String causeId;
  final String paymentMethodId;
  final String? specialMessage;
  final String status;
  final DateTime createdAt;

  DonationData({
    required this.id,
    required this.amount,
    required this.currency,
    required this.organizationId,
    required this.causeId,
    required this.paymentMethodId,
    this.specialMessage,
    required this.status,
    required this.createdAt,
  });

  factory DonationData.fromJson(Map<String, dynamic> json) {
    return DonationData(
      id: json['_id'] ?? json['id'] ?? '',
      amount: json['amount'] ?? 0,
      currency: json['currency'] ?? 'usd',
      organizationId: json['organizationId'] ?? json['organization'] ?? '',
      causeId: json['causeId'] ?? json['cause'] ?? '',
      paymentMethodId: json['paymentMethodId'] ?? json['paymentMethod'] ?? '',
      specialMessage: json['specialMessage'],
      status: json['status'] ?? 'pending',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}
