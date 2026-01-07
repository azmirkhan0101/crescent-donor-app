/*
{
    "_id": "694148d8a4532242abd6ad7f",
    "user": "694118ddaee83632dca37e08",
    "itemId": "vQlDV8rQAXHwvn55G6W9TVLMVwqANMtWqxw85",
    "accountId": "JXVxe7GX9LtWyELL7aJzUvDkkrqWWqcQyvadP",
    "accountName": "Plaid Checking",
    "accountType": "checking",
    "institutionName": "Citibank Online",
    "institutionId": "ins_5",
    "consentGivenAt": "2025-12-16T11:56:08.106Z",
    "isActive": true,
    "provider": "basiq",
    "createdAt": "2025-12-16T11:56:08.115Z",
    "updatedAt": "2025-12-20T08:00:02.351Z",
    "__v": 0,
    "lastSyncAt": "2025-12-20T08:00:02.349Z",
    "lastSyncCursor": "CAESJTlYNjduOXZYS3J0V1A5dnZ4WEtMVUdMb0tkalJOakY0b1c1cVoaDAjDkoXKBhDIkpfBAiIMCMOShcoGEMiSl8ECKgwIw5KFygYQyJKXwQI=",
    "isLinkedToActiveRoundUp": true,
    "activeRoundUpId": "69414923a4532242abd6ad89",
    "roundUpDetails": {
        "roundUpId": "69414923a4532242abd6ad89",
        "monthlyThreshold": 4.41,
        "currentMonthTotal": 0,
        "organization": "69411a87aee83632dca37e54",
        "organizationName": "Test ORG",
        "cause": "69412fbeeaa7c8a7c9ca04b7",
        "causeName": "Test",
        "status": "pending",
        "enabled": true,
        
        "isTaxable": false
    }
}
*/

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
