import 'package:cresent_charge_user_app/features/donation/models/roundup_stats_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Round Up Controller
///
/// Manages the state and business logic for the Round Up page
class RoundUpController extends GetxController {
  /// Activity expansion states - tracks which activities are expanded
  final RxMap<String, bool> _activityExpansionStates = <String, bool>{}.obs;

  Map<String, bool> get activityExpansionStates => _activityExpansionStates;

  /// Controls whether to show progress chart or detailed view
  final RxBool showDetailedProgress = false.obs;

  var roundupStats = Rx<RoundupStats?>(null);
  var isLoadingRoundupStats = false.obs;
  var errorMessageRoundupStats = ''.obs;

  /// Handle tap on activity item
  void onActivityTapped(RecentActivity activity) {
    // Navigate to activity details if needed
    debugPrint('Activity tapped: ${activity.brandName}');
  }

  /// Handle tap on organization card
  void onOrganizationTapped(DonatedOrganization organization) {
    // Navigate to organization details if needed
    debugPrint('Organization tapped: ${organization.name}');
  }

  /// Toggle between progress chart and detailed view
  void toggleProgressView() {
    showDetailedProgress.value = !showDetailedProgress.value;
  }

  Future<void> fetchRoundupStats(String roundupId) async {
    isLoadingRoundupStats.value = true;
    errorMessageRoundupStats.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      '${ApiUrl.baseUrl}/client/roundup-stats?roundupId=$roundupId',
      withAuth: true,
    );

    isLoadingRoundupStats.value = false;

    response.fold(
      (error) {
        errorMessageRoundupStats.value = error.message ?? 'An error occurred';
        debugPrint('Error fetching roundup stats: ${error.message}');
      },
      (data) {
        final roundupStatsResponse = RoundupStatsResponse.fromJson(data);
        roundupStats.value = roundupStatsResponse.data;
        debugPrint('Roundup stats fetched successfully');
      },
    );
  }
}

/// Model for donated organizations
class DonatedOrganization {
  final String imageUrl;
  final String name;
  final String location;
  final String category;
  final Color categoryColor;

  DonatedOrganization({
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.category,
    required this.categoryColor,
  });
}

/// Model for recent activities
class RecentActivity {
  final String brandName;
  final String brandLogo;
  final double purchaseAmount;
  final double roundUpAmount;
  final String timeAgo;
  final String? donatedTo;
  final String? timestamp;
  final Color brandColor;
  final bool hasDetails;

  RecentActivity({
    required this.brandName,
    required this.brandLogo,
    required this.purchaseAmount,
    required this.roundUpAmount,
    required this.timeAgo,
    this.donatedTo,
    this.timestamp,
    required this.brandColor,
    this.hasDetails = false,
  });
}
