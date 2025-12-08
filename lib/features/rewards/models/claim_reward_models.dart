class ClaimRewardRequest {
  final String preferredCodeType;

  ClaimRewardRequest({required this.preferredCodeType});

  Map<String, dynamic> toJson() {
    return {'preferredCodeType': preferredCodeType};
  }
}

class ClaimRewardData {
  final Map<String, dynamic> redemption;
  final String? code;
  final List<String>? availableMethods;
  final bool? isRetry;

  ClaimRewardData.fromJson(Map<String, dynamic> json)
    : redemption = json['redemption'],
      code = json['code'],
      availableMethods = json['availableMethods'] != null
          ? List<String>.from(json['availableMethods'])
          : null,
      isRetry = json['isRetry'];
}

class ClaimRewardResponse {
  final bool success;
  final String message;
  final ClaimRewardData? data;

  ClaimRewardResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'],
      message = json['message'],
      data = json['data'] != null
          ? ClaimRewardData.fromJson(json['data'])
          : null;
}
