class ApiUrl {
  // For Android Emulator, use 10.0.2.2 to access host machine's localhost
  // For iOS Simulator, use localhost
  // For physical device, use your machine's IP address (e.g., 192.168.x.x)
  static const String hostUrl =
      "https://server.crescentchange.com"; // aws server
  // static const String hostUrl = "http://10.0.2.2:5001"; // local server
  // static const String hostUrl = "http://10.10.20.42:5000"; // Local
  static const String baseUrl = "$hostUrl/api/v1";

  // Alternative URLs (uncomment as needed):
  // static const String hostUrl = "http://localhost:5001"; // iOS Simulator / Web
  // static const String hostUrl = "http://10.10.20.42:5000"; // Physical device (use your machine's IP)

  static const String imageBaseUrl = hostUrl;

  static socketUrl({String userID = ""}) => '$baseUrl?id=$userID';

  /// ======= Common =======
  static String url(String path) => '$baseUrl/$path';

  /// ======= Auth =======
  static const String login = '$baseUrl/auth/signin';
  static const String guestLogin = '$baseUrl/auth/guest-login';
  static const String guestLogOut = '$baseUrl/auth/guest-remove';
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
  static const String updateFcmToken = '$baseUrl/auth/update-fcm';

  /// ======= Notifications =======
  static const String getNotifications = '$baseUrl/notification/me';
  static const String unseenNotificationCount =
      '$baseUrl/notification/unseen-notification-count';
  static String markNotificationAsRead(String notificationId) =>
      '$baseUrl/notification/mark-notification/$notificationId';
  static const String notificationSettings = '$baseUrl/notification-settings';

  /// ======= causes =======
  static const String getAllCauses = '$baseUrl/cause';
  static String getAllCausesByOrgId(String orgId) =>
      '$baseUrl/cause/organization/$orgId';
  static const String getCauseCategories = '$baseUrl/cause/categories';

  /// ======= charities =======
  static const String getAllOrganizations = '$baseUrl/organization/get-all';

  static String getOrganizationDetails(String organizationId) =>
      '$baseUrl/organization/$organizationId';

  /// ======= Donations =======
  static const String oneTimeDonationCreate =
      '$baseUrl/donation/one-time/create';
  static const String clientStats = '$baseUrl/donation/analytics/client-stats';
  static const String roundupStats = '$baseUrl/client/roundup-stats';
  static String getDonationFullStatus(String donationId) =>
      '$baseUrl/donation/$donationId/status';

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
  // static const String bankConnection = '$baseUrl/bank-connection';
  static const String getConnectedAccounts =
      '$baseUrl/bank-connection/accounts';
  static const String getBankConnection = '$baseUrl/bank-connection/me';
  static const String connectBasiq = '$baseUrl/bank-connection/connect-basiq';
  static const String getBasiqConnections =
      '$baseUrl/bank-connection/basiq/accounts';
  static const String saveBasiqConnection =
      '$baseUrl/bank-connection/basiq/save-account';

  /// ======= Secure RoundUp =======
  static const String saveRoundupConsent =
      '$baseUrl/secure-roundup/consent/save';
  static const String secureRoundupDashboard =
      '$baseUrl/secure-roundup/dashboard';
  static const String getRoundupConfig = '$baseUrl/secure-roundup/get-by-user';
  static String updateRoundupConfig(String roundupId) =>
      '$baseUrl/secure-roundup/$roundupId';
  static String cancelRoundupConfig(String roundupId) =>
      '$baseUrl/secure-roundup/$roundupId/cancel';
  static String revokeRoundupConsent(String bankConnectionId) =>
      '$baseUrl/secure-roundup/consent/revoke/$bankConnectionId';
  static const String switchRoundupCharity =
      '$baseUrl/secure-roundup/charity/switch';
  static const String resumeRoundup = '$baseUrl/secure-roundup/resume';
  static const String processMonthlyDonation =
      '$baseUrl/secure-roundup/process-monthly-donation';

  /// ======= RoundUp Transactions =======
  static const String getRoundupTransactions = '$baseUrl/roundup-transactions';

  static const String getRoundupTransactionsSummary =
      '$baseUrl/roundup-transactions/summary';
  static String getRoundupTransactionDetails(String transactionId) =>
      '$baseUrl/roundup-transactions/$transactionId';

  /// ======= Recurring Donations =======
  static const String createScheduledDonation =
      '$baseUrl/scheduled-donation/create';
  static String getRecurringOrgState(String organizationId) =>
      '$baseUrl/client/recurring?organizationId=$organizationId';
  static const String getRecurringConnections =
      '$baseUrl/scheduled-donation/user';

  static String updateOrCancelRecurringDonation(String donationId) =>
      '$baseUrl/scheduled-donation/$donationId';

  /// ======= One Time Donations =======
  static const String getOneTimeStates = '$baseUrl/client/onetime-stats';

  /// ======= Rewards =======
  static const String getRewards = '$baseUrl/rewards/explore';
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

  /// ======= Points Transactions =======
  static String getPointsTransactions(String clientId) =>
      '$baseUrl/points/transactions/$clientId';

  /// ======= Transaction History =======
  static const String getTransactionHistory =
      '$baseUrl/client/transaction/history';

  /// ======= Business =======
  static String getBusinessDetails(String businessId) =>
      '$baseUrl/business/$businessId';

  /// ======= Badges =======
  static const String getBadgesProgress = '$baseUrl/badges/user/progress';
  static String getBadgeHistory(String badgeId) =>
      '$baseUrl/badges/$badgeId/history';

  /// ======= Receipt =======
  static String getReceipt(String receiptId) => '$baseUrl/receipt/$receiptId';
  static const String generateReceipt = '$baseUrl/api/receipts/generate';
}
