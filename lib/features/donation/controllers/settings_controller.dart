import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller for managing Round Up Settings state and business logic
class SettingsController extends GetxController {
  TextEditingController organizationController = TextEditingController();
  TextEditingController bankAccountController = TextEditingController();
  TextEditingController customAmountController = TextEditingController();
  TextEditingController specialMessageController = TextEditingController();

  final List<String> frequency = [
    'Daily',
    'Weekly',
    'Monthly',
    'Quarterly',
    'Yearly',
    'Custom',
  ];

  // final amounts = ['10', '20', '30', '50', 'Custom'];
  final thresholdAmounts = [
    {'10': 10.00},
    {'20': 20.00},
    {'30': 30.00},
    {'50': 50.00},
    {'Custom': 0.00},
  ];

  var selectedRoundUpModelIndex = 0.obs;
  var selectedRecurringConnectionIndex = 0.obs;
  RxString selectedFrequency = ''.obs;
  var customInterval = {"unit": "days", "value": 2}.obs;
  var selectedAmountIndex = 0.obs;

  void changeRoundUpModelIndex(int index) {
    selectedRoundUpModelIndex.value = index;
  }

  void changeOrganization(int index) {
    selectedOrganizationIndex.value = index;
  }

  void changeFrequency(String frequency) {
    selectedFrequency.value = frequency.toLowerCase();
  }

  void changeCustomInterval(String unit, int value) {
    customInterval.value = {"unit": unit, "value": value};
    print('Custom Interval updated: $customInterval');
  }

  var selectedOrganizationIndex = 0.obs;
  RxBool isSavingConsent = false.obs;
  RxString saveConsentError = ''.obs;

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

    final result = await Get.find<NetworkHelper>().request(
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

  ///=======================================================
  /// Get Recurring
  ///=======================================================

  @override
  void onClose() {
    organizationController.dispose();
    bankAccountController.dispose();
    customAmountController.dispose();
    specialMessageController.dispose();
    super.onClose();
  }
}
