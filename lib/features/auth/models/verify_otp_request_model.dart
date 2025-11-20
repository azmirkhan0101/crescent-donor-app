class VerifySignupOtpRequestModel {
  final String email;
  final String otp;

  VerifySignupOtpRequestModel({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {'email': email, 'otp': otp};
  }
}

class VerifyForgotPasswordOtpRequestModel {
  final String token;
  final String otp;

  VerifyForgotPasswordOtpRequestModel({required this.token, required this.otp});

  Map<String, dynamic> toJson() {
    return {'token': token, 'otp': otp};
  }
}
