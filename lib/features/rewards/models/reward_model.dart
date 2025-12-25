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
  final String? startDate;
  final String? expiryDate;
  final String status;
  final bool isActive;
  final bool? featured;
  final int? priority;
  final int? redemptions;
  final InStoreRedemptionMethods? inStoreRedemptionMethods;
  final OnlineRedemptionMethods? onlineRedemptionMethods;
  final String codePrefix;
  final List<dynamic>? limitUpdateHistory;
  final String createdAt;
  final String updatedAt;
  final String? lastLimitUpdate;
  final int? availableCodesCount;
  final bool? isAvailable;
  final bool? userCanAfford;
  final int? userBalance;
  final bool? hasAlreadyClaimed;
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
    this.startDate,
    this.expiryDate,
    required this.status,
    required this.isActive,
    this.featured,
    this.priority,
    this.redemptions,
    this.inStoreRedemptionMethods,
    this.onlineRedemptionMethods,
    required this.codePrefix,
    this.limitUpdateHistory,
    required this.createdAt,
    required this.updatedAt,
    this.lastLimitUpdate,
    this.availableCodesCount,
    this.isAvailable,
    this.userCanAfford,
    this.userBalance,
    this.hasAlreadyClaimed,
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
      startDate: json['startDate'],
      expiryDate: json['expiryDate'],
      status: json['status'] ?? '',
      isActive: json['isActive'] ?? false,
      featured: json['featured'],
      priority: json['priority'],
      redemptions: json['redemptions'],
      inStoreRedemptionMethods: json['inStoreRedemptionMethods'] != null
          ? InStoreRedemptionMethods.fromJson(json['inStoreRedemptionMethods'])
          : null,
      onlineRedemptionMethods: json['onlineRedemptionMethods'] != null
          ? OnlineRedemptionMethods.fromJson(json['onlineRedemptionMethods'])
          : null,
      codePrefix: json['codePrefix'] ?? '',
      limitUpdateHistory: json['limitUpdateHistory'] as List<dynamic>?,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      lastLimitUpdate: json['lastLimitUpdate'],
      availableCodesCount: json['availableCodesCount'],
      isAvailable: json['isAvailable'],
      userCanAfford: json['userCanAfford'],
      userBalance: json['userBalance'],
      hasAlreadyClaimed: json['hasAlreadyClaimed'],
      userStatus: json['userStatus'] ?? '',
      isAlreadyClaimed: json['isAlreadyClaimed'] ?? false,
      isAlreadyRedeemed: json['isAlreadyRedeemed'] ?? false,
    );
  }
}

class PopulatedBusiness {
  final String id;
  final String name;
  final String? logoImage;
  final String? coverImage;

  PopulatedBusiness({
    required this.id,
    required this.name,
    this.logoImage,
    this.coverImage,
  });

  factory PopulatedBusiness.fromJson(Map<String, dynamic> json) {
    return PopulatedBusiness(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      logoImage: json['logoImage'],
      coverImage: json['coverImage'],
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
      nfcTap:
          false, // todo: I made it false because this feature is not available yet
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
