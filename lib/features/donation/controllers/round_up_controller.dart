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

  @override
  Map<String, bool> get activityExpansionStates => _activityExpansionStates;

  /// Controls whether to show progress chart or detailed view
  final RxBool showDetailedProgress = false.obs;

  var roundupStats = Rx<RoundupStats?>(null);
  var isLoadingRoundupStats = false.obs;
  var errorMessageRoundupStats = ''.obs;

  /// List of organizations that have received donations
  // final List<DonatedOrganization> donatedOrganizations = [
  //   DonatedOrganization(
  //     imageUrl: "https://picsum.photos/200/300",
  //     name: 'Hope for Learning Foundation',
  //     location: 'South Asia',
  //     category: '📚 Education',
  //     categoryColor: const Color(0xFFC6F7C9),
  //   ),
  //   DonatedOrganization(
  //     imageUrl: "https://picsum.photos/200/300",
  //     name: 'Healing Hands International',
  //     location: 'Sydney, Australia',
  //     category: '🏥 Health',
  //     categoryColor: const Color(0xFFC7ECFF),
  //   ),
  //   DonatedOrganization(
  //     imageUrl: "https://picsum.photos/200/300",
  //     name: 'Paws and Claws Rescue',
  //     location: 'Melbourne, Australia',
  //     category: '🐈 Animal Care',
  //     categoryColor: const Color(0xFFFFDDC7),
  //   ),
  // ];

  // /// List of recent round up activities
  // final List<RecentActivity> recentActivities = [
  //   RecentActivity(
  //     brandName: 'Adidas',
  //     brandLogo: Assets.rewards.adidas.path,
  //     purchaseAmount: 20.5,
  //     roundUpAmount: 0.5,
  //     timeAgo: '2 min ago',
  //     donatedTo: 'Healing Hands International',
  //     timestamp: 'July 30, 2025 · 2:48 PM',
  //     brandColor: Colors.black,
  //     hasDetails: true,
  //   ),
  //   RecentActivity(
  //     brandName: 'Amazon',
  //     brandLogo: Assets.rewards.amazonA.path,
  //     purchaseAmount: 44.25,
  //     roundUpAmount: 0.75,
  //     timeAgo: '2 min ago',
  //     donatedTo: "Hope for Learning Foundation",
  //     timestamp: 'July 30, 2025 · 2:30 PM',
  //     brandColor: Colors.black,
  //     hasDetails: false,
  //   ),
  // ];

  // /// Earlier activities (different date)
  // final List<RecentActivity> earlierActivities = [
  //   RecentActivity(
  //     brandName: 'H&M',
  //     brandLogo: Assets.rewards.hMLogo.path,
  //     purchaseAmount: 16.75,
  //     roundUpAmount: 0.25,
  //     timeAgo: '2 days ago',
  //     donatedTo: 'Paws and Claws Rescue',
  //     timestamp: 'July 15, 2025 · 11:15 AM',
  //     brandColor: const Color(0xFFCD2026),
  //     hasDetails: false,
  //   ),
  //   RecentActivity(
  //     brandName: 'Amazon',
  //     brandLogo: Assets.rewards.amazonA.path,
  //     purchaseAmount: 12.15,
  //     roundUpAmount: 0.85,
  //     timeAgo: '2 days ago',
  //     donatedTo: 'Amazon Smile Foundation',
  //     timestamp: 'July 11, 2025 · 11:15 AM',
  //     brandColor: Colors.black,
  //     hasDetails: false,
  //   ),
  // ];

  // Controller initialization - no need for override

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

  /// Toggle expansion state for an activity item
  // @override
  // void toggleActivityExpansion(String activityKey) {
  //   _activityExpansionStates[activityKey] = !isActivityExpanded(activityKey);
  //   update(); // Trigger UI update for GetBuilder widgets
  // }

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
