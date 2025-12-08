import 'package:cresent_charge_user_app/features/rewards/models/redemption_detail_models.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class GetRedemptionDetailController extends GetxController {
  final NetworkHelper networkHelper = Get.find<NetworkHelper>();

  var redemptionDetail = Rx<RedemptionDetailModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchRedemptionDetail(String redemptionId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await networkHelper.request(
      'GET',
      ApiUrl.getRedemptionDetails(redemptionId),
      withAuth: true,
    );

    isLoading.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error fetching redemption detail: ${error.message}');
      },
      (data) {
        final redemptionDetailResponse = RedemptionDetailResponse.fromJson(
          data,
        );
        redemptionDetail.value = redemptionDetailResponse.data;
        debugPrint(
          'Redemption detail fetched successfully: ${redemptionDetail.value?.assignedCode}',
        );
      },
    );
  }
}
