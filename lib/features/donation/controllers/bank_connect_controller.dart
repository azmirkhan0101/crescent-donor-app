import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_round_up_bank_connection_controller.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankConnectionController extends GetxController {
  /// ---------------------------------------------------------------
  /// connect Bank
  /// ---------------------------------------------------------------
  // final Rx<BancConnectionModel?> _bancConnectionModel =
  //     Rx<BancConnectionModel?>(null);
  final RxBool _isBankConnecting = false.obs;
  final RxString _bankConnectionError = ''.obs;

  // BancConnectionModel? get bancConnectionModel => _bancConnectionModel.value;
  bool get isBankConnecting => _isBankConnecting.value;
  String get bankConnectionError => _bankConnectionError.value;

  Future<bool> connectBank(String publicToken) async {
    _isBankConnecting.value = true;
    _bankConnectionError.value = '';

    final result = await Get.find<NetworkHelper>().request(
      'POST',
      ApiUrl.url('bank-connection'),
      body: {"public_token": publicToken},
      parser: (data) => data,
    );

    _isBankConnecting.value = false;

    return result.fold(
      (failure) {
        _bankConnectionError.value =
            failure.message ?? 'Failed to get bank connection';
        ToastMsg.error(_bankConnectionError.value);
        return false;
      },
      (response) {
        debugPrint('Bank Connection Response:---> $response');
        ToastMsg.success('Bank connected successfully');
        Get.find<GetRoundUpBankConnection>()
            .fetchRoundUpBankConnection(); // Refresh the connected accounts
        return true;
      },
    );
  }
}
