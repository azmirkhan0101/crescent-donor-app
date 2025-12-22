class VerifyOtpResponseModel {
  final bool success;
  final String message;
  final VerifyForgotPasswordOtpData data;

  VerifyOtpResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: VerifyForgotPasswordOtpData.fromJson(json['data'] ?? {}),
    );
  }
}

class VerifyForgotPasswordOtpData {
  final String resetPasswordToken;

  VerifyForgotPasswordOtpData({required this.resetPasswordToken});

  factory VerifyForgotPasswordOtpData.fromJson(Map<String, dynamic> json) {
    return VerifyForgotPasswordOtpData(
      resetPasswordToken: json['resetPasswordToken'] ?? '',
    );
  }
}
