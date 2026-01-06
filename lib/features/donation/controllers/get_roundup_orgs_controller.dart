import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/donation/models/roundup_org_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

/// GET: {{baseUrl}}/secure-roundup/get-organizations
/// Response: {
///     "success": true,
///     "message": "All organization Fetched successfully for user roundup.",
///     "data": [
///         {
///             "orgName": "Mason and Frederick Plc",
///             "registeredCharityName": "",
///             "address": "Enim provident mini",
///             "state": "California",
///             "country": "",
///             "logoImage": "https://crecent-changes.s3.ap-southeast-2.amazonaws.com/profiles/organizations/695217230ba280e9348ff993-1766989577642",
///             "coverImage": "https://crecent-changes.s3.ap-southeast-2.amazonaws.com/profiles/organizations/695217230ba280e9348ff993-1767067352294",
///             "serviceType": "charity",
///             "roundupId": "6958e57a0b6e5d533ef1c007",
///             "organizationId": "695217240ba280e9348ff995"
///         }
///     ]
/// }

class GetRoundupOrgsController extends GetxController {
  final _orgs = <RoundupOrgModel>[].obs;
  final _isLoading = false.obs;
  final _errorMessage = ''.obs;

  RxList<RoundupOrgModel> get orgs => _orgs;
  RxBool get isLoading => _isLoading;
  RxString get errorMessage => _errorMessage;

  Future<bool> fetchOrgs() async {
    _isLoading.value = true;
    _errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      "${ApiUrl.baseUrl}/secure-roundup/get-organizations",
      withAuth: true,
    );
    _isLoading.value = false;

    return response.fold(
      (error) {
        _errorMessage.value = error.message ?? 'Failed to fetch orgs';
        ToastMsg.error(_errorMessage.value);
        return false;
      },
      (data) {
        List<dynamic> dataList = data['data'] ?? [];
        // Parse the data and update _orgs
        if (dataList.isNotEmpty) {
          _orgs.value = dataList
              .map((item) => RoundupOrgModel.fromJson(item))
              .toList();
        } else {
          _orgs.clear();
        }
        return true;
      },
    );
  }
}
