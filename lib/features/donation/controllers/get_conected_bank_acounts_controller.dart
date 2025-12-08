import 'package:cresent_charge_user_app/features/donation/models/connected_account_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class GetConnectedBankAccounts extends GetxController {
  /// ---------------------------------------------------------------
  /// Get Bank Connection
  /// ---------------------------------------------------------------
  final _connectedAccountList = <BankAccountModel>[].obs;
  final RxBool _isBankConnectionLoading = false.obs;
  final RxString _bankConnectionError = ''.obs;

  List<BankAccountModel> get connectedAccountsDataModel =>
      _connectedAccountList;
  RxBool get isBankConnectionLoading => _isBankConnectionLoading;
  RxString get bankConnectionError => _bankConnectionError;

  Future<bool> getConnectedBankAccounts() async {
    _isBankConnectionLoading.value = true;
    _bankConnectionError.value = '';

    final result = await Get.find<NetworkHelper>().request(
      'GET',
      ApiUrl.getConnectedAccounts,
      parser: (data) => data["data"]
          .map<BankAccountModel>((item) => BankAccountModel.fromJson(item))
          .toList(),
    );

    _isBankConnectionLoading.value = false;

    return result.fold(
      (failure) {
        _bankConnectionError.value =
            failure.message ?? 'Failed to get bank connection';
        return false;
      },
      (response) {
        _connectedAccountList.value = response;
        return true;
      },
    );
  }
}
