import 'package:cresent_charge_user_app/features/common/models/meta_model.dart';
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

  String _buildClaimedRewardsUrl({
    int? page,
    int? limit,
    bool? includeExpired,
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
    if (includeExpired != null) {
      params.add('includeExpired=$includeExpired');
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
    bool? includeExpired,
    String? sortBy,
    String? sortOrder,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    final url = _buildClaimedRewardsUrl(
      page: page,
      limit: limit,
      includeExpired: includeExpired,
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
}
