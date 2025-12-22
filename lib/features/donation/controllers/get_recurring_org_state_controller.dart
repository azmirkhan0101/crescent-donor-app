import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/donation/models/recurring_org_state_data_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GetRecurringOrgStateController extends GetxController {
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var recurringOrgStateDataModel = Rx<RecurringOrgStateDataModel?>(null);

  Future<bool> fetchRecurringOrgState(String orgId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      "GET",
      ApiUrl.getRecurringOrgState(orgId),
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
        // API wraps the payload under `data`; unwrap before parsing
        final parsedData = data is Map<String, dynamic> ? data['data'] : {};
        recurringOrgStateDataModel.value = RecurringOrgStateDataModel.fromJson(
          parsedData ?? {},
        );
        // recurringOrgStateDataModel.value = RecurringOrgStateDataModel.fromJson(
        //   donationData,
        // );

        return true;
      },
    );
  }
}
