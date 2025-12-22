class SignupResponseModel {
  final bool success;
  final String message;
  final SignupData data;

  SignupResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: SignupData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class SignupData {
  final String id;
  final String email;
  final String role;
  final bool isVerifiedByOTP;
  final String otpExpiry;
  final String createdAt;

  SignupData({
    required this.id,
    required this.email,
    required this.role,
    required this.isVerifiedByOTP,
    required this.otpExpiry,
    required this.createdAt,
  });

  factory SignupData.fromJson(Map<String, dynamic> json) {
    return SignupData(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      isVerifiedByOTP: json['isVerifiedByOTP'] ?? false,
      otpExpiry: json['otpExpiry'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'role': role,
      'isVerifiedByOTP': isVerifiedByOTP,
      'otpExpiry': otpExpiry,
      'createdAt': createdAt,
    };
  }
}
