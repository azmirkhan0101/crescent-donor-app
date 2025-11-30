import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/home/models/cause_model.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/organization_controller.dart';
import 'package:cresent_charge_user_app/features/organization/models/one_time_donation_response.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/donation_bottom_sheet.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DonateNowController extends GetxController {
  final orgDetailsController = Get.find<OrganizationController>();

  final TextEditingController specialMsgController = TextEditingController();

  Rx<DonationType> selectedDonationType = DonationType.recurring.obs;
  RxString organizationId = ''.obs;
  Rx<CauseData?> selectedCause = Rx<CauseData?>(null);
  RxInt selectedAmountIndex = (-1).obs;
  var amount = Rx<num>(0);

  final donationAmountsList = [
    {'amount': 10, 'label': '\$10'},
    {'amount': 25, 'label': '\$25'},
    {'amount': 30, 'label': '\$30'},
    {'amount': 40, 'label': '\$40'},
    {'amount': 50, 'label': '\$50'},
    {'amount': -1, 'label': 'Custom'},
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize organizationId if needed
    organizationId.value =
        orgDetailsController.organizationDetails.value?.id ?? '';
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('MMMM dd, yyyy h:mm a').format(dateTime);
  }

  /// ============================================
  /// make one time donation
  /// ============================================
  RxBool isPaymentProcessing = false.obs;
  RxString errorMessage = ''.obs;

  Rx<OneTimeDonationModel?> donationResponse = Rx<OneTimeDonationModel?>(null);

  Future<void> onConfirmDonation(
    BuildContext context, {
    required String paymentMethodId,
  }) async {
    // Validate payment method
    if (paymentMethodId.isEmpty) {
      ToastMsg.error('Please select a payment method');
      return;
    }

    // Validate amount
    if (amount.value <= 0) {
      ToastMsg.error('Please enter a valid donation amount');
      return;
    }

    // Validate organization and cause
    if (organizationId.value.isEmpty || selectedCause.value?.id == null) {
      // _showError(context, 'Missing organization or cause information');
      ToastMsg.error('Missing organization or cause information');
      return;
    }

    isPaymentProcessing.value = true;
    errorMessage.value = '';

    // Create donation request
    final request = {
      "amount": amount.value + (amount.value * 0.05), // Including 5% tax/fees
      "currency": 'usd',
      "organizationId": organizationId.value,
      "causeId": selectedCause.value?.id,
      "paymentMethodId": paymentMethodId,
      "specialMessage": specialMsgController.text,
    };

    if (kDebugMode) {
      print(
        'Creating donation: amount:${amount.value}, currency:usd, organizationId:${organizationId.value}, causeId:${selectedCause.value?.id}, paymentMethodId:$paymentMethodId, specialMessage:${specialMsgController.text}',
      );
      print('Raw request map: $request');
    }

    // Call API
    final result = await Get.find<NetworkHelper>().request(
      'POST',
      ApiUrl.oneTimeDonationCreate,
      body: request,
      parser: (data) => OneTimeDonationModel.fromJson(data['data']),
    );

    isPaymentProcessing.value = false;

    result.fold(
      (failure) {
        // Handle error
        errorMessage.value = failure.message ?? 'Failed to process donation';
        if (kDebugMode) {
          print('Donation error: ${failure.message}');
        }
        ToastMsg.error(errorMessage.value);
      },
      (response) {
        donationResponse.value = response;
        // Success
        if (kDebugMode) {
          print('Donation successful: $response');
        }

        // Navigate to donation complete page
        if (context.mounted) {
          context.goNamed(RoutePath.donationComplete);
        }
      },
    );
  }

  @override
  void onClose() {
    specialMsgController.dispose();
    super.onClose();
  }
}
