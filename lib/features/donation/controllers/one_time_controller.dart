import 'package:cresent_charge_user_app/features/donation/models/one_time_states_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class OneTimeController extends GetxController {
  var oneTimeStates = Rxn<OneTimeStatesModel>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<bool> fetchOneTimeStates() async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      ApiUrl.getOneTimeStates,
      withAuth: true,
    );

    isLoading.value = false;
    return response.fold(
      (error) {
        errorMessage.value =
            error.message ?? 'Failed to fetch one-time donation stats';
        return false;
      },
      (data) {
        // Process the data and update oneTimeStates
        oneTimeStates.value = OneTimeStatesModel.fromJson(data);
        return true;
      },
    );
  }
}
