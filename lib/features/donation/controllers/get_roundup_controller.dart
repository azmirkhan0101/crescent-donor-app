import 'package:cresent_charge_user_app/features/donation/models/roundup_config_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Get Round-Up Controller
///
/// Handles fetching and managing user's round-up configuration
///
/// Features:
/// - Fetch round-up config from backend
/// - Track loading and error states
/// - Provide configuration details for UI
class GetRoundupController extends GetxController {
  var roundupConfig = Rx<RoundupConfigModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  /// Fetch round-up configuration from API
  Future<void> fetchRoundupConfig() async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      ApiUrl.getRoundupConfig,
      withAuth: true,
    );

    isLoading.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'Failed to fetch round-up config';
        debugPrint('❌ Error fetching round-up config: ${error.message}');
      },
      (data) {
        debugPrint('✅ Round-up config API Response: $data');
        final configResponse = RoundupConfigResponse.fromJson(data);
        roundupConfig.value = configResponse.data;
        debugPrint(
          '📋 Round-up config fetched: ${configResponse.data.organizationName}',
        );
      },
    );
  }

  /// Refresh round-up configuration
  Future<void> refreshConfig() async {
    await fetchRoundupConfig();
  }

  /// Check if round-up is configured
  bool get hasConfig => roundupConfig.value != null;

  /// Check if round-up is active
  bool get isActive => roundupConfig.value?.isActive ?? false;

  /// Check if round-up is active and verified
  bool get isActiveAndVerified =>
      roundupConfig.value?.isActiveAndVerified ?? false;

  /// Get organization name
  String get organizationName => roundupConfig.value?.organizationName ?? 'N/A';

  /// Get cause name
  String get causeName => roundupConfig.value?.causeName ?? 'N/A';

  /// Get monthly threshold
  double get monthlyThreshold => roundupConfig.value?.monthlyThreshold ?? 0.0;

  /// Get formatted card number
  String get formattedCardNumber =>
      roundupConfig.value?.formattedCardNumber ?? '****';

  /// Get institution name
  String get institutionName => roundupConfig.value?.institutionName ?? 'N/A';
}
