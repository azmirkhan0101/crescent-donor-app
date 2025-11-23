import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/home/models/organization_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class GetOrgsController extends GetxController {
  // Observable variables
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  // Store organizations data
  final List<OrganizationModel> organizations = [];

  // Fetch all organizations from API
  Future<bool> fetchAllOrganizations() async {
    errorMessage.value = '';
    isLoading.value = true;

    final result = await Get.find<NetworkHelper>().request(
      'GET',
      ApiUrl.getAllOrganizations,
      parser: (data) => OrganizationResponseModel.fromJson(data),
      withAuth: true,
    );

    isLoading.value = false;

    return result.fold(
      (err) {
        errorMessage.value = err.message ?? 'Failed to load organizations';
        ToastMsg.error(errorMessage.value);
        return false;
      },
      (data) {
        ToastMsg.success(data.message);
        organizations.clear();
        organizations.addAll(data.data);
        return true;
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllOrganizations();
  }
}
