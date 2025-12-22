/// Round-Up Configuration Model
///
/// Represents the user's round-up donation configuration including
/// organization, cause, bank, and payment method details
class RoundupConfigModel {
  final String id;
  final String user;
  final bool coverFees;
  final double monthlyThreshold;
  final String specialMessage;
  final String status;
  final bool isActive;
  final String organizationId;
  final String organizationName;
  final String? organizationLogo;
  final String? organizationCover;
  final String registeredCharityName;
  final String causeId;
  final String causeName;
  final String causeCategory;
  final String causeStatus;
  final String bankConnectionId;
  final String bankAccountId;
  final String bankAccountType;
  final String institutionName;
  final String institutionId;
  final bool bankIsActive;
  final String paymentMethodId;
  final String stripePaymentMethodId;
  final String cardBrand;
  final String cardLast4;
  final int cardExpMonth;
  final int cardExpYear;

  RoundupConfigModel({
    required this.id,
    required this.user,
    required this.coverFees,
    required this.monthlyThreshold,
    required this.specialMessage,
    required this.status,
    required this.isActive,
    required this.organizationId,
    required this.organizationName,
    this.organizationLogo,
    this.organizationCover,
    required this.registeredCharityName,
    required this.causeId,
    required this.causeName,
    required this.causeCategory,
    required this.causeStatus,
    required this.bankConnectionId,
    required this.bankAccountId,
    required this.bankAccountType,
    required this.institutionName,
    required this.institutionId,
    required this.bankIsActive,
    required this.paymentMethodId,
    required this.stripePaymentMethodId,
    required this.cardBrand,
    required this.cardLast4,
    required this.cardExpMonth,
    required this.cardExpYear,
  });

  factory RoundupConfigModel.fromJson(Map<String, dynamic> json) {
    return RoundupConfigModel(
      id: json['_id'] as String,
      user: json['user'] as String,
      coverFees: json['coverFees'] as bool,
      monthlyThreshold: (json['monthlyThreshold'] as num).toDouble(),
      specialMessage: json['specialMessage'] as String,
      status: json['status'] as String,
      isActive: json['isActive'] as bool,
      organizationId: json['organizationId'] as String,
      organizationName: json['organizationName'] as String,
      organizationLogo: json['organizationLogo'] as String?,
      organizationCover: json['organizationCover'] as String?,
      registeredCharityName: json['registeredCharityName'] as String,
      causeId: json['causeId'] as String,
      causeName: json['causeName'] as String,
      causeCategory: json['causeCategory'] as String,
      causeStatus: json['causeStatus'] as String,
      bankConnectionId: json['bankConnectionId'] as String,
      bankAccountId: json['bankAccountId'] as String,
      bankAccountType: json['bankAccountType'] as String,
      institutionName: json['institutionName'] as String,
      institutionId: json['institutionId'] as String,
      bankIsActive: json['bankIsActive'] as bool,
      paymentMethodId: json['paymentMethodId'] as String,
      stripePaymentMethodId: json['stripePaymentMethodId'] as String,
      cardBrand: json['cardBrand'] as String,
      cardLast4: json['cardLast4'] as String,
      cardExpMonth: json['cardExpMonth'] as int,
      cardExpYear: json['cardExpYear'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'coverFees': coverFees,
      'monthlyThreshold': monthlyThreshold,
      'specialMessage': specialMessage,
      'status': status,
      'isActive': isActive,
      'organizationId': organizationId,
      'organizationName': organizationName,
      'organizationLogo': organizationLogo,
      'organizationCover': organizationCover,
      'registeredCharityName': registeredCharityName,
      'causeId': causeId,
      'causeName': causeName,
      'causeCategory': causeCategory,
      'causeStatus': causeStatus,
      'bankConnectionId': bankConnectionId,
      'bankAccountId': bankAccountId,
      'bankAccountType': bankAccountType,
      'institutionName': institutionName,
      'institutionId': institutionId,
      'bankIsActive': bankIsActive,
      'paymentMethodId': paymentMethodId,
      'stripePaymentMethodId': stripePaymentMethodId,
      'cardBrand': cardBrand,
      'cardLast4': cardLast4,
      'cardExpMonth': cardExpMonth,
      'cardExpYear': cardExpYear,
    };
  }

  /// Check if round-up is active and verified
  bool get isActiveAndVerified => isActive && status == 'verified';

  /// Get formatted card number (e.g., "**** 1881")
  String get formattedCardNumber => '**** $cardLast4';

  /// Get formatted expiry date (e.g., "02/29")
  String get formattedExpiry =>
      '${cardExpMonth.toString().padLeft(2, '0')}/${cardExpYear.toString().substring(2)}';

  /// Check if card is expired
  bool get isCardExpired {
    final now = DateTime.now();
    final expiryDate = DateTime(cardExpYear, cardExpMonth + 1, 0);
    return now.isAfter(expiryDate);
  }
}

/// Round-Up Configuration Response Model
///
/// Wrapper for the API response containing round-up config data
class RoundupConfigResponse {
  final bool success;
  final String message;
  final RoundupConfigModel data;

  RoundupConfigResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RoundupConfigResponse.fromJson(Map<String, dynamic> json) {
    return RoundupConfigResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: RoundupConfigModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}
