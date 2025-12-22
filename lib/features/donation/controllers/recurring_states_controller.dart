import 'package:cresent_charge_user_app/features/donation/models/recurring_states_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class RecurringStatesController extends GetxController {
  var isLoading = false.obs;
  var errorMsg = ''.obs;
  var recurringStates = Rx<RecurringStatesModel?>(null);

  Future<bool> fetchRecurringStates() async {
    isLoading.value = true;
    errorMsg.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'Get',
      "${ApiUrl.baseUrl}/client/recurring-stats",
    );

    isLoading.value = false;

    return response.fold(
      (err) {
        errorMsg.value = err.message ?? '';
        return false;
      },
      (data) {
        recurringStates.value = RecurringStatesModel.fromJson(data['data']);
        return true;
      },
    );
  }
}
