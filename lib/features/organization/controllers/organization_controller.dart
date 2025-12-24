import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/common/models/meta_model.dart';
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
  RxBool isLoadingMore = false.obs;
  RxString fetchingAllOrgsErrMsg = ''.obs;

  var organizationsList = <OrganizationModel>[].obs;
  var currentMeta = Rx<MetaModel?>(null);

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
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      fetchingAllOrgsErrMsg.value = '';
      isFetchingAllOrgs.value = true;
    }

    // Build query parameters
    final params = <String>[];
    if (searchTerm != null && searchTerm.isNotEmpty) {
      params.add('searchTerm=$searchTerm');
    }
    if (country != null && country.isNotEmpty) {
      params.add('country=$country');
    }
    if (state != null && state.isNotEmpty) {
      params.add('state=$state');
    }
    if (serviceType != null && serviceType.isNotEmpty) {
      params.add('serviceType=$serviceType');
    }
    if (isProfileVisible != null) {
      params.add('isProfileVisible=$isProfileVisible');
    }
    if (dateFrom != null && dateFrom.isNotEmpty) {
      params.add('dateFrom=$dateFrom');
    }
    if (dateTo != null && dateTo.isNotEmpty) {
      params.add('dateTo=$dateTo');
    }
    if (page != null) {
      params.add('page=$page');
    }
    if (limit != null) {
      params.add('limit=$limit');
    }
    if (sort != null && sort.isNotEmpty) {
      params.add('sort=$sort');
    }
    if (fields != null && fields.isNotEmpty) {
      params.add('fields=$fields');
    }
    if (status != null && status.isNotEmpty) {
      params.add('status=$status');
    }
    if (populateCauses != null) {
      params.add('populateCauses=$populateCauses');
    }

    final query = params.isEmpty ? '' : '?${params.join('&')}';
    final url = '${ApiUrl.getAllOrganizations}$query';

    final result = await _networkHelper.request(
      'GET',
      url,
      parser: (data) => OrganizationResponseModel.fromJson(data),
      withAuth: true,
    );

    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isFetchingAllOrgs.value = false;
    }

    return result.fold(
      (err) {
        fetchingAllOrgsErrMsg.value =
            err.message ?? 'Failed to load organizations';
        ToastMsg.error(fetchingAllOrgsErrMsg.value);
        return false;
      },
      (data) {
        currentMeta.value = data.meta;
        if (isLoadMore) {
          organizationsList.addAll(data.data);
          update();
        } else {
          organizationsList.clear();
          organizationsList.addAll(data.data);
        }
        return true;
      },
    );
  }

  bool get hasMoreData {
    if (currentMeta.value == null) return false;
    return currentMeta.value!.page < currentMeta.value!.totalPage;
  }

  Future<void> loadMoreOrganizations() async {
    if (!hasMoreData || isLoadingMore.value) return;
    final nextPage = (currentMeta.value!.page) + 1;
    await fetchAllOrganizations(page: nextPage, isLoadMore: true);
  }

  ///==============================================
  /// fetch Organization details by ID
  ///==============================================
  final RxBool isLoadingOrgById = false.obs;
  final RxString error = ''.obs;

  final Rx<OrganizationDetailsModel?> organizationDetails =
      Rx<OrganizationDetailsModel?>(null);

  Future<void> fetchOrganizationDetails(String orgId) async {
    isLoadingOrgById.value = true;
    error.value = '';

    final result = await _networkHelper.request(
      'GET',
      ApiUrl.getOrganizationDetails(orgId),
      parser: (data) => OrganizationDetailsModel.fromJson(data['data']),
    );

    isLoadingOrgById.value = false;

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
