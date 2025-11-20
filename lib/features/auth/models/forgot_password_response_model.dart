class ForgotPasswordResponseModel {
  final bool success;
  final String message;
  final String? token;

  ForgotPasswordResponseModel({
    required this.success,
    required this.message,
    this.token,
  });

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'] ?? json['data']?['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'token': token};
  }
}
