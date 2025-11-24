class ApiUrl {
  static const String hostUrl = "http://localhost:5001";
  static const String baseUrl = "$hostUrl/api/v1"; // LOCAL

  // static const String hostUrl = "http://10.10.20.42:5000";
  // static const String baseUrl = "$hostUrl/api/v1"; // LOCAL

  static const String imageBaseUrl = '$hostUrl/';

  static socketUrl({String userID = ""}) => '$baseUrl?id=$userID';

  /// ======= Auth =======
  static const String login = '$baseUrl/auth/signin';
  static const String signup = '$baseUrl/auth/signup';
  static const String createProfile = '$baseUrl/auth/create-Profile';
  static const String verifySignupOtp = '$baseUrl/auth/verify-signup-otp';
  static const String verifyForgotPasswordOtp =
      '$baseUrl/auth/verify-forgot-password-otp';
  static const String forgotPassword = '$baseUrl/auth/forgot-password';
  static const String resendSignupOtp = '$baseUrl/auth/send-signup-otp-again';
  static const String resendForgotPasswordOtp =
      '$baseUrl/auth/send-forgot-password-otp-again';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  // Assuming get profile endpoint (client) – adjust if backend differs
  static const String getProfile = '$baseUrl/auth/profile';
  static const String changePassword = '$baseUrl/auth/change-password';

  /// ======= causes =======
  static const String getAllCauses = '$baseUrl/cause';
  static String getAllCausesByOrgId(String orgId) =>
      '$baseUrl/cause/organization/$orgId';

  /// ======= charities =======
  static const String getAllOrganizations = '$baseUrl/organization/get-all';
  static String getOrganizationDetails(String organizationId) =>
      '$baseUrl/organization/$organizationId';

  /// ======= Donations =======
  static const String oneTimeDonationCreate =
      '$baseUrl/donation/one-time/create';

  /// ======= Payment Methods =======
  static const String getPaymentMethods = '$baseUrl/payment-method';
}
