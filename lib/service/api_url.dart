class ApiUrl {
  static const baseUrl = "http://10.10.20.42:5000/api/v1"; // LOCAL
  // static const baseUrl = "http://localhost:5000/api/v1"; // LOCAL

  static const imageBaseUrl = 'http://10.10.20.42:5000/';

  static socketUrl({String userID = ""}) => '$baseUrl?id=$userID';

  /// ======= Auth =======
  static const login = '$baseUrl/auth/signin';
  static const signup = '$baseUrl/auth/signup';
  static const createProfile = '$baseUrl/auth/create-Profile';
  static const verifySignupOtp = '$baseUrl/auth/verify-signup-otp';
  static const verifyForgotPasswordOtp =
      '$baseUrl/auth/verify-forgot-password-otp';
  static const forgotPassword = '$baseUrl/auth/forgot-password';
  static const resendSignupOtp = '$baseUrl/auth/send-signup-otp-again';
  static const resendForgotPasswordOtp =
      '$baseUrl/auth/send-forgot-password-otp-again';
  static const resetPassword = '$baseUrl/auth/reset-password';
  // Assuming get profile endpoint (client) – adjust if backend differs
  static const getProfile = '$baseUrl/auth/profile';
  static const changePassword = '$baseUrl/auth/change-password';
}
