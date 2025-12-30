/*
{
    "success": true,
    "message": "Basiq Accounts retrieved successfully",
    "data": [
        {
            "provider": "basiq",
            "accountId": "fb956eb9-e26b-4620-9bf9-44efa6626227",
            "accountName": "Credit Card 13000",
            "accountType": "credit-card",
            "institutionId": "AU00000",
            "institutionName": "Hooli Visa (Basiq)"
        },
        {
            "provider": "basiq",
            "accountId": "ba8198f5-7d64-4765-a8d4-c001379bf192",
            "accountName": "Savings 123890",
            "accountType": "savings",
            "institutionId": "AU00000",
            "institutionName": "Hooli Saver (Basiq)"
        },
        {
            "provider": "basiq",
            "accountId": "fcce8a93-011f-4a2c-99b6-ab84ded97b68",
            "accountName": "Transaction 14000",
            "accountType": "transaction",
            "institutionId": "AU00000",
            "institutionName": "Hooli Transaction (Basiq)"
        }
    ]
}


        {
            "provider": "basiq",
            "accountId": "4dbed758-6509-466d-bd7e-eaa5232b8f9d",
            "accountName": "Credit Card 13000",
            "accountType": "credit-card",
            "institutionId": "AU00000",
            "institutionName": "Hooli Visa (Basiq)",
            "connectionId": "6fe53c8c-4628-4b58-b6b5-77b3c07dd7bf"
        }
*/
class BasiqAccount {
  final String provider;
  final String accountId;
  final String accountName;
  final String accountType;
  final String institutionId;
  final String institutionName;
  final String connectionId;

  BasiqAccount({
    required this.provider,
    required this.accountId,
    required this.accountName,
    required this.accountType,
    required this.institutionId,
    required this.institutionName,
    required this.connectionId,
  });

  factory BasiqAccount.fromJson(Map<String, dynamic> json) {
    return BasiqAccount(
      provider: json['provider'] ?? '',
      accountId: json['accountId'] ?? '',
      accountName: json['accountName'] ?? '',
      accountType: json['accountType'] ?? '',
      institutionId: json['institutionId'] ?? '',
      institutionName: json['institutionName'] ?? '',
      connectionId: json['connectionId'] ?? '',
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'accountId': accountId,
      'accountName': accountName,
      'accountType': accountType,
      'institutionId': institutionId,
      'institutionName': institutionName,
      'connectionId': connectionId,
    };
  }
}
