
class RoundUpBankConnectionModel {
  String id;
  String user;
  String itemId;
  String accountId;
  String accountName;
  String accountType;
  String institutionName;
  String institutionId;
  String consentGivenAt;
  bool isActive;
  String provider;
  String createdAt;
  String updatedAt;
  String? lastSyncAt;
  String? lastSyncCursor;
  bool isLinkedToActiveRoundUp;
  String? activeRoundUpId;
  RoundedUpDetails? roundUpDetails;

  RoundUpBankConnectionModel({
    required this.id,
    required this.user,
    required this.itemId,
    required this.accountId,
    required this.accountName,
    required this.accountType,
    required this.institutionName,
    required this.institutionId,
    required this.consentGivenAt,
    required this.isActive,
    required this.provider,
    required this.createdAt,
    required this.updatedAt,
    this.lastSyncAt,
    this.lastSyncCursor,
    required this.isLinkedToActiveRoundUp,
    this.activeRoundUpId,
    this.roundUpDetails,
  });

  factory RoundUpBankConnectionModel.fromJson(Map<String, dynamic> json) {
    return RoundUpBankConnectionModel(
      id: json['_id'] as String,
      user: json['user'] as String,
      itemId: json['itemId'] as String,
      accountId: json['accountId'] as String,
      accountName: json['accountName'] as String,
      accountType: json['accountType'] as String,
      institutionName: json['institutionName'] as String,
      institutionId: json['institutionId'] as String,
      consentGivenAt: json['consentGivenAt'] as String,
      isActive: json['isActive'] as bool,
      provider: json['provider'] ?? '',
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      lastSyncAt: json['lastSyncAt'] as String?,
      lastSyncCursor: json['lastSyncCursor'] as String?,
      isLinkedToActiveRoundUp: json['isLinkedToActiveRoundUp'] as bool,
      activeRoundUpId: json['activeRoundUpId'] as String?,
      roundUpDetails: json['roundUpDetails'] != null
          ? RoundedUpDetails.fromJson(
              json['roundUpDetails'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class RoundedUpDetails {
  String roundUpId;
  double monthlyThreshold;
  double currentMonthTotal;
  String organization;
  String organizationName;
  String cause;
  String causeName;
  String status;
  bool enabled;
  bool isTaxable;

  RoundedUpDetails({
    required this.roundUpId,
    required this.monthlyThreshold,
    required this.currentMonthTotal,
    required this.organization,
    required this.organizationName,
    required this.cause,
    required this.causeName,
    required this.status,
    required this.enabled,
    required this.isTaxable,
  });

  factory RoundedUpDetails.fromJson(Map<String, dynamic> json) {
    return RoundedUpDetails(
      roundUpId: json['roundUpId'] as String,
      monthlyThreshold: (json['monthlyThreshold'] as num).toDouble(),
      currentMonthTotal: (json['currentMonthTotal'] as num).toDouble(),
      organization: json['organization'] as String,
      organizationName: json['organizationName'] as String,
      cause: json['cause'] as String,
      causeName: json['causeName'] as String,
      status: json['status'] as String,
      enabled: json['enabled'] as bool,
      isTaxable: json['isTaxable'] as bool,
    );
  }
}
