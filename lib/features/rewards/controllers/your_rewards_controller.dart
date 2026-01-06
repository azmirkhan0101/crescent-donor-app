import 'dart:async';

import 'package:cresent_charge_user_app/features/rewards/controllers/get_all_rewards_controller.dart';
import 'package:get/get.dart';

class YourRewardsController extends GetxController {
  /// Injecting controller
  final getAllRewardsController = Get.find<GetAllRewardsController>();

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
  int get selectedTabIndex => _selectedTabIndex.value;
  List<String> get tabs => _tabs;
  String get searchQuery => _searchQuery.value;
  List<String> get categories => _categories;
  int get selectedCategoryIndex => _selectedCategoryIndex.value;

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
    // Determine category value (null for 'All', lowercase otherwise)
    String? categoryValue;
    if (_selectedCategoryIndex.value != 0) {
      categoryValue = _categories[_selectedCategoryIndex.value].toLowerCase();
    }

    // Fetch with current filters
    getAllRewardsController.fetchRewards(
      search: _searchQuery.value.isEmpty ? null : _searchQuery.value,
      category: categoryValue,
      // status: 'active',
    );
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }
}
