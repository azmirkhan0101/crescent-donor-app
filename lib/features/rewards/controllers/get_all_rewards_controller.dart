import 'package:cresent_charge_user_app/features/common/models/meta_model.dart';
import 'package:cresent_charge_user_app/features/rewards/models/reward_model.dart';
import 'package:cresent_charge_user_app/features/rewards/models/rewards_response.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GetAllRewardsController extends GetxController {
  var rewards = <RewardModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var meta = Rx<MetaModel?>(null);

  String _buildRewardsUrl({
    String? businessId,
    int? page,
    int? limit,
    String? type,
    String? category,
    String? status,
    bool? featured,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) {
    final params = <String>[];

    if (businessId != null && businessId.isNotEmpty) {
      params.add('businessId=$businessId');
    }

    if (page != null) {
      params.add('page=$page');
    }
    if (limit != null) {
      params.add('limit=$limit');
    }
    if (type != null && type.isNotEmpty) {
      params.add('type=$type');
    }
    if (category != null && category.isNotEmpty) {
      params.add('category=$category');
    }
    if (status != null && status.isNotEmpty) {
      params.add('status=$status');
    }
    if (featured != null) {
      params.add('featured=$featured');
    }
    if (search != null && search.isNotEmpty) {
      params.add('search=$search');
    }
    if (sortBy != null && sortBy.isNotEmpty) {
      params.add('sortBy=$sortBy');
    }
    if (sortOrder != null && sortOrder.isNotEmpty) {
      params.add('sortOrder=$sortOrder');
    }

    final query = params.isEmpty ? '' : '?${params.join('&')}';
    return '${ApiUrl.getRewards}$query';
  }

  Future<void> fetchRewards({
    String? businessId,
    int? page,
    int? limit,
    String? type,
    String? category,
    String? status,
    bool? featured,
    String? search,
    String? sortBy,
    String? sortOrder,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    final url = _buildRewardsUrl(
      businessId: businessId,
      page: page,
      limit: limit,
      type: type,
      category: category,
      status: status,
      featured: featured,
      search: search,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      url,
      withAuth: true,
    );
    isLoading.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error fetching rewards: ${error.message}');
      },
      (data) {
        debugPrint('Full API Response: $data');
        final rewardsResponse = RewardsResponse.fromJson(data);
        rewards.assignAll(rewardsResponse.data);
        meta.value = rewardsResponse.meta;
        if (rewards.isNotEmpty) {
          final first = rewards.first;
          debugPrint(
            'First reward: userStatus=${first.userStatus}, claimStatus=${first.claimStatus}, isAlreadyClaimed=${first.isAlreadyClaimed}, isAlreadyRedeemed=${first.isAlreadyRedeemed}',
          );
        }
        debugPrint('Rewards fetched successfully: ${rewards.length} items');
      },
    );
  }
}
