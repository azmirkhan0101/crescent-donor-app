import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/common/mixins/activity_expansion_mixin.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/round_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Transaction History Controller
///
/// Manages the state and business logic for the Transaction History page
class TransactionHistoryController extends GetxController
    with ActivityExpansionMixin {
  /// Activity expansion states - tracks which activities are expanded
  final RxMap<String, bool> _activityExpansionStates = <String, bool>{}.obs;

  @override
  Map<String, bool> get activityExpansionStates => _activityExpansionStates;

  /// Loading state for transaction data
  final RxBool isLoading = false.obs;

  /// Current filter selection
  final RxString selectedFilter = 'All'.obs;

  /// Available filter options
  final List<String> filterOptions = [
    'All',
    'Donations',
    'Round Ups',
    'Rewards',
  ];

  /// List of recent round up activities for today
  final RxList<RecentActivity> todaysActivities = <RecentActivity>[
    RecentActivity(
      brandName: 'Adidas',
      brandLogo: Assets.rewards.adidas.path,
      purchaseAmount: 20.5,
      roundUpAmount: 0.5,
      timeAgo: '2 min ago',
      donatedTo: 'Healing Hands International',
      timestamp: 'July 30, 2025 · 2:48 PM',
      brandColor: Colors.black,
      hasDetails: true,
    ),
    RecentActivity(
      brandName: 'Amazon',
      brandLogo: Assets.rewards.amazonA.path,
      purchaseAmount: 44.25,
      roundUpAmount: 0.75,
      timeAgo: '5 min ago',
      donatedTo: "Hope for Learning Foundation",
      timestamp: 'July 30, 2025 · 2:30 PM',
      brandColor: Colors.black,
      hasDetails: true,
    ),
    RecentActivity(
      brandName: 'Nike',
      brandLogo: Assets.rewards.adidas.path, // Using adidas instead of nike
      purchaseAmount: 89.99,
      roundUpAmount: 0.01,
      timeAgo: '15 min ago',
      donatedTo: "Children's Aid Foundation",
      timestamp: 'July 30, 2025 · 2:15 PM',
      brandColor: Colors.black,
      hasDetails: true,
    ),
    RecentActivity(
      brandName: 'Starbucks',
      brandLogo:
          Assets.rewards.amazonA.path, // Using amazon instead of starbucks
      purchaseAmount: 12.75,
      roundUpAmount: 0.25,
      timeAgo: '1 hour ago',
      donatedTo: "Local Food Bank",
      timestamp: 'July 30, 2025 · 1:30 PM',
      brandColor: const Color(0xFF00704A),
      hasDetails: true,
    ),
  ].obs;

  /// Earlier activities (different dates)
  final RxList<RecentActivity> earlierActivities = <RecentActivity>[
    RecentActivity(
      brandName: 'H&M',
      brandLogo: Assets.rewards.hMLogo.path,
      purchaseAmount: 16.75,
      roundUpAmount: 0.25,
      timeAgo: '2 days ago',
      donatedTo: 'Paws and Claws Rescue',
      timestamp: 'July 28, 2025 · 11:15 AM',
      brandColor: const Color(0xFFCD2026),
      hasDetails: true,
    ),
    RecentActivity(
      brandName: 'Amazon',
      brandLogo: Assets.rewards.amazonA.path,
      purchaseAmount: 32.40,
      roundUpAmount: 0.60,
      timeAgo: '2 days ago',
      donatedTo: 'Amazon Smile Foundation',
      timestamp: 'July 28, 2025 · 9:45 AM',
      brandColor: Colors.black,
      hasDetails: true,
    ),
    RecentActivity(
      brandName: 'Target',
      brandLogo: Assets.rewards.hMLogo.path, // Using H&M instead of target
      purchaseAmount: 67.33,
      roundUpAmount: 0.67,
      timeAgo: '3 days ago',
      donatedTo: 'Community Health Network',
      timestamp: 'July 27, 2025 · 4:20 PM',
      brandColor: const Color(0xFFCC0000),
      hasDetails: true,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with all activities collapsed
    _initializeExpansionStates();
  }

  /// Initialize expansion states for all activities
  void _initializeExpansionStates() {
    // Initialize today's activities
    for (int i = 0; i < todaysActivities.length; i++) {
      final key = getActivityKey(todaysActivities[i], i);
      activityExpansionStates[key] = false;
    }

    // Initialize earlier activities
    for (int i = 0; i < earlierActivities.length; i++) {
      final key = getActivityKey(
        earlierActivities[i],
        todaysActivities.length + i,
      );
      activityExpansionStates[key] = false;
    }
  }

  /// Toggle expansion state for an activity item
  @override
  void toggleActivityExpansion(String activityKey) {
    final currentState = _activityExpansionStates[activityKey] ?? false;
    _activityExpansionStates[activityKey] = !currentState;

    // Debug print to confirm the toggle is working
    print('Toggling activity $activityKey: ${!currentState}');

    update(); // Trigger UI update for GetBuilder widgets
  }

  /// Apply filter to transactions
  void applyFilter(String filter) {
    selectedFilter.value = filter;
    // TODO: Implement actual filtering logic based on transaction types
    _filterTransactions();
  }

  /// Filter transactions based on selected filter
  void _filterTransactions() {
    // This is where you would implement filtering logic
    // For now, we'll keep all transactions visible
    switch (selectedFilter.value) {
      case 'Donations':
        // Filter only donation transactions
        break;
      case 'Round Ups':
        // Filter only round-up transactions
        break;
      case 'Rewards':
        // Filter only reward transactions
        break;
      default:
        // Show all transactions
        break;
    }
  }

  /// Refresh transaction data
  Future<void> refreshTransactions() async {
    isLoading.value = true;

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // TODO: Implement actual API call to refresh transaction data
      // For now, we'll just refresh the current data
      _initializeExpansionStates();
    } catch (e) {
      // Handle error
      Get.snackbar(
        'Error',
        'Failed to refresh transactions: ${e.toString()}',
        backgroundColor: Colors.red[100],
        colorText: Colors.red[800],
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Get total transaction count
  int get totalTransactionCount =>
      todaysActivities.length + earlierActivities.length;

  /// Get total round up amount for today
  double get todaysTotalRoundUp {
    return todaysActivities.fold(
      0.0,
      (sum, activity) => sum + activity.roundUpAmount,
    );
  }

  /// Get total round up amount for all time
  double get totalRoundUpAmount {
    final todaysTotal = todaysActivities.fold(
      0.0,
      (sum, activity) => sum + activity.roundUpAmount,
    );
    final earlierTotal = earlierActivities.fold(
      0.0,
      (sum, activity) => sum + activity.roundUpAmount,
    );
    return todaysTotal + earlierTotal;
  }

  /// Add new transaction (for future use)
  void addTransaction(RecentActivity activity) {
    todaysActivities.insert(0, activity);
    final key = getActivityKey(activity, 0);
    activityExpansionStates[key] = false;

    // Re-initialize keys for existing activities
    _initializeExpansionStates();
  }

  /// Remove transaction (for future use)
  void removeTransaction(String activityKey) {
    // Find and remove the transaction
    todaysActivities.removeWhere((activity) {
      final key = getActivityKey(activity, todaysActivities.indexOf(activity));
      return key == activityKey;
    });

    earlierActivities.removeWhere((activity) {
      final key = getActivityKey(
        activity,
        earlierActivities.indexOf(activity) + todaysActivities.length,
      );
      return key == activityKey;
    });

    // Remove from expansion states
    activityExpansionStates.remove(activityKey);

    // Re-initialize expansion states
    _initializeExpansionStates();
  }

  @override
  void onClose() {
    // Clean up resources
    super.onClose();
  }
}
