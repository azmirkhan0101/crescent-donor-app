/*
{
    "success": true,
    "message": "User dashboard retrieved successfully",
    "data": {
        "hasRoundUp": true,
        "config": {
            "_id": "6943cddf951d713ff3a72006",
            "user": "6942d044af3e0d14a9fdf55d",
            "organization": "6942d3bfaf3e0d14a9fdf599",
            "cause": "6943896c2f333b75a39823c3",
            "bankConnection": "6943cda0951d713ff3a71ffc",
            "paymentMethod": "6943ca35951d713ff3a71f3d",
            "coverFees": true,
            "monthlyThreshold": 4.41,
            "specialMessage": "My automatic round-up donation!",
            "status": "pending",
            "isActive": true,
            "enabled": true,
            "totalAccumulated": 4.41,
            "currentMonthTotal": 0,
            "lastMonthReset": "2025-12-18T09:48:41.603Z",
            "createdAt": "2025-12-18T09:48:15.546Z",
            "updatedAt": "2025-12-18T09:48:42.695Z",
            "__v": 0,
            "lastDonationAttempt": "2025-12-18T09:48:40.505Z",
            "lastSuccessfulDonation": "2025-12-18T09:48:41.603Z",
            "isThresholdMet": false,
            "daysSinceLastCharitySwitch": null,
            "id": "6943cddf951d713ff3a72006"
        },
        "stats": {
            "totalDonated": 8.82,
            "totalRoundUps": 14,
            "monthsDonated": 0,
            "currentMonthTotal": 3.74,
            "currentCharity": {
                "name": "ALFALAH CATIRY - Backpack and Education",
                "totalFromUser": 8.82
            }
        },
        "bankConnection": {
            "_id": "6943cda0951d713ff3a71ffc",
            "user": "6942d044af3e0d14a9fdf55d",
            "itemId": "KQDlPwQmkpFa8wQXDwDkH8BavJelW1iV6Jjb1",
            "accountId": "zqXDzBqbKnt81lpaPlPDF5RWQD1QLBFldVRJz",
            "accountName": "Plaid Checking",
            "accountType": "checking",
            "institutionName": "Citibank Online",
            "institutionId": "ins_5",
            "consentGivenAt": "2025-12-18T09:47:12.834Z",
            "isActive": true,
            "createdAt": "2025-12-18T09:47:12.839Z",
            "updatedAt": "2025-12-21T04:00:01.853Z",
            "__v": 0,
            "lastSyncAt": "2025-12-21T04:00:01.852Z",
            "lastSyncCursor": "CAESJTZXRTl2Slc3bG9pZVYxa21vMW9KVTdkZ045Qm1hTGg4d0xrcmoaDAj1m4/KBhCozLmTASIMCPWbj8oGEKjMuZMBKgwI9ZuPygYQqMy5kwE="
        },
        "organization": {
            "_id": "6942d3bfaf3e0d14a9fdf599",
            "auth": "6942d3bfaf3e0d14a9fdf597",
            "name": "ALFALAH CATIRY",
            "serviceType": "non-profit",
            "address": "42 Charity Lane, Sydney",
            "state": "NSW",
            "postalCode": "2000",
            "website": "https://specialorg.example.com",
            "phoneNumber": "+61412345678",
            "coverImage": null,
            "logoImage": null,
            "tfnOrAbnNumber": "98765432101",
            "zakatLicenseHolderNumber": "ZAK-2023-001",
            "country": "",
            "aboutUs": "",
            "dateOfEstablishment": "2025-12-17T15:44:34.985Z",
            "registeredCharityName": "",
            "isProfileVisible": true,
            "createdAt": "2025-12-17T16:01:03.871Z",
            "updatedAt": "2025-12-17T16:01:03.871Z",
            "__v": 0,
            "id": "6942d3bfaf3e0d14a9fdf599"
        },
        "cause": {
            "_id": "6943896c2f333b75a39823c3",
            "name": "Backpack and Education",
            "description": "Providing quality education to underprivileged children around the world",
            "category": "education",
            "status": "verified",
            "organization": "6942d3bfaf3e0d14a9fdf599",
            "createdAt": "2025-12-18T04:56:12.457Z",
            "updatedAt": "2025-12-18T04:56:12.457Z"
        }
    }
}
*/

class RoundUpDashboardModel {
  final bool hasRoundUp;
  final RoundUpConfig? config;
  final RoundUpStats stats;
  final BankConnection bankConnection;
  final Organization organization;
  final Cause cause;

  RoundUpDashboardModel({
    required this.hasRoundUp,
    required this.config,
    required this.stats,
    required this.bankConnection,
    required this.organization,
    required this.cause,
  });

  factory RoundUpDashboardModel.fromJson(Map<String, dynamic> json) {
    return RoundUpDashboardModel(
      hasRoundUp: json['hasRoundUp'] as bool,
      config: json['config'] != null
          ? RoundUpConfig.fromJson(json['config'] as Map<String, dynamic>)
          : null,
      stats: RoundUpStats.fromJson(json['stats'] as Map<String, dynamic>),
      bankConnection: BankConnection.fromJson(
        json['bankConnection'] as Map<String, dynamic>,
      ),
      organization: Organization.fromJson(
        json['organization'] as Map<String, dynamic>,
      ),
      cause: Cause.fromJson(json['cause'] as Map<String, dynamic>),
    );
  }
}

class RoundUpConfig {
  final String id;
  final String bankConnectionId;
  final String organizationId;
  final String? causeId;
  final String paymentMethodId;
  final bool coverFees;
  final double monthlyThreshold;
  final String specialMessage;
  final bool isActive;
  final bool enabled;
  final double totalAccumulated;
  final double currentMonthTotal;
  final DateTime lastMonthReset;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastDonationAttempt;
  final DateTime? lastSuccessfulDonation;
  final bool isThresholdMet;
  final int? daysSinceLastCharitySwitch;

  RoundUpConfig({
    required this.id,
    required this.bankConnectionId,
    required this.organizationId,
    this.causeId,
    required this.paymentMethodId,
    required this.coverFees,
    required this.monthlyThreshold,
    required this.specialMessage,
    required this.isActive,
    required this.enabled,
    required this.totalAccumulated,
    required this.currentMonthTotal,
    required this.lastMonthReset,
    required this.createdAt,
    required this.updatedAt,
    this.lastDonationAttempt,
    this.lastSuccessfulDonation,
    required this.isThresholdMet,
    this.daysSinceLastCharitySwitch,
  });

  factory RoundUpConfig.fromJson(Map<String, dynamic> json) {
    return RoundUpConfig(
      id: json['id'] as String,
      bankConnectionId: json['bankConnectionId'] as String,
      organizationId: json['organizationId'] as String,
      causeId: json['causeId'] as String?,
      paymentMethodId: json['paymentMethod'] as String,
      coverFees: json['coverFees'] as bool,
      monthlyThreshold: (json['monthlyThreshold'] as num).toDouble(),
      specialMessage: json['specialMessage'] as String,
      isActive: json['isActive'] as bool,
      enabled: json['enabled'] as bool,
      totalAccumulated: (json['totalAccumulated'] as num).toDouble(),
      currentMonthTotal: (json['currentMonthTotal'] as num).toDouble(),
      lastMonthReset: DateTime.parse(json['lastMonthReset'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      lastDonationAttempt: json['lastDonationAttempt'] != null
          ? DateTime.parse(json['lastDonationAttempt'] as String)
          : null,
      lastSuccessfulDonation: json['lastSuccessfulDonation'] != null
          ? DateTime.parse(json['lastSuccessfulDonation'] as String)
          : null,
      isThresholdMet: json['isThresholdMet'] as bool,
      daysSinceLastCharitySwitch: json['daysSinceLastCharitySwitch'] as int?,
    );
  }
}

class RoundUpStats {
  final double totalDonated;
  final int totalRoundUps;
  final int monthsDonated;
  final double currentMonthTotal;
  final CharitySummary currentCharity;

  RoundUpStats({
    required this.totalDonated,
    required this.totalRoundUps,
    required this.monthsDonated,
    required this.currentMonthTotal,
    required this.currentCharity,
  });

  factory RoundUpStats.fromJson(Map<String, dynamic> json) {
    return RoundUpStats(
      totalDonated: (json['totalDonated'] as num).toDouble(),
      totalRoundUps: json['totalRoundUps'] as int,
      monthsDonated: json['monthsDonated'] as int,
      currentMonthTotal: (json['currentMonthTotal'] as num).toDouble(),
      currentCharity: CharitySummary.fromJson(
        json['currentCharity'] as Map<String, dynamic>,
      ),
    );
  }
}

class CharitySummary {
  final String name;
  final double totalFromUser;

  CharitySummary({required this.name, required this.totalFromUser});

  factory CharitySummary.fromJson(Map<String, dynamic> json) {
    return CharitySummary(
      name: json['name'] as String,
      totalFromUser: (json['totalFromUser'] as num).toDouble(),
    );
  }
}

class BankConnection {
  final String id;
  final String accountName;
  final String accountType;
  final String institutionName;

  BankConnection({
    required this.id,
    required this.accountName,
    required this.accountType,
    required this.institutionName,
  });

  factory BankConnection.fromJson(Map<String, dynamic> json) {
    return BankConnection(
      id: json['_id'] as String,
      accountName: json['accountName'] as String,
      accountType: json['accountType'] as String,
      institutionName: json['institutionName'] as String,
    );
  }
}

class Organization {
  final String id;
  final String name;

  Organization({required this.id, required this.name});

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['_id'] as String,
      name: json['name'] as String,
    );
  }
}

class Cause {
  final String id;
  final String name;
  final String description;

  Cause({required this.id, required this.name, required this.description});

  factory Cause.fromJson(Map<String, dynamic> json) {
    return Cause(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}
