import 'package:cresent_charge_user_app/features/common/models/meta_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ClaimedRewardModel {
  final String id;
  final String rewardId;
  final String userId;
  final String code;
  final String codeType;
  final DateTime claimedAt;
  final DateTime? expiresAt;
  final bool isUsed;
  final DateTime? usedAt;
  final Map<String, dynamic>? reward;

  ClaimedRewardModel.fromJson(Map<String, dynamic> json)
    : id = json['_id'],
      rewardId = json['rewardId'],
      userId = json['userId'],
      code = json['code'],
      codeType = json['codeType'],
      claimedAt = DateTime.parse(json['claimedAt']),
      expiresAt = json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'])
          : null,
      isUsed = json['isUsed'] ?? false,
      usedAt = json['usedAt'] != null ? DateTime.parse(json['usedAt']) : null,
      reward = json['reward'];
}

class ClaimedRewardsResponse {
  final bool success;
  final String message;
  final MetaModel meta;
  final List<ClaimedRewardModel> data;

  ClaimedRewardsResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'],
      message = json['message'],
      meta = MetaModel.fromJson(json['meta']),
      data = (json['data'] as List)
          .map((e) => ClaimedRewardModel.fromJson(e))
          .toList();
}

class GetMyClaimedRewardsController extends GetxController {
  final NetworkHelper networkHelper = Get.find<NetworkHelper>();

  var claimedRewards = <ClaimedRewardModel>[].obs;
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
        final claimedRewardsResponse = ClaimedRewardsResponse.fromJson(data);
        claimedRewards.assignAll(claimedRewardsResponse.data);
        meta.value = claimedRewardsResponse.meta;
        debugPrint(
          'Claimed rewards fetched successfully: ${claimedRewards.length} items',
        );
      },
    );
  }
}
