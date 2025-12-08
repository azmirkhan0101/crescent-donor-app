class InStoreRedemptionMethods {
  final bool qrCode;
  final bool staticCode;
  final bool nfcTap;

  InStoreRedemptionMethods.fromJson(Map<String, dynamic> json)
    : qrCode = json['qrCode'] ?? false,
      staticCode = json['staticCode'] ?? false,
      nfcTap = json['nfcTap'] ?? false;
}

class PopulatedBusiness {
  final String id;
  final String name;
  final String? category;
  final String? coverImage;
  final List<dynamic>? locations;

  PopulatedBusiness.fromJson(Map<String, dynamic> json)
    : id = json['_id'],
      name = json['name'],
      category = json['category'],
      coverImage = json['coverImage'],
      locations = json['locations'];
}

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
  final bool? userCanAfford;
  final String? claimStatus;

  RewardModel.fromJson(Map<String, dynamic> json)
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
      isAvailable = json['isAvailable'] ?? false,
      userCanAfford = json['userCanAfford'],
      claimStatus = json['claimStatus'];
}
