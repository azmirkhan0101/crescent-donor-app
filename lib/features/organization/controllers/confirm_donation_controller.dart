import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ConfirmDonationController extends GetxController {
  // Donation details
  final RxString _donationAmount = ''.obs;
  final RxString _organizationName = 'Healing Hands International'.obs;
  final RxString _donationType = 'Round Up'.obs;
  final RxString _donationCause = 'Youth'.obs;
  final RxString _thresholdAmount = '\$10'.obs;
  final RxString _specialMessage =
      '"Sending love & hope to everyone you\'re helping 💛."'.obs;
  final RxString _fromUser = 'Talha S.'.obs;
  final RxString _cardNumber = '9252 **** **** 5988'.obs;
  final RxString _taxesAndFees = '\$0.5'.obs;
  final RxBool _contributeToAdminFees = true.obs;

  // Getters
  String get donationAmount => _donationAmount.value;
  String get organizationName => _organizationName.value;
  String get donationType => _donationType.value;
  String get donationCause => _donationCause.value;
  String get thresholdAmount => _thresholdAmount.value;
  String get specialMessage => _specialMessage.value;
  String get fromUser => _fromUser.value;
  String get cardNumber => _cardNumber.value;
  String get taxesAndFees => _taxesAndFees.value;
  bool get contributeToAdminFees => _contributeToAdminFees.value;

  @override
  void onInit() {
    super.onInit();
    // Get donation amount from previous page if passed
    final amount = Get.arguments as String?;
    if (amount != null && amount.isNotEmpty) {
      _donationAmount.value = amount;
    }
  }

  void toggleAdminFeesContribution() {
    _contributeToAdminFees.value = !_contributeToAdminFees.value;
  }

  void onEditDetails() {
    // Navigate back to edit details
    Get.back();
  }

  void onConfirmDonation(BuildContext context) {
    // Handle donation confirmation
    // TODO: Implement donation processing logic

    // Prepare donation data for completion page
    final donationData = {
      'amount': donationAmount.isNotEmpty ? '\$$donationAmount' : 'Round Up',
      'organization': organizationName,
      'type': donationType,
      'message': specialMessage,
    };

    // Navigate to donation complete page using GoRouter
    context.goNamed(RoutePath.donationComplete, extra: donationData);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
