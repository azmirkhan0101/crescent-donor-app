import 'package:cresent_charge_user_app/features/rewards/models/cancel_redemption_models.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CancelRedemptionController extends GetxController {
  final NetworkHelper networkHelper = Get.find<NetworkHelper>();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;
  var cancelResult = Rx<CancelRedemptionData?>(null);

  Future<bool> cancelRedemption(String redemptionId, String reason) async {
    isLoading.value = true;
    errorMessage.value = '';
    successMessage.value = '';
    cancelResult.value = null;

    final requestBody = {'reason': reason};

    final response = await networkHelper.request(
      'POST',
      ApiUrl.cancelRedemption(redemptionId),
      body: requestBody,
      withAuth: true,
    );

    isLoading.value = false;

    return response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error canceling redemption: ${error.message}');
        return false;
      },
      (data) {
        try {
          final cancelResponse = CancelRedemptionResponse.fromJson(data);
          successMessage.value = cancelResponse.message;
          cancelResult.value = cancelResponse.data;
          debugPrint(
            'Redemption canceled successfully: ${cancelResponse.message}',
          );
          return true;
        } catch (e) {
          successMessage.value = 'Redemption canceled successfully';
          debugPrint('Redemption canceled successfully');
          return true;
        }
      },
    );
  }
}
