import 'dart:async';

import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/url_parser/image_url_parser.dart';
import 'package:cresent_charge_user_app/features/home/models/organization_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final NetworkHelper _networkHelper = Get.find<NetworkHelper>();
  // Text editing controller for search input
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  // Debounce timer
  Timer? _debounceTimer;

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
  final RxString searchErrorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _setupSearchListener();
    _setupFocusListener();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    searchTextController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }

  void _setupSearchListener() {
    searchTextController.addListener(() {
      searchQuery.value = searchTextController.text;

      // Cancel previous timer
      _debounceTimer?.cancel();

      if (searchTextController.text.isNotEmpty) {
        // Set new timer for 500ms debounce
        _debounceTimer = Timer(const Duration(milliseconds: 500), () {
          _performSearch(searchTextController.text);
        });
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
    // Refresh search results based on new location
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
          logoAsset: Assets.home.varifiedCharitiesBlog1.path,
        ),
      );

      // Keep only latest 10 searches
      if (recentSearches.length > 10) {
        recentSearches.removeRange(10, recentSearches.length);
      }
    }
  }

  // Perform search (placeholder for actual search logic)
  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      isSearching.value = false;
      return;
    }

    isSearching.value = true;
    searchErrorMessage.value = '';

    // Make direct API call without affecting shared organizationsList
    final result = await _networkHelper.request(
      'GET',
      ApiUrl.getAllOrganizations(
        searchTerm: query.trim(),
        state: selectedLocation.value != 'Brisbane'
            ? selectedLocation.value
            : null,
        isProfileVisible: true,
        populateCauses: true,
      ),
      parser: (data) => OrganizationResponseModel.fromJson(data),
      withAuth: true,
    );

    isSearching.value = false;

    result.fold(
      (err) {
        searchErrorMessage.value =
            err.message ?? 'Failed to load organizations';
        searchResults.clear();
      },
      (data) {
        // Convert organizations to search results
        searchResults.value = data.data
            .map(
              (org) => SearchResultItem(
                id: org.id,
                name: org.name.isNotEmpty ? org.name : 'Unknown Organization',
                description: org.aboutUs.isNotEmpty
                    ? org.aboutUs
                    : (org.serviceType.isNotEmpty
                          ? org.serviceType
                          : 'No description'),
                location: '${org.state ?? ''}, ${org.country ?? ''}'.trim(),
                logoAsset: org.logoImage.isNotEmpty
                    ? parseImageUrl(org.logoImage)
                    : Assets.home.varifiedCharitiesBlog1.path,
                serviceType: org.serviceType.isNotEmpty
                    ? org.serviceType
                    : null,
                organization: org,
              ),
            )
            .toList();
      },
    );
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
  final String id;
  final String name;
  final String description;
  final String location;
  final String logoAsset;
  final String? serviceType;
  final OrganizationModel? organization;

  SearchResultItem({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.logoAsset,
    this.serviceType,
    this.organization,
  });
}
