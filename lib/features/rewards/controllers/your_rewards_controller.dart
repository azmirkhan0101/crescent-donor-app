import 'dart:async';

import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_all_rewards_controller.dart';
import 'package:get/get.dart';

class YourRewardsController extends GetxController {
  // Points state
  final RxInt _totalPoints = 23382.obs;
  final RxInt _currentProgress = 1000.obs;
  final RxInt _nextBadgeThreshold = 2000.obs;
  final RxString _nextBadgeText = '2 more donations to unlock next badge'.obs;
  final RxDouble _progressPercentage = 65.0.obs;

  // Tab state
  final RxInt _selectedTabIndex = 0.obs;
  final List<String> _tabs = ['Explore', 'My Rewards'];

  // Search state
  final RxString _searchQuery = ''.obs;
  Timer? _debounceTimer;

  // Reward categories
  final List<String> _categories = [
    'All',
    'Food',
    'Clothing',
    'Groceries',
    'Health',
  ];
  final RxInt _selectedCategoryIndex = 0.obs;

  // Getters
  int get totalPoints => _totalPoints.value;
  int get currentProgress => _currentProgress.value;
  int get nextBadgeThreshold => _nextBadgeThreshold.value;
  String get nextBadgeText => _nextBadgeText.value;
  double get progressPercentage => _progressPercentage.value;
  int get selectedTabIndex => _selectedTabIndex.value;
  List<String> get tabs => _tabs;
  String get searchQuery => _searchQuery.value;
  List<String> get categories => _categories;
  int get selectedCategoryIndex => _selectedCategoryIndex.value;

  @override
  void onInit() {
    super.onInit();
    _calculateProgress();
  }

  void _calculateProgress() {
    final progress = (_currentProgress.value / _nextBadgeThreshold.value) * 100;
    _progressPercentage.value = progress.clamp(0.0, 100.0);
  }

  void selectTab(int index) {
    _selectedTabIndex.value = index;
  }

  void updateSearchQuery(String query) {
    _searchQuery.value = query;

    // Cancel previous timer
    _debounceTimer?.cancel();

    // Create new timer with 500ms delay
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _fetchRewardsWithFilters();
    });
  }

  void selectCategory(int index) {
    _selectedCategoryIndex.value = index;
    _fetchRewardsWithFilters();
  }

  void _fetchRewardsWithFilters() {
    final getAllRewardsController = Get.find<GetAllRewardsController>();

    // Determine category value (null for 'All', lowercase otherwise)
    String? categoryValue;
    if (_selectedCategoryIndex.value != 0) {
      categoryValue = _categories[_selectedCategoryIndex.value].toLowerCase();
    }

    // Fetch with current filters
    getAllRewardsController.fetchRewards(
      search: _searchQuery.value.isEmpty ? null : _searchQuery.value,
      category: categoryValue,
      status: 'active',
    );
  }

  void onDonateNowPressed() {
    // Navigate to donation flow
    Get.toNamed('/home');
  }

  void onRedeemReward(String rewardId) {
    // Handle reward redemption
    ToastMsg.success('Reward redeemed successfully!');
  }

  void onClaimReward(String rewardId) {
    // Handle reward claiming
    ToastMsg.success('Reward claimed successfully!');
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
}
