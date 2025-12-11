class ApiUrl {
  // For Android Emulator, use 10.0.2.2 to access host machine's localhost
  // For iOS Simulator, use localhost
  // For physical device, use your machine's IP address (e.g., 192.168.x.x)
  static const String hostUrl = "http://10.0.2.2:5001"; // local server
  // static const String hostUrl = "http://10.10.20.42:5000"; // Mustafiz's local server
  // static const String hostUrl = "http://localhost:5001"; // Android Emulator
  static const String baseUrl = "$hostUrl/api/v1";

  // Alternative URLs (uncomment as needed):
  // static const String hostUrl = "http://localhost:5001"; // iOS Simulator / Web
  // static const String hostUrl = "http://10.10.20.42:5000"; // Physical device (use your machine's IP)

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
  static String getAllOrganizations({
    String? searchTerm,
    String? country,
    String? state,
    String? serviceType,
    bool? isProfileVisible,
    String? dateFrom,
    String? dateTo,
    int? page,
    int? limit,
    String? sort,
    String? fields,
    String? status,
    bool? populateCauses,
  }) {
    final params = <String>[];

    if (searchTerm != null && searchTerm.isNotEmpty) {
      params.add('searchTerm=$searchTerm');
    }
    if (country != null && country.isNotEmpty) {
      params.add('country=$country');
    }
    if (state != null && state.isNotEmpty) {
      params.add('state=$state');
    }
    if (serviceType != null && serviceType.isNotEmpty) {
      params.add('serviceType=$serviceType');
    }
    if (isProfileVisible != null) {
      params.add('isProfileVisible=$isProfileVisible');
    }
    if (dateFrom != null && dateFrom.isNotEmpty) {
      params.add('dateFrom=$dateFrom');
    }
    if (dateTo != null && dateTo.isNotEmpty) {
      params.add('dateTo=$dateTo');
    }
    if (page != null) {
      params.add('page=$page');
    }
    if (limit != null) {
      params.add('limit=$limit');
    }
    if (sort != null && sort.isNotEmpty) {
      params.add('sort=$sort');
    }
    if (fields != null && fields.isNotEmpty) {
      params.add('fields=$fields');
    }
    if (status != null && status.isNotEmpty) {
      params.add('status=$status');
    }
    if (populateCauses != null) {
      params.add('populateCauses=$populateCauses');
    }

    final query = params.isEmpty ? '' : '?${params.join('&')}';
    return '$baseUrl/organization/get-all$query';
  }

  static String getOrganizationDetails(String organizationId) =>
      '$baseUrl/organization/$organizationId';

  /// ======= Donations =======
  static const String oneTimeDonationCreate =
      '$baseUrl/donation/one-time/create';
  static const String clientStats = '$baseUrl/donation/analytics/client-stats';
  static const String roundupStats = '$baseUrl/client/roundup-stats';

  /// ======= Payment Methods =======
  static const String getPaymentMethods = '$baseUrl/payment-method';
  static const String createSetupIntent =
      '$baseUrl/payment-method/setup-intent';
  static const String addPaymentMethod = '$baseUrl/payment-method';
  static String deletePaymentMethod(String id) => '$baseUrl/payment-method/$id';
  static const String getDefaultPaymentMethod =
      '$baseUrl/payment-method/default';
  static String getPaymentMethodDetails(String id) =>
      '$baseUrl/payment-method/$id';
  static String setDefaultPaymentMethod(String id) =>
      '$baseUrl/payment-method/$id/default';
  // Note: deletePaymentMethod is already defined above in the Payment Methods section

  /// ======= Bank Connection =======
  static const String generatePlaidLinkToken =
      '$baseUrl/bank-connection/link-token';
  static const String bankConnection = '$baseUrl/bank-connection';
  static const String getConnectedAccounts =
      '$baseUrl/bank-connection/accounts';
  static const String getBankConnection = '$baseUrl/bank-connection/me';

  /// ======= Secure RoundUp =======
  static const String saveRoundupConsent =
      '$baseUrl/secure-roundup/consent/save';
  static const String secureRoundupDashboard =
      '$baseUrl/secure-roundup/dashboard';
  static String revokeRoundupConsent(String bankConnectionId) =>
      '$baseUrl/secure-roundup/consent/revoke/$bankConnectionId';
  static const String switchRoundupCharity =
      '$baseUrl/secure-roundup/charity/switch';
  static const String resumeRoundup = '$baseUrl/secure-roundup/resume';
  static const String processMonthlyDonation =
      '$baseUrl/secure-roundup/process-monthly-donation';

  /// ======= RoundUp Transactions =======
  static String getRoundupTransactions({
    String? status,
    int? page,
    int? limit,
    int? month,
    int? year,
  }) {
    final params = <String>[];

    if (status != null && status.isNotEmpty) params.add('status=$status');
    if (page != null) params.add('page=$page');
    if (limit != null) params.add('limit=$limit');
    if (month != null) params.add('month=$month');
    if (year != null) params.add('year=$year');

    final query = params.isEmpty ? '' : '?${params.join('&')}';
    return '$baseUrl/roundup-transactions$query';
  }

  static const String getRoundupTransactionsSummary =
      '$baseUrl/roundup-transactions/summary';
  static String getRoundupTransactionDetails(String transactionId) =>
      '$baseUrl/roundup-transactions/$transactionId';

  /// ======= Recurring Donations =======
  static const String createScheduledDonation =
      '$baseUrl/scheduled-donation/create';

  /// ======= Rewards =======
  static const String getRewards = '$baseUrl/rewards';
  static String getRewardDetails(String rewardId) =>
      '$baseUrl/rewards/$rewardId';
  static String getRewardAvailability(String rewardId) =>
      '$baseUrl/rewards/$rewardId/availability';
  static const String getMyClaimedRewards = '$baseUrl/rewards/my/claimed';
  static String getBusinessRewards(String businessId) =>
      '$baseUrl/rewards/business/$businessId';

  static String claimReward(String rewardId) =>
      '$baseUrl/rewards/$rewardId/claim';
  static String getRedemptionDetails(String redemptionId) =>
      '$baseUrl/rewards/redemption/$redemptionId';
  static String cancelRedemption(String redemptionId) =>
      '$baseUrl/rewards/redemption/$redemptionId/cancel';
}
