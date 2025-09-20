import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/home/controllers/search_controller.dart'
    as search_ctrl;
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(search_ctrl.SearchController());

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCombinedSearchBar(controller),
          SizedBox(height: 24.rh),
          Expanded(
            child: Obx(
              () => controller.isSearching.value
                  ? _buildSearchingState()
                  : controller.searchResults.isNotEmpty
                  ? _buildSearchResults(controller)
                  : _buildRecentSearches(controller),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Text(
        'Search',
        style: TextStyle(
          color: const Color(0xFF000C0B),
          fontSize: 20.rfs,
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: SvgPicture.asset(
          'assets/common/arrow-left.svg',
          width: 24.rw,
          height: 24.rh,
          colorFilter: const ColorFilter.mode(
            Color(0xFF000C0B),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget _buildCombinedSearchBar(search_ctrl.SearchController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 8.rh),
      child: Obx(
        () => Container(
          height: 52.rh,
          padding: EdgeInsets.symmetric(horizontal: 16.rw),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.rw),
            border: Border.all(color: const Color(0xFFEDEDED), width: 1.rw),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Assets.home.location.svg(
                width: 20.rw,
                height: 20.rh,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF04071E),
                  BlendMode.srcIn,
                ),
              ),

              SizedBox(width: 8.rw),
              // Location Dropdown
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: controller.selectedLocation.value,
                    underline: const SizedBox.shrink(),
                    icon: Assets.common.arrowDown.svg(
                      width: 20.rw,
                      height: 20.rh,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF6B7280),
                        BlendMode.srcIn,
                      ),
                    ),
                    style: AppTextStyles.f16W500().copyWith(
                      fontWeight: FontWeight.w400,
                      fontFamily: AppStrings.interDisplay,
                    ),
                    items: controller.locations.map((String location) {
                      return DropdownMenuItem<String>(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.selectLocation(newValue);
                      }
                    },
                  ),
                ],
              ),

              SizedBox(width: 12.rw),
              // Vertical Divider
              Container(
                height: 24.rh,
                width: 1.rw,
                color: const Color(0xFFE5E7EB),
              ),
              SizedBox(width: 12.rw),

              // Search Input Field
              Expanded(
                child: TextField(
                  controller: controller.searchTextController,
                  focusNode: controller.searchFocusNode,
                  style: TextStyle(
                    color: const Color(0xFF111827),
                    fontSize: 16.rfs,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 16.rfs,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onSubmitted: controller.onSearchSubmitted,
                ),
              ),
              // Search Icon
              SvgPicture.asset(
                'assets/home/Search.svg',
                width: 20.rw,
                height: 20.rh,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF9CA3AF),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: 16.rh),
          Text(
            'Searching...',
            style: TextStyle(
              color: const Color(0xFF6B7280),
              fontSize: 16.rfs,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(search_ctrl.SearchController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.rw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search Results',
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: 16.rfs,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
              if (controller.searchQuery.value.isNotEmpty)
                TextButton(
                  onPressed: controller.clearSearch,
                  child: Text(
                    'Clear',
                    style: TextStyle(
                      color: const Color(0xFF000C0B),
                      fontSize: 14.rfs,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.rh),
          Expanded(
            child: ListView.separated(
              itemCount: controller.searchResults.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.rh),
              itemBuilder: (context, index) {
                final result = controller.searchResults[index];
                return _buildSearchResultItem(result);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearches(search_ctrl.SearchController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.rw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Searches',
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: 16.rfs,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
              if (controller.recentSearches.isNotEmpty)
                TextButton(
                  onPressed: controller.clearAllRecentSearches,
                  child: Text(
                    'Clear All',
                    style: TextStyle(
                      color: const Color(0xFF000C0B),
                      fontSize: 14.rfs,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.rh),
          Expanded(
            child: Obx(
              () => controller.recentSearches.isEmpty
                  ? _buildEmptyRecentSearches()
                  : ListView.separated(
                      itemCount: controller.recentSearches.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12.rh),
                      itemBuilder: (context, index) {
                        final item = controller.recentSearches[index];
                        return _buildRecentSearchItem(controller, item);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyRecentSearches() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 64.rw, color: const Color(0xFF9CA3AF)),
          SizedBox(height: 16.rh),
          Text(
            'No recent searches',
            style: TextStyle(
              color: const Color(0xFF6B7280),
              fontSize: 16.rfs,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 8.rh),
          Text(
            'Start searching to see your history',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.rfs,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearchItem(
    search_ctrl.SearchController controller,
    search_ctrl.RecentSearchItem item,
  ) {
    return GestureDetector(
      onTap: () => controller.onRecentSearchTap(item),
      child: Container(
        padding: EdgeInsets.all(16.rw),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 40.rw,
              height: 40.rh,
              padding: EdgeInsets.all(10.rw),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(item.logoAsset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.rw),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      color: const Color(0xFF000C0B),
                      fontSize: 16.rfs,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.rh),
                  Text(
                    item.location,
                    style: TextStyle(
                      color: const Color(0xFF6B7280),
                      fontSize: 14.rfs,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => controller.removeRecentSearch(item),
              child: Container(
                padding: EdgeInsets.all(4.rw),
                child: Icon(
                  Icons.close,
                  color: const Color(0xFF9CA3AF),
                  size: 20.rw,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultItem(search_ctrl.SearchResultItem result) {
    return Container(
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 40.rw,
            height: 40.rh,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(result.logoAsset),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.rw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.name,
                  style: TextStyle(
                    color: const Color(0xFF000C0B),
                    fontSize: 16.rfs,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.rh),
                Text(
                  result.description,
                  style: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontSize: 14.rfs,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
