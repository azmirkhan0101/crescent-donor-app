import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/settings_controller.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class UpdateRecurringDonationController extends GetxController {
  final settingsController = Get.find<SettingsController>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<bool> updateRecurringDonation({
    required String recurringDonationId,
    required double amount,
    required String frequency,
    required String specialMessage,
    Map<String, dynamic>? customInterval,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    final body = {
      "amount": amount,
      "frequency": frequency,
      "specialMessage": specialMessage,
    };

    if (frequency.toLowerCase() == 'custom' && customInterval != null) {
      body['customInterval'] = customInterval;
    }

    final result = await Get.find<NetworkHelper>().request(
      'PATCH',
      ApiUrl.updateOrCancelRecurringDonation(recurringDonationId),
      body: body,
      withAuth: true,
    );
    isLoading.value = false;

    return result.fold(
      (failure) {
        errorMessage.value =
            failure.message ?? 'Failed to update recurring donation';
        ToastMsg.error(errorMessage.value);
        return false;
      },
      (response) {
        ToastMsg.success('Recurring donation updated successfully');
        return true;
      },
    );
  }
}
