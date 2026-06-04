
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
