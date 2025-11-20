class ApiUrl {
  static const baseUrl = "http://10.10.20.42:5000/api/v1"; // LOCAL
  // static const baseUrl = "http://localhost:5000/api/v1"; // LOCAL

  static const imageBaseUrl = '$baseUrl/';
  static socketUrl({String userID = ""}) => '$baseUrl?id=$userID';

  /// ======= Auth =======
  static const login = '$baseUrl/auth/signin';
  static const signup = '$baseUrl/auth/signup';
  static const createProfile = '$baseUrl/auth/create-Profile';
  static const verifySignupOtp = '$baseUrl/auth/verify-signup-otp';
  static const verifyForgotPasswordOtp =
      '$baseUrl/auth/verify-forgot-password-otp';
  static const forgotPassword = '$baseUrl/auth/forgot-password';
}
