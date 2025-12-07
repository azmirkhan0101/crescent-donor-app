import 'package:cresent_charge_user_app/features/common/models/meta_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class InStoreRedemptionMethods {
  final bool qrCode;
  final bool staticCode;
  final bool nfcTap;

  InStoreRedemptionMethods.fromJson(Map<String, dynamic> json)
    : qrCode = json['qrCode'],
      staticCode = json['staticCode'],
      nfcTap = json['nfcTap'];
}

class RewardModel {
  final String id;
  final String? business;
  final String title;
  final String description;
  final String type;
  final String category;
  final int pointsCost;
  final int redemptionLimit;
  final int redeemedCount;
  final int remainingCount;
  final DateTime startDate;
  final DateTime expiryDate;
  final String status;
  final bool isActive;
  final InStoreRedemptionMethods inStoreRedemptionMethods;
  final bool featured;
  final int priority;
  final int views;
  final int redemptions;
  final List<dynamic> limitUpdateHistory;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isAvailable;

  RewardModel.fromJson(Map<String, dynamic> json)
    : id = json['_id'],
      business = json['business'],
      title = json['title'],
      description = json['description'],
      type = json['type'],
      category = json['category'],
      pointsCost = json['pointsCost'],
      redemptionLimit = json['redemptionLimit'],
      redeemedCount = json['redeemedCount'],
      remainingCount = json['remainingCount'],
      startDate = DateTime.parse(json['startDate']),
      expiryDate = DateTime.parse(json['expiryDate']),
      status = json['status'],
      isActive = json['isActive'],
      inStoreRedemptionMethods = InStoreRedemptionMethods.fromJson(
        json['inStoreRedemptionMethods'],
      ),
      featured = json['featured'],
      priority = json['priority'],
      views = json['views'],
      redemptions = json['redemptions'],
      limitUpdateHistory = json['limitUpdateHistory'],
      createdAt = DateTime.parse(json['createdAt']),
      updatedAt = DateTime.parse(json['updatedAt']),
      isAvailable = json['isAvailable'];
}

class RewardsResponse {
  final bool success;
  final String message;
  final MetaModel meta;
  final List<RewardModel> data;

  RewardsResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'],
      message = json['message'],
      meta = MetaModel.fromJson(json['meta']),
      data = (json['data'] as List)
          .map((e) => RewardModel.fromJson(e))
          .toList();
}

class GetAllRewardsController extends GetxController {
  final NetworkHelper networkHelper = Get.find<NetworkHelper>();

  var rewards = <RewardModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var meta = Rx<MetaModel?>(null);

  String _buildRewardsUrl({
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

    final response = await networkHelper.request('GET', url, withAuth: true);
    isLoading.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error fetching rewards: ${error.message}');
      },
      (data) {
        final rewardsResponse = RewardsResponse.fromJson(data);
        rewards.assignAll(rewardsResponse.data);
        meta.value = rewardsResponse.meta;
        debugPrint('Rewards fetched successfully: ${rewards.length} items');
      },
    );
  }
}
