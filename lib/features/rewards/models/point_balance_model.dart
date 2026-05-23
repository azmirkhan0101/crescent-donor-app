/*
{
    "success": true,
    "message": "Balance retrieved successfully",
    "data": {
        "_id": "693e38f96f1cfc4aede73b6b",
        "user": {
            "_id": "69301feaddbf3fdf987e86e8",
            "name": "Mostafizur",
            "image": "/images/scaled_18-1765684240320.jpg"
        },
        "totalEarned": 40500,
        "totalSpent": 0,
        "totalRefunded": 0,
        "totalAdjusted": 0,
        "totalExpired": 0,
        "currentBalance": 40500,
        "lifetimePoints": 40500,
        "currentTier": "silver",
        "createdAt": "2025-12-14T04:11:37.649Z",
        "updatedAt": "2025-12-14T05:16:02.857Z",
        "lastTransactionAt": "2025-12-14T05:16:02.857Z"
    }
}
*/

class PointBalanceModel {
  final String id;
  final User? user;
  final int? totalEarned;
  final int? totalSpent;
  final int? totalRefunded;
  final int? totalAdjusted;
  final int? totalExpired;
  final int? currentBalance;
  final int? lifetimePoints;
  final String? currentTier;
  final String? createdAt;
  final String? updatedAt;
  final String? lastTransactionAt;

  PointBalanceModel({
    required this.id,
    this.user,
    this.totalEarned,
    this.totalSpent,
    this.totalRefunded,
    this.totalAdjusted,
    this.totalExpired,
    this.currentBalance,
    this.lifetimePoints,
    this.currentTier,
    this.createdAt,
    this.updatedAt,
    this.lastTransactionAt,
  });

  factory PointBalanceModel.fromJson(Map<String, dynamic> json) {
    return PointBalanceModel(
      id: json['_id'] ?? '',
      user: (json['user'] != null && json['user'] is Map<String,dynamic>) ? User.fromJson(json['user']) : null,
      totalEarned: json['totalEarned'] ?? 0,
      totalSpent: json['totalSpent'] ?? 0,
      totalRefunded: json['totalRefunded'] ?? 0,
      totalAdjusted: json['totalAdjusted'] ?? 0,
      totalExpired: json['totalExpired'] ?? 0,
      currentBalance: json['currentBalance'] ?? 0,
      lifetimePoints: json['lifetimePoints'] ?? 0,
      currentTier: json['currentTier'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      lastTransactionAt: json['lastTransactionAt'] ?? '',
    );
  }
}

class User {
  final String id;
  final String? name;
  final String? image;

  User({required this.id, this.name, this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
