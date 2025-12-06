/*
{
    "success": true,
    "message": "Bank accounts retrieved successfully",
    "data": [
        {
            "_id": "692fd93bbf4bbb063bf9cc6b",
            "user": "692c2cc2a7a1e85346c2a3a3",
            "itemId": "4WnMKKwK5Ai11o5jBGwdUG3Xl1BLlvCd8GAy3",
            "accountId": "QLp9KKQKDRfBBxe81gwrT7kRZDkZmlcGkojMK",
            "accountName": "Plaid Checking",
            "accountType": "checking",
            "institutionName": "American Express",
            "institutionId": "ins_10",
            "consentGivenAt": "2025-12-03T06:31:23.338Z",
            "isActive": true,
            "createdAt": "2025-12-03T06:31:23.344Z",
            "updatedAt": "2025-12-03T06:31:23.344Z",
            "__v": 0,
            "isLinkedToActiveRoundUp": false
        },
        {
            "_id": "692eb29b6e3ca62750bb5d26",
            "user": "692c2cc2a7a1e85346c2a3a3",
            "itemId": "GaXvyb7o1bT77LmPyN89cwQkP96MbrU16djMX",
            "accountId": "Q1ywXQ8mnQhWWLK91dJqFNnKzAJkLJFwVejJM",
            "accountName": "Plaid Checking",
            "accountType": "checking",
            "institutionName": "Chase",
            "institutionId": "ins_56",
            "consentGivenAt": "2025-12-02T09:34:19.300Z",
            "isActive": true,
            "createdAt": "2025-12-02T09:34:19.313Z",
            "updatedAt": "2025-12-02T09:34:19.313Z",
            "__v": 0,
            "isLinkedToActiveRoundUp": false
        },
        {
            "_id": "692d747e6141d6d05104754f",
            "user": "692c2cc2a7a1e85346c2a3a3",
            "itemId": "olLarRrebXfQPaGevdRkIM1Am3olo6HRrqWlV",
            "accountId": "Rz1nrerpBVtg4DQxRW7dTEy5Pw4WpNiZK1gvV",
            "accountName": "Plaid Checking",
            "accountType": "checking",
            "institutionName": "Citibank Online",
            "institutionId": "ins_5",
            "consentGivenAt": "2025-12-01T10:57:02.045Z",
            "isActive": true,
            "createdAt": "2025-12-01T10:57:02.053Z",
            "updatedAt": "2025-12-01T10:57:02.053Z",
            "__v": 0,
            "isLinkedToActiveRoundUp": false
        }
    ],
    "meta": {
        "page": 1,
        "limit": 10,
        "total": 3,
        "totalPage": 1
    }
}
*/

class BankAccountModel {
  final String id;
  final String user;
  final String itemId;
  final String accountId;
  final String accountName;
  final String accountType;
  final String institutionName;
  final String institutionId;
  final String consentGivenAt;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final bool? isLinkedToActiveRoundUp;

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
    this.isLinkedToActiveRoundUp,
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
      isLinkedToActiveRoundUp:
          json['isLinkedToActiveRoundUp'] as bool? ?? false,
    );
  }
}
