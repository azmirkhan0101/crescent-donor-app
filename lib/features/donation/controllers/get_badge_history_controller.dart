import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/donation/models/badge_history_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GetBadgeHistoryController extends GetxController {
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var badgeHistoryModel = Rx<BadgeHistoryModel?>(null);

  Future<bool> fetchBadgeHistory(String badgeId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      "GET",
      ApiUrl.getBadgeHistory(badgeId),
      withAuth: true,
    );
    isLoading.value = false;

    return response.fold(
      (err) {
        errorMessage.value = err.message ?? 'Badges progress fetch failed';
        debugPrint('Error fetching badges progress: ${err.message}');
        ToastMsg.error(errorMessage.value);
        return false;
      },
      (data) {
        badgeHistoryModel.value = BadgeHistoryModel.fromJson(data);
        return true;
      },
    );
  }
}
