import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DonationCompleteController extends GetxController {
  // Donation summary data
  final RxString _amountDonated = 'Round Up'.obs;
  final RxString _organization = 'Healing Hands International'.obs;
  final RxString _donationType = 'One-Time'.obs;
  final RxString _specialMessage =
      '"Sending love & hope to everyone you\'re helping 💛."'.obs;
  final RxString _timestamp = ''.obs;
  final RxString _transactionId = '8FSD-4829-ACDF'.obs;

  // Getters
  String get amountDonated => _amountDonated.value;
  String get organization => _organization.value;
  String get donationType => _donationType.value;
  String get specialMessage => _specialMessage.value;
  String get timestamp => _timestamp.value;
  String get transactionId => _transactionId.value;

  @override
  void onInit() {
    super.onInit();
    _generateTimestamp();

    // Get donation data from previous page if passed
    final donationData = Get.arguments as Map<String, dynamic>?;
    if (donationData != null) {
      _amountDonated.value = donationData['amount'] ?? 'Round Up';
      _organization.value =
          donationData['organization'] ?? 'Healing Hands International';
      _donationType.value = donationData['type'] ?? 'One-Time';
      _specialMessage.value =
          donationData['message'] ??
          '"Sending love & hope to everyone you\'re helping 💛."';
    }
  }

  void _generateTimestamp() {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM d, yyyy · h:mm a');
    _timestamp.value = formatter.format(now);
  }

  void onDonePressed() {
    // Navigate back to home and clear all donation-related pages from stack
    Get.offAllNamed('/home');
  }

  void onClosePressed() {
    // Close the page and go back to home
    Get.offAllNamed('/home');
  }
}
