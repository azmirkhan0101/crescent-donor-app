import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/features/organization/models/one_time_donation_request.dart';
import 'package:cresent_charge_user_app/features/organization/models/one_time_donation_response.dart';
import 'package:cresent_charge_user_app/features/organization/models/payment_method_model.dart';
import 'package:cresent_charge_user_app/features/payment/controllers/payment_method_controller.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ConfirmDonationController extends GetxController {
  final NetworkHelper _networkHelper = Get.find<NetworkHelper>();
  final RxBool isProcessing = false.obs;
  final RxString errorMessage = ''.obs;
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

  // Payment method
  Rx<PaymentMethodModel?> _selectedPaymentMethod = Rx<PaymentMethodModel?>(
    null,
  );
  String? _paymentMethodId;

  // Getters
  String get donationAmount => _donationAmount.value;
  String get organizationName => _organizationName.value;
  String get donationType => _donationType.value;
  String get donationCause => _donationCause.value;
  String get thresholdAmount => _thresholdAmount.value;
  String get specialMessage => _specialMessage.value;
  String get fromUser => _fromUser.value;
  String get cardNumber => _cardNumber.value;
  String get cardDisplayName {
    final paymentMethod = _selectedPaymentMethod.value;
    if (paymentMethod != null) {
      return '${paymentMethod.cardBrand.toUpperCase()} •••• ${paymentMethod.cardLast4}';
    }
    return _cardNumber.value;
  }

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

  void initializeWithPaymentMethod(String? paymentMethodId) {
    if (paymentMethodId != null) {
      _paymentMethodId = paymentMethodId;
      _loadPaymentMethodDetails();
    }
  }

  void _loadPaymentMethodDetails() {
    if (_paymentMethodId == null) return;

    // Get payment method from PaymentMethodController
    final paymentController = Get.find<PaymentMethodController>();
    final paymentMethod = paymentController.paymentMethods.firstWhereOrNull(
      (method) => method.id == _paymentMethodId,
    );

    if (paymentMethod != null) {
      _selectedPaymentMethod.value = paymentMethod;
      print(
        'Payment Method loaded: ${paymentMethod.cardBrand} •••• ${paymentMethod.cardLast4}',
      );
    }
  }

  void updatePaymentMethod(PaymentMethodModel paymentMethod) {
    _selectedPaymentMethod.value = paymentMethod;
  }

  void toggleAdminFeesContribution() {
    _contributeToAdminFees.value = !_contributeToAdminFees.value;
  }

  void onEditDetails() {
    // Navigate back to edit details
    Get.back();
  }

  Future<void> onConfirmDonation(
    BuildContext context, {
    required int amount,
    required String organizationId,
    required String causeId,
    String? specialMessage,
  }) async {
    // Validate payment method
    final paymentMethod = _selectedPaymentMethod.value;
    if (paymentMethod == null || _paymentMethodId == null) {
      _showError(context, 'Please select a payment method');
      return;
    }

    // Validate amount
    if (amount <= 0) {
      _showError(context, 'Please enter a valid donation amount');
      return;
    }

    // Validate organization and cause
    if (organizationId.isEmpty || causeId.isEmpty) {
      _showError(context, 'Missing organization or cause information');
      return;
    }

    isProcessing.value = true;
    errorMessage.value = '';

    try {
      // Create donation request
      final request = OneTimeDonationRequest(
        amount: amount,
        currency: 'usd',
        organizationId: organizationId,
        causeId: causeId,
        paymentMethodId: _paymentMethodId!,
        specialMessage: specialMessage,
      );

      if (kDebugMode) {
        print('Creating donation: ${request.toJson()}');
      }

      // Call API
      final result = await _networkHelper.request(
        'POST',
        ApiUrl.oneTimeDonationCreate,
        body: request.toJson(),
        parser: (data) => OneTimeDonationResponse.fromJson(data),
      );

      result.fold(
        (failure) {
          // Handle error
          errorMessage.value = failure.message ?? 'Failed to process donation';
          if (kDebugMode) {
            print('Donation error: ${failure.message}');
          }
          _showError(context, errorMessage.value);
        },
        (response) {
          // Success
          if (kDebugMode) {
            print('Donation successful: ${response.message}');
          }

          // Prepare donation data for completion page
          final donationData = {
            'amount': '\$$amount',
            'organization': organizationName,
            'type': donationType,
            'message': specialMessage ?? '',
            'donationId': response.data?.id ?? '',
            'status': response.data?.status ?? 'completed',
          };

          // Navigate to donation complete page
          if (context.mounted) {
            context.goNamed(RoutePath.donationComplete, extra: donationData);
          }
        },
      );
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred: ${e.toString()}';
      if (kDebugMode) {
        print('Donation exception: $e');
      }
      _showError(context, errorMessage.value);
    } finally {
      isProcessing.value = false;
    }
  }

  void _showError(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
