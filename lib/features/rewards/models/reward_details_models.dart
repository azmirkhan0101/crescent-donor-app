/*
{
    "success": true,
    "message": "Reward retrieved successfully",
    "data": {
        "_id": "69465f9ce44cbeb3cdce05d2",
        "business": {
            "_id": "694a16423e3178c766051440",
            "category": "Restaurant",
            "name": "Azmir Bakery",
            "businessPhoneNumber": "01909352429",
            "businessEmail": "bakery@mail.com",
            "locations": [
                "Sparktech Agency, Aqua Tower 43, Dhaka, Bangladesh",
                "New York, NY, USA"
            ],
            "coverImage": "https://crecent-changes.s3.ap-southeast-2.amazonaws.com/profiles/businesses/cover-694a16413e3178c76605143e-1766485085187"
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
  final Business? business;
  final String title;
  final String description;
  final String type;
  final String category;
  final int pointsCost;
  final int redemptionLimit;
  final int redeemedCount;
  final int remainingCount;
  final String? startDate;
  final String? expiryDate;
  final String status;
  final bool isActive;
  final String? image;
  final InStoreRedemptionMethods? inStoreRedemptionMethods;
  final OnlineRedemptionMethods? onlineRedemptionMethods;
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
  final ClaimDetails? claimDetails;
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
    this.startDate,
    this.expiryDate,
    required this.status,
    required this.isActive,
    this.image,
    this.inStoreRedemptionMethods,
    this.onlineRedemptionMethods,
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
    this.claimDetails,
  });

  factory RewardDetailsModel.fromJson(Map<String, dynamic> json) {
    return RewardDetailsModel(
      id: json['_id'] ?? '',
      business: json['business'] != null
          ? Business.fromJson(json['business'] as Map<String, dynamic>)
          : null,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      category: json['category'] ?? '',
      pointsCost: json['pointsCost'] ?? 0,
      redemptionLimit: json['redemptionLimit'] ?? 0,
      redeemedCount: json['redeemedCount'] ?? 0,
      remainingCount: json['remainingCount'] ?? 0,
      startDate: json['startDate'],
      expiryDate: json['expiryDate'],
      status: json['status'] ?? '',
      isActive: json['isActive'] ?? false,
      image: json['image'],
      inStoreRedemptionMethods: json['inStoreRedemptionMethods'] != null
          ? InStoreRedemptionMethods.fromJson(json['inStoreRedemptionMethods'])
          : null,
      onlineRedemptionMethods: json['onlineRedemptionMethods'] != null
          ? OnlineRedemptionMethods.fromJson(json['onlineRedemptionMethods'])
          : null,
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
      claimDetails: json['claimDetails'] != null
          ? ClaimDetails.fromJson(json['claimDetails'] as Map<String, dynamic>)
          : null,
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

class OnlineRedemptionMethods {
  final bool discountCode;
  final bool giftCard;

  OnlineRedemptionMethods({required this.discountCode, required this.giftCard});

  factory OnlineRedemptionMethods.fromJson(Map<String, dynamic> json) {
    return OnlineRedemptionMethods(
      discountCode: json['discountCode'] ?? false,
      giftCard: json['giftCard'] ?? false,
    );
  }
}

class Business {
  final String id;
  final String category;
  final String name;
  final List<String>? locations;
  final String? businessPhoneNumber;
  final String? businessEmail;
  final String? coverImage;

  Business({
    required this.id,
    required this.category,
    required this.name,
    this.locations,
    this.businessPhoneNumber,
    this.businessEmail,
    this.coverImage,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['_id'] ?? '',
      category: json['category'] ?? '',
      name: json['name'] ?? '',
      locations: json['locations'] != null
          ? List<String>.from(json['locations'])
          : null,
      businessPhoneNumber: json['businessPhoneNumber'],
      businessEmail: json['businessEmail'],
      coverImage: json['coverImage'],
    );
  }
}

class ClaimDetails {
  final String id;
  final String? user;
  final String? reward;
  final String? business;
  final int? pointsSpent;
  final String? status;
  final String? assignedCode;
  final List<String>? availableRedemptionMethods;
  final String? expiresAt;
  final bool? isHidden;
  final String? claimedAt;
  final String? createdAt;
  final String? updatedAt;

  ClaimDetails({
    required this.id,
    this.user,
    this.reward,
    this.business,
    this.pointsSpent,
    this.status,
    this.assignedCode,
    this.availableRedemptionMethods,
    this.expiresAt,
    this.isHidden,
    this.claimedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ClaimDetails.fromJson(Map<String, dynamic> json) {
    return ClaimDetails(
      id: json['_id'] ?? '',
      user: json['user'],
      reward: json['reward'],
      business: json['business'],
      pointsSpent: json['pointsSpent'],
      status: json['status'],
      assignedCode: json['assignedCode'],
      availableRedemptionMethods: json['availableRedemptionMethods'] != null
          ? List<String>.from(json['availableRedemptionMethods'])
          : null,
      expiresAt: json['expiresAt'],
      isHidden: json['isHidden'],
      claimedAt: json['claimedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
