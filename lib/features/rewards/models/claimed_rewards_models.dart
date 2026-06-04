
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
