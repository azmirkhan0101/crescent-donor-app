import 'package:cresent_charge_user_app/features/organization/models/organization_details_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class OrganizationDetailsController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<OrganizationDetailsModel?> organizationDetails =
      Rx<OrganizationDetailsModel?>(null);
  final RxString error = ''.obs;
  final NetworkHelper _networkHelper = Get.find<NetworkHelper>();

  /// Fetch organization details from API
  Future<void> fetchOrganizationDetails(String orgId) async {
    isLoading.value = true;
    error.value = '';

    final result = await _networkHelper.request(
      'GET',
      ApiUrl.getOrganizationDetails(orgId),
      parser: (data) => OrganizationDetailsModel.fromJson(data['data']),
    );

    isLoading.value = false;

    result.fold(
      (failure) {
        error.value = failure.message ?? 'Failed to load organization details';
      },
      (response) {
        organizationDetails.value = response;
        update();
      },
    );
  }
}
