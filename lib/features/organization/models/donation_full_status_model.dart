/// Donation Full Status Models
/// Response model for GET /donation/:donationId/status

class DonationFullStatusResponse {
  final bool success;
  final String message;
  final DonationFullStatusData data;

  DonationFullStatusResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DonationFullStatusResponse.fromJson(Map<String, dynamic> json) {
    return DonationFullStatusResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: DonationFullStatusData.fromJson(json['data'] ?? {}),
    );
  }
}

class DonationFullStatusData {
  final DonationModel donation;
  final PaymentStatusModel paymentStatus;

  DonationFullStatusData({required this.donation, required this.paymentStatus});

  factory DonationFullStatusData.fromJson(Map<String, dynamic> json) {
    return DonationFullStatusData(
      donation: DonationModel.fromJson(json['donation'] ?? {}),
      paymentStatus: PaymentStatusModel.fromJson(json['paymentStatus'] ?? {}),
    );
  }
}

class DonationModel {
  final String id;
  final DonorModel donor;
  final DonationOrganizationModel organization;
  final DonationCauseModel cause;
  final String donationType;
  final double amount;
  final bool coverFees;
  final double platformFee;
  final double gstOnFee;
  final double stripeFee;
  final double netAmount;
  final double totalAmount;
  final String currency;
  final String status;
  final String stripeCustomerId;
  final String stripePaymentMethodId;
  final String? specialMessage;
  final int pointsEarned;
  final List<dynamic> roundUpTransactionIds;
  final bool receiptGenerated;
  final String idempotencyKey;
  final int paymentAttempts;
  final String createdAt;
  final String donationDate;
  final String updatedAt;
  final String? stripePaymentIntentId;
  final String? stripeChargeId;
  final ReceiptModel? receiptId;

  DonationModel({
    required this.id,
    required this.donor,
    required this.organization,
    required this.cause,
    required this.donationType,
    required this.amount,
    required this.coverFees,
    required this.platformFee,
    required this.gstOnFee,
    required this.stripeFee,
    required this.netAmount,
    required this.totalAmount,
    required this.currency,
    required this.status,
    required this.stripeCustomerId,
    required this.stripePaymentMethodId,
    this.specialMessage,
    required this.pointsEarned,
    required this.roundUpTransactionIds,
    required this.receiptGenerated,
    required this.idempotencyKey,
    required this.paymentAttempts,
    required this.createdAt,
    required this.donationDate,
    required this.updatedAt,
    this.stripePaymentIntentId,
    this.stripeChargeId,
    this.receiptId,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['_id'] ?? '',
      donor: DonorModel.fromJson(json['donor'] ?? {}),
      organization: DonationOrganizationModel.fromJson(
        json['organization'] ?? {},
      ),
      cause: DonationCauseModel.fromJson(json['cause'] ?? {}),
      donationType: json['donationType'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      coverFees: json['coverFees'] ?? false,
      platformFee: (json['platformFee'] as num?)?.toDouble() ?? 0.0,
      gstOnFee: (json['gstOnFee'] as num?)?.toDouble() ?? 0.0,
      stripeFee: (json['stripeFee'] as num?)?.toDouble() ?? 0.0,
      netAmount: (json['netAmount'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] ?? '',
      status: json['status'] ?? '',
      stripeCustomerId: json['stripeCustomerId'] ?? '',
      stripePaymentMethodId: json['stripePaymentMethodId'] ?? '',
      specialMessage: json['specialMessage'],
      pointsEarned: json['pointsEarned'] ?? 0,
      roundUpTransactionIds: List<dynamic>.from(
        json['roundUpTransactionIds'] ?? [],
      ),
      receiptGenerated: json['receiptGenerated'] ?? false,
      idempotencyKey: json['idempotencyKey'] ?? '',
      paymentAttempts: json['paymentAttempts'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      donationDate: json['donationDate'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      stripePaymentIntentId: json['stripePaymentIntentId'],
      stripeChargeId: json['stripeChargeId'],
      receiptId: json['receiptId'] != null
          ? ReceiptModel.fromJson(json['receiptId'])
          : null,
    );
  }
}

class DonorModel {
  final String id;
  final String auth;
  final String name;
  final String address;
  final String state;
  final String postalCode;
  final String? image;

  DonorModel({
    required this.id,
    required this.auth,
    required this.name,
    required this.address,
    required this.state,
    required this.postalCode,
    this.image,
  });

  factory DonorModel.fromJson(Map<String, dynamic> json) {
    return DonorModel(
      id: json['_id'] ?? '',
      auth: json['auth'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      image: json['image'],
    );
  }
}

class DonationOrganizationModel {
  final String id;
  final String name;

  DonationOrganizationModel({required this.id, required this.name});

  factory DonationOrganizationModel.fromJson(Map<String, dynamic> json) {
    return DonationOrganizationModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class DonationCauseModel {
  final String id;
  final String name;
  final String description;

  DonationCauseModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory DonationCauseModel.fromJson(Map<String, dynamic> json) {
    return DonationCauseModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class PaymentStatusModel {
  final String status;
  final int paymentAttempts;
  final bool canRetry;
  final String? paymentIntentId;

  PaymentStatusModel({
    required this.status,
    required this.paymentAttempts,
    required this.canRetry,
    this.paymentIntentId,
  });

  factory PaymentStatusModel.fromJson(Map<String, dynamic> json) {
    return PaymentStatusModel(
      status: json['status'] ?? '',
      paymentAttempts: json['paymentAttempts'] ?? 0,
      canRetry: json['canRetry'] ?? false,
      paymentIntentId: json['paymentIntentId'],
    );
  }
}

class ReceiptModel {
  final String id;
  final String receiptNumber;
  final String pdfUrl;
  final String pdfKey;

  ReceiptModel({
    required this.id,
    required this.receiptNumber,
    required this.pdfUrl,
    required this.pdfKey,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) {
    return ReceiptModel(
      id: json['_id'] ?? '',
      receiptNumber: json['receiptNumber'] ?? '',
      pdfUrl: json['pdfUrl'] ?? '',
      pdfKey: json['pdfKey'] ?? '',
    );
  }
}
