/*
{
    "success": true,
    "message": "Reward claimed successfully! Your points have been deducted.",
    "data": {
        "redemption": {
            "user": "69301feaddbf3fdf987e86e8",
            "reward": {
                "_id": "6936d61243232039a271a5f3",
                "title": "Free Tea",
                "description": "Get a free coffee with any purchase above $10",
                "type": "in-store",
                "category": "food"
            },
            "business": {
                "_id": "6936d5e943232039a271a5ea",
                "name": "TechMart BD",
                "locations": [
                    "Dhaka",
                    "Chattogram",
                    "Sylhet"
                ]
            },
            "pointsSpent": 500,
            "status": "claimed",
            "assignedCode": "698929DDD596",
            "availableRedemptionMethods": [
                "qr",
                "static-code",
                "nfc"
            ],
            "expiresAt": "2026-01-07T16:21:20.917Z",
            "idempotencyKey": "df325cb190dc276a8484544264c398fb",
            "_id": "6936fb00af5237d44d7883ce",
            "claimedAt": "2025-12-08T16:21:20.918Z",
            "createdAt": "2025-12-08T16:21:20.919Z",
            "updatedAt": "2025-12-08T16:21:20.919Z"
        },
        "code": "698929DDD596",
        "availableMethods": [
            "qr",
            "static-code",
            "nfc"
        ],
        "isRetry": false
    }
}
*/

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