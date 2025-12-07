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

class RewardDetailModel {
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
  final int availableCodesCount;
  final bool isAvailable;
  final bool userCanAfford;
  final int userBalance;
  final bool hasAlreadyClaimed;

  RewardDetailModel.fromJson(Map<String, dynamic> json)
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
      availableCodesCount = json['availableCodesCount'],
      isAvailable = json['isAvailable'],
      userCanAfford = json['userCanAfford'],
      userBalance = json['userBalance'],
      hasAlreadyClaimed = json['hasAlreadyClaimed'];
}

class RewardDetailResponse {
  final bool success;
  final String message;
  final RewardDetailModel data;

  RewardDetailResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'],
      message = json['message'],
      data = RewardDetailModel.fromJson(json['data']);
}

class GetRewardDetailController extends GetxController {
  final NetworkHelper networkHelper = Get.find<NetworkHelper>();

  var rewardDetail = Rx<RewardDetailModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchRewardDetail(String rewardId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await networkHelper.request(
      'GET',
      ApiUrl.getRewardDetails(rewardId),
      withAuth: true,
    );

    isLoading.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error fetching reward detail: ${error.message}');
      },
      (data) {
        final rewardDetailResponse = RewardDetailResponse.fromJson(data);
        rewardDetail.value = rewardDetailResponse.data;
        debugPrint(
          'Reward detail fetched successfully: ${rewardDetail.value?.title}',
        );
      },
    );
  }
}
