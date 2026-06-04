
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
