import 'package:cresent_charge_user_app/features/common/models/meta_model.dart';
import 'package:cresent_charge_user_app/features/rewards/models/business_rewards_models.dart';
import 'package:cresent_charge_user_app/features/rewards/models/reward_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GetBusinessRewardsController extends GetxController {
  final NetworkHelper networkHelper = Get.find<NetworkHelper>();

  var rewards = <RewardModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var meta = Rx<MetaModel?>(null);

  String _buildBusinessRewardsUrl(
    String businessId, {
    int? page,
    int? limit,
    String? status,
  }) {
    final params = <String>[];

    if (page != null) {
      params.add('page=$page');
    }
    if (limit != null) {
      params.add('limit=$limit');
    }
    if (status != null && status.isNotEmpty) {
      params.add('status=$status');
    }

    final query = params.isEmpty ? '' : '?${params.join('&')}';
    return '${ApiUrl.getBusinessRewards(businessId)}$query';
  }

  Future<void> fetchBusinessRewards(
    String businessId, {
    int? page,
    int? limit,
    String? status,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    final url = _buildBusinessRewardsUrl(
      businessId,
      page: page,
      limit: limit,
      status: status,
    );

    final response = await networkHelper.request('GET', url, withAuth: true);

    isLoading.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error fetching business rewards: ${error.message}');
      },
      (data) {
        final businessRewardsResponse = BusinessRewardsResponse.fromJson(data);
        rewards.assignAll(businessRewardsResponse.data);
        meta.value = businessRewardsResponse.meta;
        debugPrint(
          'Business rewards fetched successfully: ${rewards.length} items',
        );
      },
    );
  }
}
