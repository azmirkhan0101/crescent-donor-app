/*
{
    "success": true,
    "message": "Favorite reward retrived successfully!",
    "meta": {
        "page": 1,
        "limit": 10,
        "total": 1,
        "totalPage": 1
    },
    "data": [
        {
            "_id": "695cc4fcbcffba30856a0045",
            "reward": "695c9dc3dbed6694df92c689",
            "user": "6953af852acf220ff1a08ba7",
            "favoriteId": "695cc4fcbcffba30856a0045",
            "title": "Mostafiz Bro 1",
            "description": "hehehheh",
            "image": "https://crecent-changes.s3.ap-southeast-2.amazonaws.com/rewards/reward-1767677379157",
            "status": "active",
            "isActive": true,
            "inStoreRedemptionMethods": {
                "qrCode": true,
                "staticCode": true,
                "nfcTap": false
            },
            "codePrefix": "RWD42D2",
            "isRedeemed": false,
            "startDate": "2026-01-06T05:29:16.490Z",
            "expiryDate": "2026-01-30T18:00:00.000Z",
            "business": "69521a330ba280e9348ffa74"
        }
    ]
}
*/

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
