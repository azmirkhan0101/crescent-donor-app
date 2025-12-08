import 'package:cresent_charge_user_app/features/common/models/meta_model.dart';

class ClaimedRewardModel {
  final String id;
  final String rewardId;
  final String userId;
  final String code;
  final String codeType;
  final String claimedAt;
  final String? expiresAt;
  final bool isUsed;
  final String? usedAt;
  final Map<String, dynamic>? reward;

  ClaimedRewardModel.fromJson(Map<String, dynamic> json)
    : id = json['_id'],
      rewardId = json['rewardId'],
      userId = json['userId'],
      code = json['code'],
      codeType = json['codeType'],
      claimedAt = json['claimedAt'],
      expiresAt = json['expiresAt'],
      isUsed = json['isUsed'] ?? false,
      usedAt = json['usedAt'],
      reward = json['reward'];
}

class ClaimedRewardsResponse {
  final bool success;
  final String message;
  final MetaModel meta;
  final List<ClaimedRewardModel> data;

  ClaimedRewardsResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'],
      message = json['message'],
      meta = MetaModel.fromJson(json['meta']),
      data = (json['data'] as List)
          .map((e) => ClaimedRewardModel.fromJson(e))
          .toList();
}
