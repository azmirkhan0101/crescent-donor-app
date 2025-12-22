/*
{
    "success": true,
    "message": "Reward retrieved successfully",
    "data": {
        "_id": "69465f9ce44cbeb3cdce05d2",
        "business": {
            "_id": "69465d27db997dd46e7d5ff2",
            "category": "Electronics",
            "name": "TechMart BD",
            "businessPhoneNumber": "+8801712345678",
            "businessEmail": "contact@techmartbd.com",
            "locations": [
                "Dhaka",
                "Chattogram",
                "Sylhet"
            ]
        },
        "title": "Free Tea",
        "description": "Get a free coffee with any purchase above $10",
        "type": "in-store",
        "category": "food",
        "pointsCost": 500,
        "redemptionLimit": 10,
        "redeemedCount": 1,
        "remainingCount": 9,
        "startDate": "2025-11-29T00:00:00.000Z",
        "expiryDate": "2025-12-31T23:59:59.000Z",
        "status": "active",
        "isActive": true,
        "inStoreRedemptionMethods": {
            "qrCode": true,
            "staticCode": true,
            "nfcTap": false
        },
        "codePrefix": "RWDD2A3",
        "featured": true,
        "priority": 10,
        "redemptions": 1,
        "limitUpdateHistory": [],
        "createdAt": "2025-12-20T08:34:36.207Z",
        "updatedAt": "2025-12-21T09:50:41.275Z",
        "availableCodesCount": 9,
        "isAvailable": true,
        "userCanAfford": false,
        "userBalance": 0,
        "hasAlreadyClaimed": false
    }
}
*/

class RewardDetailsModel {
  final String id;
  final Business business;
  final String title;
  final String description;
  final String type;
  final String category;
  final int pointsCost;
  final int redemptionLimit;
  final int redeemedCount;
  final int remainingCount;
  final String startDate;
  final String expiryDate;
  final String status;
  final bool isActive;
  final InStoreRedemptionMethods inStoreRedemptionMethods;
  final String codePrefix;
  final bool featured;
  final int priority;
  final int redemptions;
  final List<dynamic> limitUpdateHistory;
  final String createdAt;
  final String updatedAt;
  final int availableCodesCount;
  final bool isAvailable;
  final bool userCanAfford;
  final int userBalance;
  final bool hasAlreadyClaimed;
  RewardDetailsModel({
    required this.id,
    required this.business,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.pointsCost,
    required this.redemptionLimit,
    required this.redeemedCount,
    required this.remainingCount,
    required this.startDate,
    required this.expiryDate,
    required this.status,
    required this.isActive,
    required this.inStoreRedemptionMethods,
    required this.codePrefix,
    required this.featured,
    required this.priority,
    required this.redemptions,
    required this.limitUpdateHistory,
    required this.createdAt,
    required this.updatedAt,
    required this.availableCodesCount,
    required this.isAvailable,
    required this.userCanAfford,
    required this.userBalance,
    required this.hasAlreadyClaimed,
  });

  factory RewardDetailsModel.fromJson(Map<String, dynamic> json) {
    return RewardDetailsModel(
      id: json['_id'] ?? '',
      business: Business.fromJson(json['business']),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      category: json['category'] ?? '',
      pointsCost: json['pointsCost'] ?? 0,
      redemptionLimit: json['redemptionLimit'] ?? 0,
      redeemedCount: json['redeemedCount'] ?? 0,
      remainingCount: json['remainingCount'] ?? 0,
      startDate: json['startDate'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      status: json['status'] ?? '',
      isActive: json['isActive'] ?? false,
      inStoreRedemptionMethods: InStoreRedemptionMethods.fromJson(
        json['inStoreRedemptionMethods'],
      ),
      codePrefix: json['codePrefix'] ?? '',
      featured: json['featured'] ?? false,
      priority: json['priority'] ?? 0,
      redemptions: json['redemptions'] ?? 0,
      limitUpdateHistory: json['limitUpdateHistory'] ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      availableCodesCount: json['availableCodesCount'] ?? 0,
      isAvailable: json['isAvailable'] ?? false,
      userCanAfford: json['userCanAfford'] ?? false,
      userBalance: json['userBalance'] ?? 0,
      hasAlreadyClaimed: json['hasAlreadyClaimed'] ?? false,
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

class Business {
  final String id;
  final String category;
  final String name;
  final List<dynamic> locations;

  Business({
    required this.id,
    required this.category,
    required this.name,
    required this.locations,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['_id'] ?? '',
      category: json['category'] ?? '',
      name: json['name'] ?? '',
      locations: json['locations'] ?? [],
    );
  }
}
