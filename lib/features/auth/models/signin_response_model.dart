class SigninResponseModel {
  final bool success;
  final String message;
  final SigninData data;

  SigninResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SigninResponseModel.fromJson(Map<String, dynamic> json) {
    return SigninResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: SigninData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class SigninData {
  final String accessToken;
  final String refreshToken;

  SigninData({required this.accessToken, required this.refreshToken});

  factory SigninData.fromJson(Map<String, dynamic> json) {
    return SigninData(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'accessToken': accessToken, 'refreshToken': refreshToken};
  }
}
