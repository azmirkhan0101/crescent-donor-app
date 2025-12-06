import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/home/models/organization_model.dart';
import 'package:cresent_charge_user_app/features/organization/models/organization_details_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class OrganizationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchAllOrganizations();
  }

  final NetworkHelper _networkHelper = Get.find<NetworkHelper>();

  ///==============================================
  /// Fetch All Organizations
  ///==============================================
  RxBool isFetchingAllOrgs = false.obs;
  RxString fetchingAllOrgsErrMsg = ''.obs;

  var organizationsList = <OrganizationModel>[].obs;

  Future<bool> fetchAllOrganizations({
    String? searchTerm,
    String? country,
    String? state,
    String? serviceType,
    bool? isProfileVisible,
    String? dateFrom,
    String? dateTo,
    int? page,
    int? limit,
    String? sort,
    String? fields,
    String? status,
    bool? populateCauses,
  }) async {
    fetchingAllOrgsErrMsg.value = '';
    isFetchingAllOrgs.value = true;

    final result = await _networkHelper.request(
      'GET',
      ApiUrl.getAllOrganizations(
        searchTerm: searchTerm,
        country: country,
        state: state,
        serviceType: serviceType,
        isProfileVisible: isProfileVisible,
        dateFrom: dateFrom,
        dateTo: dateTo,
        page: page,
        limit: limit,
        sort: sort,
        fields: fields,
        status: status,
        populateCauses: populateCauses,
      ),
      parser: (data) => OrganizationResponseModel.fromJson(data),
      withAuth: true,
    );

    isFetchingAllOrgs.value = false;

    return result.fold(
      (err) {
        fetchingAllOrgsErrMsg.value =
            err.message ?? 'Failed to load organizations';
        ToastMsg.error(fetchingAllOrgsErrMsg.value);
        return false;
      },
      (data) {
        ToastMsg.success(data.message);
        organizationsList.clear();
        organizationsList.addAll(data.data);
        return true;
      },
    );
  }

  ///==============================================
  /// fetch Organization details by ID
  ///==============================================
  final RxBool isOrgDetailsFetching = false.obs;
  final RxString error = ''.obs;

  final Rx<OrganizationDetailsModel?> organizationDetails =
      Rx<OrganizationDetailsModel?>(null);

  Future<void> fetchOrganizationDetails(String orgId) async {
    isOrgDetailsFetching.value = true;
    error.value = '';

    final result = await _networkHelper.request(
      'GET',
      ApiUrl.getOrganizationDetails(orgId),
      parser: (data) => OrganizationDetailsModel.fromJson(data['data']),
    );

    isOrgDetailsFetching.value = false;

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
