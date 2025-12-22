import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/donation/models/recurring_donation_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class GetRecurringConnectionController extends GetxController {
  var recurringConnectionList = <RecurringDonationModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<bool> fetchRecurringConnection() async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await Get.find<NetworkHelper>().request(
      'GET',
      ApiUrl.getRecurringConnections,
      withAuth: true,
    );
    isLoading.value = false;

    return result.fold(
      (failure) {
        errorMessage.value = failure.message ?? 'Failed to get bank connection';
        ToastMsg.error(errorMessage.value);
        return false;
      },
      (response) {
        final List<dynamic> dataList = response['data'] as List<dynamic>;
        final connection = dataList
            .map(
              (data) =>
                  RecurringDonationModel.fromJson(data as Map<String, dynamic>),
            )
            .toList();
        recurringConnectionList.assignAll(connection);
        return true;
      },
    );
  }
}
