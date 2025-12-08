import 'package:cresent_charge_user_app/features/rewards/models/reward_model.dart';

class RewardDetailModel {
  final String id;
  final PopulatedBusiness? business;
  final String title;
  final String description;
  final String? image;
  final String type;
  final String category;
  final int pointsCost;
  final int redemptionLimit;
  final int redeemedCount;
  final int remainingCount;
  final String startDate;
  final String? expiryDate;
  final String status;
  final bool isActive;
  final InStoreRedemptionMethods? inStoreRedemptionMethods;
  final bool featured;
  final int priority;
  final int views;
  final int redemptions;
  final List<dynamic>? limitUpdateHistory;
  final String createdAt;
  final String updatedAt;
  final int availableCodesCount;
  final bool isAvailable;
  final bool userCanAfford;
  final int userBalance;
  final bool hasAlreadyClaimed;

  RewardDetailModel.fromJson(Map<String, dynamic> json)
    : id = json['_id'],
      business = json['business'] != null
          ? PopulatedBusiness.fromJson(json['business'])
          : null,
      title = json['title'],
      description = json['description'],
      image = json['image'],
      type = json['type'],
      category = json['category'],
      pointsCost = json['pointsCost'],
      redemptionLimit = json['redemptionLimit'],
      redeemedCount = json['redeemedCount'],
      remainingCount = json['remainingCount'],
      startDate = json['startDate'],
      expiryDate = json['expiryDate'],
      status = json['status'],
      isActive = json['isActive'],
      inStoreRedemptionMethods = json['inStoreRedemptionMethods'] != null
          ? InStoreRedemptionMethods.fromJson(json['inStoreRedemptionMethods'])
          : null,
      featured = json['featured'] ?? false,
      priority = json['priority'] ?? 0,
      views = json['views'] ?? 0,
      redemptions = json['redemptions'] ?? 0,
      limitUpdateHistory = json['limitUpdateHistory'],
      createdAt = json['createdAt'],
      updatedAt = json['updatedAt'],
      availableCodesCount = json['availableCodesCount'] ?? 0,
      isAvailable = json['isAvailable'] ?? false,
      userCanAfford = json['userCanAfford'] ?? false,
      userBalance = json['userBalance'] ?? 0,
      hasAlreadyClaimed = json['hasAlreadyClaimed'] ?? false;
}

class RewardDetailResponse {
  final bool success;
  final String message;
  final RewardDetailModel data;

  RewardDetailResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'],
      message = json['message'],
      data = RewardDetailModel.fromJson(json['data']);
}
