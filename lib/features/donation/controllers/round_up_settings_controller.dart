import 'package:cresent_charge_user_app/features/donation/models/roundup_setting_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller for managing Round Up Settings state and business logic
class RoundUpSettingsController extends GetxController {
  TextEditingController organizationController = TextEditingController();
  TextEditingController bankAccountController = TextEditingController();
  TextEditingController customAmountController = TextEditingController();
  TextEditingController specialMessageController = TextEditingController();
  final _networkHelper = Get.find<NetworkHelper>();
  RxList<RoundUpSettingModel> organizations = [
    RoundUpSettingModel(
      name: 'WorldVision International',
      bankAccount: 'CHASUS33 XXXXXXXXX 1234',
      thresholdAmount: '10',
      frequency: false,
    ),
    RoundUpSettingModel(
      name: 'Hope for Learning Foundation',
      bankAccount: 'CHASUS33 XXXXXXXXX 6789',
      thresholdAmount: '10',
      frequency: true,
    ),
  ].obs;

  final frequency = [
    'Daily',
    'Weekly',
    'Monthly',
    "Quarterly",
    "Yearly",
    "Custom",
  ];

  final amounts = ['\$10', '\$20', '\$30', '\$50', 'Custom', 'No Limit'];

  var selectedOrganizationIndex = 0.obs;
  var selectedBankAccountIndex = 0.obs;
  var selectedAmountIndex = '\$10'.obs;
  var selectedFrequencyIndex = 'Daily'.obs;
  RxBool isSavingConsent = false.obs;
  RxString saveConsentError = ''.obs;

  void changeOrganization(int index) {
    selectedOrganizationIndex.value = index;
  }

  void changeBankAccount(int index) {
    selectedBankAccountIndex.value = index;
  }

  void changeAmount(String amount) {
    selectedAmountIndex.value = amount;

    // Clear custom input when switching away from custom
    if (amount != 'Custom') {
      customAmountController.clear();
    }
  }

  void changeFrequency(String frequency) {
    selectedFrequencyIndex.value = frequency;
  }

  Future<bool> saveRoundUpConsent({
    required String bankConnectionId,
    required String organizationId,
    required String paymentMethodId,
    String? causeId,
    required double monthlyThreshold,
    String? specialMessage,
    bool coverFees = false,
  }) async {
    isSavingConsent.value = true;
    saveConsentError.value = '';

    final body = <String, dynamic>{
      'bankConnectionId': bankConnectionId,
      'organizationId': organizationId,
      'paymentMethodId': paymentMethodId,
      'monthlyThreshold': monthlyThreshold,
      'coverFees': coverFees,
    };

    if (causeId != null && causeId.isNotEmpty) {
      body['causeId'] = causeId;
    }

    if (specialMessage != null && specialMessage.isNotEmpty) {
      body['specialMessage'] = specialMessage;
    }

    final result = await _networkHelper.request(
      'POST',
      ApiUrl.saveRoundupConsent,
      body: body,
      withAuth: true,
    );

    isSavingConsent.value = false;

    return result.fold(
      (failure) {
        saveConsentError.value = failure.message ?? 'Failed to save consent';
        return false;
      },
      (_) {
        return true;
      },
    );
  }

  @override
  void onClose() {
    organizationController.dispose();
    bankAccountController.dispose();
    customAmountController.dispose();
    specialMessageController.dispose();
    super.onClose();
  }
}
