/// Round-Up Configuration Model
///
/// Represents the user's round-up donation configuration including
/// organization, cause, bank, and payment method details
class RoundupConfigModel {
  final String id;
  final String user;
  final bool? coverFees;
  final double? monthlyThreshold;
  final String? specialMessage;
  final String? status;
  final bool? isActive;
  final String? organizationId;
  final String? organizationName;
  final String? organizationLogo;
  final String? organizationCover;
  final String? registeredCharityName;
  final String? causeId;
  final String? causeName;
  final String? causeCategory;
  final String? causeStatus;
  final String? bankConnectionId;
  final String? bankAccountId;
  final String? bankAccountType;
  final String? institutionName;
  final String? institutionId;
  final bool? bankIsActive;
  final String? paymentMethodId;
  final String? stripePaymentMethodId;
  final String? cardBrand;
  final String? cardLast4;
  final int? cardExpMonth;
  final int? cardExpYear;

  RoundupConfigModel({
    required this.id,
    required this.user,
    this.coverFees,
    this.monthlyThreshold,
    this.specialMessage,
    this.status,
    this.isActive,
    this.organizationId,
    this.organizationName,
    this.organizationLogo,
    this.organizationCover,
    this.registeredCharityName,
    this.causeId,
    this.causeName,
    this.causeCategory,
    this.causeStatus,
    this.bankConnectionId,
    this.bankAccountId,
    this.bankAccountType,
    this.institutionName,
    this.institutionId,
    this.bankIsActive,
    this.paymentMethodId,
    this.stripePaymentMethodId,
    this.cardBrand,
    this.cardLast4,
    this.cardExpMonth,
    this.cardExpYear,
  });

  factory RoundupConfigModel.fromJson(Map<String, dynamic> json) {
    return RoundupConfigModel(
      id: _safeString(json['_id']) ?? '',
      user: _safeString(json['user']) ?? '',
      coverFees: json['coverFees'] as bool?,
      monthlyThreshold: (json['monthlyThreshold'] as num?)?.toDouble(),
      specialMessage: _safeString(json['specialMessage']),
      status: _safeString(json['status']),
      isActive: json['isActive'] as bool?,
      organizationId: _safeString(json['organizationId']),
      organizationName: _safeString(json['organizationName']),
      organizationLogo: _safeString(json['organizationLogo']),
      organizationCover: _safeString(json['organizationCover']),
      registeredCharityName: _safeString(json['registeredCharityName']),
      causeId: _safeString(json['causeId']),
      causeName: _safeString(json['causeName']),
      causeCategory: _safeString(json['causeCategory']),
      causeStatus: _safeString(json['causeStatus']),
      bankConnectionId: _safeString(json['bankConnectionId']),
      bankAccountId: _safeString(json['bankAccountId']),
      bankAccountType: _safeString(json['bankAccountType']),
      institutionName: _safeString(json['institutionName']),
      institutionId: _safeString(json['institutionId']),
      bankIsActive: json['bankIsActive'] as bool?,
      paymentMethodId: _safeString(json['paymentMethodId']),
      stripePaymentMethodId: _safeString(json['stripePaymentMethodId']),
      cardBrand: _safeString(json['cardBrand']),
      cardLast4: _safeString(json['cardLast4']),
      cardExpMonth: json['cardExpMonth'] as int?,
      cardExpYear: json['cardExpYear'] as int?,
    );
  }

  /// Safe string conversion that handles null and empty values
  static String? _safeString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.isEmpty ? null : value;
    return value.toString();
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
  bool get isActiveAndVerified => (isActive ?? false) && status == 'verified';

  /// Get formatted card number (e.g., "**** 1881")
  String get formattedCardNumber => '**** ${cardLast4 ?? ''}';

  /// Get formatted expiry date (e.g., "02/29")
  String get formattedExpiry {
    if (cardExpMonth == null || cardExpYear == null) return '';
    return '${cardExpMonth.toString().padLeft(2, '0')}/${cardExpYear.toString().substring(2)}';
  }

  /// Check if card is expired
  bool get isCardExpired {
    if (cardExpMonth == null || cardExpYear == null) return false;
    final now = DateTime.now();
    final expiryDate = DateTime(cardExpYear!, cardExpMonth! + 1, 0);
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
