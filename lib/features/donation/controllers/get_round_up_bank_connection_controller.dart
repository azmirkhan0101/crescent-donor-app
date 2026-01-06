import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/donation/models/connected_account_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GetRoundUpBankConnection extends GetxController {
  var selectedRoundUpModelIndex = 0.obs;

  void changeRoundUpModelIndex(int index) {
    selectedRoundUpModelIndex.value = index;
  }

  /// ---------------------------------------------------------------
  /// basiq states
  /// ---------------------------------------------------------------
  var isBasiqConnectionLoading = false.obs;

  /// ---------------------------------------------------------------
  /// Get round-up bank connection
  /// ---------------------------------------------------------------
  var roundUpBankConnectionModel = <RoundUpBankConnectionModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<bool> fetchRoundUpBankConnection() async {
    // _isBankConnectionLoading.value = true;
    // _bankConnectionError.value = '';
    isLoading.value = true;
    errorMessage.value = '';

    final result = await Get.find<NetworkHelper>().request(
      'GET',
      ApiUrl.url('bank-connection/accounts'),
      withAuth: true,
    );

    // _isBankConnectionLoading.value = false;
    isLoading.value = false;

    return result.fold(
      (failure) {
        // _bankConnectionError.value =
        //     failure.message ?? 'Failed to get bank connection';
        // errorMessage.value = _bankConnectionError.value;
        // ToastMsg.error(_bankConnectionError.value);
        errorMessage.value = failure.message ?? 'Failed to get bank connection';
        ToastMsg.error(errorMessage.value);
        return false;
      },
      (response) async {
        final List<dynamic> dataList = response['data'] as List<dynamic>;
        final accounts = dataList
            .map(
              (data) => RoundUpBankConnectionModel.fromJson(
                data as Map<String, dynamic>,
              ),
            )
            .toList();

        // Update both variables to keep them in sync
        // _connectedAccountList.assignAll(accounts);
        roundUpBankConnectionModel.assignAll(accounts);

        // check if any account is provider 'Basiq'
        final hasBasiqAccount = accounts.any(
          (account) => account.provider.toLowerCase() == 'basiq',
        );
        if (hasBasiqAccount) {
          debugPrint('Basiq bank connection successful!');
          isBasiqConnectionLoading.value = false;
        } else {
          debugPrint('No Basiq bank connection found.');
          await Future.delayed(const Duration(seconds: 5));
          isBasiqConnectionLoading.value = true;
          fetchRoundUpBankConnection();
        }

        return true;
      },
    );
  }
}
