import 'package:cresent_charge_user_app/service/api_url.dart';

/*
{
    "success": true,
    "message": "Explore rewards retrieved successfully",
    "meta": {
        "page": 1,
        "limit": 10,
        "total": 1,
        "totalPage": 1
    },
    "data": [
        {
            "_id": "6936d61243232039a271a5f3",
            "business": {
                "_id": "6936d5e943232039a271a5ea",
                "name": "TechMart BD",
                "coverImage": "public/images/download-1765201385515.png"
            },
            "title": "Free Tea",
            "description": "Get a free coffee with any purchase above $10",
            "type": "in-store",
            "category": "food",
            "pointsCost": 500,
            "redemptionLimit": 2,
            "redeemedCount": 1,
            "remainingCount": 1,
            "startDate": "2025-11-29T00:00:00.000Z",
            "expiryDate": "2025-12-31T23:59:59.000Z",
            "status": "active",
            "isActive": true,
            "inStoreRedemptionMethods": {
                "qrCode": true,
                "staticCode": true,
                "nfcTap": true
            },
            "createdAt": "2025-12-08T13:43:46.660Z",
            "updatedAt": "2025-12-08T16:21:20.999Z",
            "userStatus": "claimed",
            "isAlreadyClaimed": true,
            "isAlreadyRedeemed": false
        }
    ]
}
*/
class RewardModel {
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
  final bool isAvailable;
  final bool userCanAfford;
  final String claimStatus;
  final String userStatus;
  final bool isAlreadyClaimed;
  final bool isAlreadyRedeemed;

  RewardModel({
    required this.id,
    this.business,
    required this.title,
    required this.description,
    this.image,
    required this.type,
    required this.category,
    required this.pointsCost,
    required this.redemptionLimit,
    required this.redeemedCount,
    required this.remainingCount,
    required this.startDate,
    this.expiryDate,
    required this.status,
    required this.isActive,
    this.inStoreRedemptionMethods,
    required this.featured,
    required this.priority,
    required this.views,
    required this.redemptions,
    this.limitUpdateHistory,
    required this.createdAt,
    required this.updatedAt,
    required this.isAvailable,
    required this.userCanAfford,
    required this.claimStatus,
    required this.userStatus,
    required this.isAlreadyClaimed,
    required this.isAlreadyRedeemed,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['_id'] ?? '',
      business: json['business'] != null
          ? PopulatedBusiness.fromJson(json['business'])
          : null,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      type: json['type'] ?? '',
      category: json['category'] ?? '',
      pointsCost: json['pointsCost'] ?? 0,
      redemptionLimit: json['redemptionLimit'] ?? 0,
      redeemedCount: json['redeemedCount'] ?? 0,
      remainingCount: json['remainingCount'] ?? 0,
      startDate: json['startDate'] ?? '',
      expiryDate: json['expiryDate'],
      status: json['status'] ?? '',
      isActive: json['isActive'] ?? false,
      inStoreRedemptionMethods: json['inStoreRedemptionMethods'] != null
          ? InStoreRedemptionMethods.fromJson(json['inStoreRedemptionMethods'])
          : null,
      featured: json['featured'] ?? false,
      priority: json['priority'] ?? 0,
      views: json['views'] ?? 0,
      redemptions: json['redemptions'] ?? 0,
      limitUpdateHistory: json['limitUpdateHistory'] as List<dynamic>?,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      isAvailable: json['isAvailable'] ?? false,
      userCanAfford: json['userCanAfford'] ?? false,
      claimStatus: json['claimStatus'] ?? '',
      userStatus: json['userStatus'] ?? '',
      isAlreadyClaimed: json['isAlreadyClaimed'] ?? false,
      isAlreadyRedeemed: json['isAlreadyRedeemed'] ?? false,
    );
  }
}

class PopulatedBusiness {
  final String id;
  final String name;
  final String? coverImage;

  PopulatedBusiness({required this.id, required this.name, this.coverImage});

  factory PopulatedBusiness.fromJson(Map<String, dynamic> json) {
    final rawCover = json['coverImage'] as String? ?? '';
    final resolvedCover = rawCover.isEmpty
        ? null
        : (rawCover.startsWith('http')
              ? rawCover
              : '${ApiUrl.imageBaseUrl}/$rawCover');
    return PopulatedBusiness(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      coverImage: resolvedCover,
    );
  }
}

class InStoreRedemptionMethods {
  final bool qrCode;
  final bool staticCode;
  final bool nfcTap;

  InStoreRedemptionMethods({
    required this.qrCode,
    required this.staticCode,
    required this.nfcTap,
  });

  factory InStoreRedemptionMethods.fromJson(Map<String, dynamic> json) {
    return InStoreRedemptionMethods(
      qrCode: json['qrCode'] ?? false,
      staticCode: json['staticCode'] ?? false,
      nfcTap: json['nfcTap'] ?? false,
    );
  }
}
