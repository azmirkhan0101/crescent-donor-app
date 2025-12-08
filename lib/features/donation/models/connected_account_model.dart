/*
{
    "success": true,
    "message": "Bank accounts retrieved successfully",
    "data": [
        {
            "_id": "692c146d4d94eae1f4186b96",
            "user": "692c04f5fbf9aeae92a61dad",
            "itemId": "4DLWzzl8NDHAVV9BKZreiLQjXvlX5ncdnaolx",
            "accountId": "4DLWzzl8NDHAVV9BKZreiLQBvPNGjRClojnAb",
            "accountName": "Plaid Checking",
            "accountType": "checking",
            "institutionName": "Citibank Online",
            "institutionId": "ins_5",
            "consentGivenAt": "2025-11-30T09:54:53.366Z",
            "isActive": true,
            "createdAt": "2025-11-30T09:54:53.371Z",
            "updatedAt": "2025-12-08T06:00:02.329Z",
            "__v": 0,
            "lastSyncAt": "2025-12-08T06:00:02.321Z",
            "lastSyncCursor": "CAESJWRCRXpra1FWdkJVUEFBZW05bkdOU0pXQTVrYXBBUGlsUnhvS2EaDAicqbDJBhD49dSVASIMCJypsMkGEPj11JUBKgwInKmwyQYQ+PXUlQE=",
            "isLinkedToActiveRoundUp": true,
            "activeRoundUpId": "692c14854d94eae1f4186ba2",
            "roundUpDetails": {
                "roundUpId": "692c14854d94eae1f4186ba2",
                "monthlyThreshold": 4.41,
                "currentMonthTotal": 0,
                "organization": "692c06cffbf9aeae92a61de1",
                "organizationName": "sdfsdfg",
                "cause": "692c082d15f3fb5a0bb29cb2",
                "causeName": "backpacks and books",
                "status": "pending",
                "enabled": true,
                "isTaxable": true
            }
        }
    ],
    "meta": {
        "page": 1,
        "limit": 10,
        "total": 1,
        "totalPage": 1
    }
}
*/

class BankAccountModel {
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
  String createdAt;
  String updatedAt;
  int v;
  String? lastSyncAt;
  String? lastSyncCursor;
  bool isLinkedToActiveRoundUp;
  String? activeRoundUpId;
  RoundedUpDetails? roundUpDetails;

  BankAccountModel({
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
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.lastSyncAt,
    this.lastSyncCursor,
    required this.isLinkedToActiveRoundUp,
    this.activeRoundUpId,
    this.roundUpDetails,
  });

  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    return BankAccountModel(
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
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: json['__v'] as int,
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
