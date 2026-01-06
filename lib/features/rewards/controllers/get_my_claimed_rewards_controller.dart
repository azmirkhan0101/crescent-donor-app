import 'package:cresent_charge_user_app/features/common/models/meta_model.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_all_favorite_reward_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/models/claimed_rewards_models.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GetMyClaimedRewardsController extends GetxController {
  final NetworkHelper networkHelper = Get.find<NetworkHelper>();

  var claimedRewards = <ClaimedRewardsModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var meta = Rx<MetaModel?>(null);
  var selectedStatus = 'all'.obs;
  var isFavoriteFilter = false.obs;
  var statusOptions = <String>[
    'all',
    'claimed',
    'redeemed',
    'expired',
    'cancelled',
  ].obs;

  String _buildClaimedRewardsUrl({
    int? page,
    int? limit,
    String? status,
    String? sortBy,
    String? sortOrder,
  }) {
    final params = <String>[];

    if (page != null) {
      params.add('page=$page');
    }
    if (limit != null) {
      params.add('limit=$limit');
    }
    // Only add status parameter if it's not 'all'
    if (status != null && status.isNotEmpty && status != 'all') {
      params.add('status=$status');
    }
    if (sortBy != null && sortBy.isNotEmpty) {
      params.add('sortBy=$sortBy');
    }
    if (sortOrder != null && sortOrder.isNotEmpty) {
      params.add('sortOrder=$sortOrder');
    }

    final query = params.isEmpty ? '' : '?${params.join('&')}';
    return '${ApiUrl.getMyClaimedRewards}$query';
  }

  Future<void> fetchMyClaimedRewards({
    int? page,
    int? limit,
    String? status,
    String? sortBy,
    String? sortOrder,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    final url = _buildClaimedRewardsUrl(
      page: page,
      limit: limit,
      status: status ?? selectedStatus.value,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );

    final response = await networkHelper.request('GET', url, withAuth: true);

    isLoading.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error fetching claimed rewards: ${error.message}');
      },
      (data) {
        final rewardsList = (data['data'] as List)
            .map((item) => ClaimedRewardsModel.fromJson(item))
            .toList();
        claimedRewards.value = rewardsList;
        meta.value = MetaModel.fromJson(data['meta']);
        debugPrint(
          'Claimed rewards fetched successfully: ${claimedRewards.length} items',
        );
      },
    );
  }

  void filterByStatus(String status) {
    selectedStatus.value = status;
    isFavoriteFilter.value =
        false; // Turn off favorite filter when status filter is selected
    fetchMyClaimedRewards(status: status);
  }

  void toggleFavoriteFilter() {
    isFavoriteFilter.value = !isFavoriteFilter.value;
    if (isFavoriteFilter.value) {
      // Fetch favorite rewards via GetAllFavoriteRewardController
      selectedStatus.value = 'all'; // Reset status filter
      final favoriteController = Get.find<GetAllFavoriteRewardController>();
      favoriteController.fetchAllFavoriteRewards();
    } else {
      // Return to regular claimed rewards view
      fetchMyClaimedRewards();
    }
  }
}
