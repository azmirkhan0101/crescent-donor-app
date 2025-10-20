import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  // Text editing controller for search input
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  // Observable variables
  final RxString searchQuery = ''.obs;
  final RxString selectedLocation = 'Brisbane'.obs;
  final RxBool isSearching = false.obs;
  final RxBool isSearchFocused = false.obs;

  // Location options
  final List<String> locations = [
    'Brisbane',
    'Sydney',
    'Melbourne',
    'Perth',
    'Adelaide',
    'Darwin',
  ];

  // Recent searches list
  final RxList<RecentSearchItem> recentSearches = <RecentSearchItem>[
    RecentSearchItem(
      name: 'Hope for Learning Foundation',
      location: 'South Asia',
      logoAsset: Assets.home.donateCauseProfile2.path,
    ),
    RecentSearchItem(
      name: 'Healing Hands International',
      location: 'Sydney, Australia',
      logoAsset: Assets.home.donatieCauseProfile1.path,
    ),
  ].obs;

  // Search results (for future implementation)
  final RxList<SearchResultItem> searchResults = <SearchResultItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _setupSearchListener();
    _setupFocusListener();
  }

  @override
  void onClose() {
    searchTextController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }

  void _setupSearchListener() {
    searchTextController.addListener(() {
      searchQuery.value = searchTextController.text;
      if (searchTextController.text.isNotEmpty) {
        _performSearch(searchTextController.text);
      } else {
        searchResults.clear();
        isSearching.value = false;
      }
    });
  }

  void _setupFocusListener() {
    searchFocusNode.addListener(() {
      isSearchFocused.value = searchFocusNode.hasFocus;
    });
  }

  // Handle location selection
  void selectLocation(String location) {
    selectedLocation.value = location;
    // Optionally refresh search results based on new location
    if (searchQuery.value.isNotEmpty) {
      _performSearch(searchQuery.value);
    }
  }

  // Handle search submission
  void onSearchSubmitted(String query) {
    if (query.trim().isNotEmpty) {
      _addToRecentSearches(query);
      _performSearch(query);
      searchFocusNode.unfocus();
    }
  }

  // Clear search
  void clearSearch() {
    searchTextController.clear();
    searchQuery.value = '';
    searchResults.clear();
    isSearching.value = false;
  }

  // Remove recent search item
  void removeRecentSearch(RecentSearchItem item) {
    recentSearches.remove(item);
  }

  // Clear all recent searches
  void clearAllRecentSearches() {
    recentSearches.clear();
  }

  // Add search query to recent searches
  void _addToRecentSearches(String query) {
    // Check if already exists
    final existingIndex = recentSearches.indexWhere(
      (item) => item.name.toLowerCase() == query.toLowerCase(),
    );

    if (existingIndex != -1) {
      // Move to top if already exists
      final existing = recentSearches.removeAt(existingIndex);
      recentSearches.insert(0, existing);
    } else {
      // Add new search to top
      recentSearches.insert(
        0,
        RecentSearchItem(
          name: query,
          location: selectedLocation.value,
          logoAsset: 'assets/home/user-1.png', // Default logo
        ),
      );

      // Keep only latest 10 searches
      if (recentSearches.length > 10) {
        recentSearches.removeRange(10, recentSearches.length);
      }
    }
  }

  // Perform search (placeholder for actual search logic)
  void _performSearch(String query) {
    isSearching.value = true;

    // Simulate search delay
    Future.delayed(const Duration(milliseconds: 500), () {
      // TODO: Implement actual search API call
      searchResults.value = _mockSearchResults(query);
      isSearching.value = false;
    });
  }

  // Mock search results (replace with actual API call)
  List<SearchResultItem> _mockSearchResults(String query) {
    return [
      SearchResultItem(
        name: 'Results for "$query"',
        description: 'Sample search result',
        location: selectedLocation.value,
        logoAsset: 'assets/home/user-1.png',
      ),
    ];
  }

  // Handle recent search item tap
  void onRecentSearchTap(RecentSearchItem item) {
    searchTextController.text = item.name;
    searchQuery.value = item.name;
    _performSearch(item.name);
  }
}

// Data Models
class RecentSearchItem {
  final String name;
  final String location;
  final String logoAsset;

  RecentSearchItem({
    required this.name,
    required this.location,
    required this.logoAsset,
  });
}

class SearchResultItem {
  final String name;
  final String description;
  final String location;
  final String logoAsset;

  SearchResultItem({
    required this.name,
    required this.description,
    required this.location,
    required this.logoAsset,
  });
}
