import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class CancelRecurringDonationController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<bool> cancelRecurringDonation(String recurringDonationId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await Get.find<NetworkHelper>().request(
      'DELETE',
      ApiUrl.updateOrCancelRecurringDonation(recurringDonationId),
      withAuth: true,
    );

    isLoading.value = false;

    return result.fold(
      (failure) {
        errorMessage.value =
            failure.message ?? 'Failed to cancel recurring donation';
        ToastMsg.error(errorMessage.value);
        return false;
      },
      (response) {
        return true;
      },
    );
  }
}
