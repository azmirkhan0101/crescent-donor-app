import 'package:cresent_charge_user_app/features/common/models/meta_model.dart';
import 'package:cresent_charge_user_app/features/rewards/models/reward_model.dart';

class RewardsResponse {
  final bool success;
  final String message;
  final MetaModel meta;
  final List<RewardModel> data;

  RewardsResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'],
      message = json['message'],
      meta = MetaModel.fromJson(json['meta']),
      data = (json['data'] as List)
          .map((e) => RewardModel.fromJson(e))
          .toList();
}
