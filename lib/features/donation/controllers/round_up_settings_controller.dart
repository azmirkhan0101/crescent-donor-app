import 'package:cresent_charge_user_app/features/donation/models/roundup_setting_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller for managing Round Up Settings state and business logic
class RoundUpSettingsController extends GetxController {
  TextEditingController organizationController = TextEditingController();
  TextEditingController bankAccountController = TextEditingController();
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

  void changeOrganization(int index) {
    selectedOrganizationIndex.value = index;
  }

  void changeBankAccount(int index) {
    selectedBankAccountIndex.value = index;
  }

  void changeAmount(String amount) {
    selectedAmountIndex.value = amount;
  }

  void changeFrequency(String frequency) {
    selectedFrequencyIndex.value = frequency;
  }

  @override
  void onClose() {
    // Clean up any resources if needed
    super.onClose();
  }
}
