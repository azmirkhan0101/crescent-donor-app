class RewardAvailabilityModel {
  final bool isAvailable;
  final int remainingCount;
  final bool userCanAfford;
  final int userBalance;
  final bool hasAlreadyClaimed;

  RewardAvailabilityModel.fromJson(Map<String, dynamic> json)
    : isAvailable = json['isAvailable'] ?? false,
      remainingCount = json['remainingCount'] ?? 0,
      userCanAfford = json['userCanAfford'] ?? false,
      userBalance = json['userBalance'] ?? 0,
      hasAlreadyClaimed = json['hasAlreadyClaimed'] ?? false;
}

class RewardAvailabilityResponse {
  final bool success;
  final String message;
  final RewardAvailabilityModel data;

  RewardAvailabilityResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'],
      message = json['message'],
      data = RewardAvailabilityModel.fromJson(json['data']);
}
