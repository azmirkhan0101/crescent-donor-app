
class ClaimRewardModel {
  final Redemption redemption;
  final String code;
  final List<String> availableMethods;
  final bool isRetry;

  ClaimRewardModel({
    required this.redemption,
    required this.code,
    required this.availableMethods,
    required this.isRetry,
  });

  factory ClaimRewardModel.fromJson(Map<String, dynamic> json) {
    return ClaimRewardModel(
      redemption: Redemption.fromJson(json['redemption']),
      code: json['code'],
      availableMethods: List<String>.from(json['availableMethods']),
      isRetry: json['isRetry'],
    );
  }
}

class Redemption {
  final String user;
  final Reward reward;
  final Business business;
  final int pointsSpent;
  final String status;
  final String assignedCode;
  final List<String> availableRedemptionMethods;
  final DateTime expiresAt;
  final String idempotencyKey;
  final String id;
  final DateTime claimedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Redemption({
    required this.user,
    required this.reward,
    required this.business,
    required this.pointsSpent,
    required this.status,
    required this.assignedCode,
    required this.availableRedemptionMethods,
    required this.expiresAt,
    required this.idempotencyKey,
    required this.id,
    required this.claimedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Redemption.fromJson(Map<String, dynamic> json) {
    return Redemption(
      user: json['user'],
      reward: Reward.fromJson(json['reward']),
      business: Business.fromJson(json['business']),
      pointsSpent: json['pointsSpent'],
      status: json['status'],
      assignedCode: json['assignedCode'],
      availableRedemptionMethods:
          List<String>.from(json['availableRedemptionMethods']),
      expiresAt: DateTime.parse(json['expiresAt']),
      idempotencyKey: json['idempotencyKey'],
      id: json['_id'],
      claimedAt: DateTime.parse(json['claimedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Reward {
  final String id;
  final String title;
  final String description;
  final String type;
  final String category;

  Reward({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      category: json['category'],
    );
  }
}

class Business {
  final String id;
  final String name;
  final List<String> locations;

  Business({
    required this.id,
    required this.name,
    required this.locations,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['_id'],
      name: json['name'],
      locations: List<String>.from(json['locations']),
    );
  }
}