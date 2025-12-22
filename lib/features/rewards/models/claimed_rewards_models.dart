/*
{
    "success": true,
    "message": "Claimed rewards retrieved successfully",
    "meta": {
        "page": 1,
        "limit": 10,
        "total": 3,
        "totalPage": 1
    },
    "data": [
        {
            "redeemedId": "694821253d28b7352efca60d",
            "rewardId": "694815bf3c653643f71f362d",
            "title": "$25 Gift Card Online 2",
            "rewardImage": "https://crecent-changes.s3.ap-southeast-2.amazonaws.com/rewards/reward-1766331839265",
            "category": "other",
            "type": "online",
            "description": "Redeem this $25 gift card online.",
            "status": "redeemed",
            "isEmailSent": true,
            "code": "SUMMER2025",
            "claimedAt": "2025-12-21T16:32:37.252Z",
            "redeemedAt": "2025-12-21T16:32:37.252Z"
        }
    ]
}
*/
class ClaimedRewardsModel {
  final String redeemedId;
  final String rewardId;
  final String title;
  final String? rewardImage;
  final String category;
  final String type;
  final String description;
  final String status;
  final bool isEmailSent;
  final String? code;
  final String? claimedAt;
  final String? redeemedAt;

  ClaimedRewardsModel({
    required this.redeemedId,
    required this.rewardId,
    required this.title,
    this.rewardImage,
    required this.category,
    required this.type,
    required this.description,
    required this.status,
    required this.isEmailSent,
    this.code,
    this.claimedAt,
    this.redeemedAt,
  });

  factory ClaimedRewardsModel.fromJson(Map<String, dynamic> json) {
    return ClaimedRewardsModel(
      redeemedId: json['redeemedId'] ?? '',
      rewardId: json['rewardId'] ?? '',
      title: json['title'] ?? '',
      rewardImage: json['rewardImage'],
      category: json['category'] ?? '',
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      isEmailSent: json['isEmailSent'] ?? false,
      code: json['code'] ?? '',
      claimedAt: json['claimedAt'] ?? '',
      redeemedAt: json['redeemedAt'] ?? '',
    );
  }
}
