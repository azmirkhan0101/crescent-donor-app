class SetupIntentResponse {
  final bool success;
  final String message;
  final SetupIntentData data;

  SetupIntentResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SetupIntentResponse.fromJson(Map<String, dynamic> json) {
    return SetupIntentResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: SetupIntentData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class SetupIntentData {
  final String clientSecret;
  final String setupIntentId;

  SetupIntentData({required this.clientSecret, required this.setupIntentId});

  factory SetupIntentData.fromJson(Map<String, dynamic> json) {
    return SetupIntentData(
      clientSecret: json['client_secret'] as String,
      setupIntentId: json['setup_intent_id'] as String,
    );
  }
}
