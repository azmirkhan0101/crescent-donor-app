
class FavoriteRewardModel {
  final String? id;
  final String? reward;
  final String? user;
  final String? favoriteId;
  final String? title;
  final String? description;
  final String? image;
  final String? status;
  final bool? isActive;
  final InStoreRedemptionMethods? inStoreRedemptionMethods;
  final String? codePrefix;
  final bool? isRedeemed;
  final DateTime? startDate;
  final DateTime? expiryDate;
  final String? business;

  FavoriteRewardModel({
    this.id,
    this.reward,
    this.user,
    this.favoriteId,
    this.title,
    this.description,
    this.image,
    this.status,
    this.isActive,
    this.inStoreRedemptionMethods,
    this.codePrefix,
    this.isRedeemed,
    this.startDate,
    this.expiryDate,
    this.business,
  });

  factory FavoriteRewardModel.fromJson(Map<String, dynamic> json) => FavoriteRewardModel(
    id: json["_id"],
    reward: json["reward"],
    user: json["user"],
    favoriteId: json["favoriteId"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    status: json["status"],
    isActive: json["isActive"],
    inStoreRedemptionMethods: json["inStoreRedemptionMethods"] == null
        ? null
        : InStoreRedemptionMethods.fromJson(json["inStoreRedemptionMethods"]),
    codePrefix: json["codePrefix"],
    isRedeemed: json["isRedeemed"],
    startDate: json["startDate"] == null
        ? null
        : DateTime.parse(json["startDate"]),
    expiryDate: json["expiryDate"] == null
        ? null
        : DateTime.parse(json["expiryDate"]),
    business: json["business"],
  );
}

class InStoreRedemptionMethods {
  final bool? qrCode;
  final bool? staticCode;
  final bool? nfcTap;

  InStoreRedemptionMethods({this.qrCode, this.staticCode, this.nfcTap});

  factory InStoreRedemptionMethods.fromJson(Map<String, dynamic> json) =>
      InStoreRedemptionMethods(
        qrCode: json["qrCode"],
        staticCode: json["staticCode"],
        nfcTap: json["nfcTap"],
      );
}
