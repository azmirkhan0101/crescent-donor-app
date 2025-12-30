import 'package:cresent_charge_user_app/features/home/models/cause_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class CausesController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchAllCauses();
  }

  /// ------------------------------------
  /// Fetch all Causes
  /// ------------------------------------
  // Observable variables
  RxBool fetchingAllCauses = false.obs;
  RxString fetchingAllCausesErrorMessage = ''.obs;

  // Store causes data
  RxList<CauseData> causes = RxList<CauseData>([]);

  // Fetch all causes from API
  Future<bool> fetchAllCauses() async {
    fetchingAllCausesErrorMessage.value = '';
    fetchingAllCauses.value = true;

    final result = await Get.find<NetworkHelper>().request(
      'GET',
      ApiUrl.getAllCauses,
      parser: (data) => CauseResponseModel.fromJson(data),
      withAuth: true,
    );
    return result.fold(
      (err) {
        fetchingAllCausesErrorMessage.value =
            err.message ?? 'Failed to load causes';
        return false;
      },
      (data) {
        causes.value = data.data;
        return true;
      },
    );
  }

  // /// ------------------------------------
  // /// Fetch all Causes by organization id
  // /// ------------------------------------
  // // Observable variables
  // RxBool fetchingCausesByOrgId = false.obs;
  // RxString fetchingCausesByOrgIdErrorMessage = ''.obs;

  // // Store causes data
  // RxList<CauseData> causesByOrgId = RxList<CauseData>([]);
  // // Fetch all causes from API
  // Future<bool> fetchCausesByOrgId(String orgId) async {
  //   fetchingCausesByOrgIdErrorMessage.value = '';
  //   fetchingCausesByOrgId.value = true;

  //   final result = await Get.find<NetworkHelper>().request(
  //     'GET',
  //     ApiUrl.getAllCausesByOrgId(orgId),
  //     parser: (data) => CauseResponseModel.fromJson(data),
  //     withAuth: true,
  //   );
  //   return result.fold(
  //     (err) {
  //       fetchingCausesByOrgIdErrorMessage.value =
  //           err.message ?? 'Failed to load causes';
  //       return false;
  //     },
  //     (data) {
  //       causesByOrgId.value = data.data;
  //       return true;
  //     },
  //   );
  // }


}
