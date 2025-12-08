import 'package:cresent_charge_user_app/features/organization/models/add_payment_method_request.dart';
import 'package:cresent_charge_user_app/features/organization/models/payment_method_model.dart';
import 'package:cresent_charge_user_app/features/organization/models/setup_intent_response.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchPaymentMethods();
  }

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isAddingCard = false.obs;
  final NetworkHelper _networkHelper = Get.find<NetworkHelper>();

  /// List of payment methods
  final RxList<PaymentMethodModel> paymentMethods = <PaymentMethodModel>[].obs;

  /// Fetch payment methods from API
  Future<void> fetchPaymentMethods() async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await _networkHelper.request(
      'GET',
      ApiUrl.getPaymentMethods,
      parser: (data) {
        return data["data"]
            .map<PaymentMethodModel>(
              (item) => PaymentMethodModel.fromJson(item),
            )
            .toList();
      },
    );

    isLoading.value = false;

    result.fold(
      (failure) {
        errorMessage.value =
            failure.message ?? 'Failed to load payment methods';
      },
      (response) {
        paymentMethods.value = response;
      },
    );
  }

  /// Delete a payment method by id
  Future<bool> deletePaymentMethod(String id) async {
    // Optimistic UI: remove locally, revert if failed
    final index = paymentMethods.indexWhere((pm) => pm.id == id);
    PaymentMethodModel? removed;
    if (index != -1) {
      removed = paymentMethods[index];
      paymentMethods.removeAt(index);
    }

    final result = await _networkHelper.request(
      'DELETE',
      ApiUrl.deletePaymentMethod(id),
    );

    return result.fold(
      (failure) {
        // Revert UI if deletion failed
        if (removed != null) {
          paymentMethods.insert(index, removed);
        }
        errorMessage.value =
            failure.message ?? 'Failed to delete payment method';
        return false;
      },
      (_) {
        return true;
      },
    );
  }

  /// Create setup intent for card payment
  Future<SetupIntentData?> createSetupIntent() async {
    final result = await _networkHelper.request(
      'POST',
      ApiUrl.createSetupIntent,
      body: {}, // empty body as per API spec
      parser: (data) {
        return SetupIntentResponse.fromJson(data);
      },
    );

    return result.fold(
      (failure) {
        errorMessage.value = failure.message ?? 'Failed to create setup intent';
        if (kDebugMode) {
          print('Setup intent error: ${failure.message}');
        }
        return null;
      },
      (response) {
        if (kDebugMode) {
          print('Setup intent created: ${response.data.clientSecret}');
        }
        return response.data;
      },
    );
  }

  /// Add payment method to backend
  Future<bool> addPaymentMethod({
    required String stripePaymentMethodId,
    required String cardHolderName,
    bool isDefault = true,
  }) async {
    isAddingCard.value = true;
    errorMessage.value = '';

    final request = AddPaymentMethodRequest(
      stripePaymentMethodId: stripePaymentMethodId,
      cardHolderName: cardHolderName,
      isDefault: isDefault,
    );
    isAddingCard.value = false;

    final result = await _networkHelper.request(
      'POST',
      ApiUrl.addPaymentMethod,
      body: request.toJson(),
      parser: (data) => data,
    );

    return result.fold(
      (failure) {
        errorMessage.value = failure.message ?? 'Failed to add payment method';
        if (kDebugMode) {
          print('Add payment method error: ${failure.message}');
        }
        return false;
      },
      (response) {
        if (kDebugMode) {
          print('Payment method added successfully');
        }
        // Refresh the payment methods list
        fetchPaymentMethods();
        return true;
      },
    );
  }

  /// Complete card setup process
  /// This method combines creating setup intent, confirming with Stripe, and adding to backend
  Future<bool> setupCard({
    required String cardHolderName,
    bool isDefault = true,
  }) async {
    try {
      // Step 1: Create setup intent
      final setupIntentData = await createSetupIntent();
      if (setupIntentData == null) {
        return false;
      }

      // Step 2: Confirm card setup with Stripe using the client secret
      final result = await stripe.Stripe.instance.confirmSetupIntent(
        paymentIntentClientSecret: setupIntentData.clientSecret,
        params: const stripe.PaymentMethodParams.card(
          paymentMethodData: stripe.PaymentMethodData(),
        ),
      );

      if (kDebugMode) {
        print('Setup intent status: ${result.status}');
      }

      // Check if setup was successful
      // The status should be Succeeded after confirmation
      if (result.status == stripe.PaymentIntentsStatus.Canceled ||
          result.status == stripe.PaymentIntentsStatus.RequiresAction ||
          result.status == stripe.PaymentIntentsStatus.RequiresCapture ||
          result.status == stripe.PaymentIntentsStatus.RequiresConfirmation) {
        errorMessage.value = 'Card setup was not successful: ${result.status}';
        return false;
      }

      // Get the payment method ID from the result
      final paymentMethodId = result.paymentMethodId;
      if (paymentMethodId.isEmpty) {
        errorMessage.value = 'Payment method ID not found';
        if (kDebugMode) {
          print('Payment method ID is empty');
        }
        return false;
      }

      if (kDebugMode) {
        print('Payment method ID: $paymentMethodId');
      }

      // Step 3: Add payment method to backend
      return await addPaymentMethod(
        stripePaymentMethodId: paymentMethodId,
        cardHolderName: cardHolderName,
        isDefault: isDefault,
      );
    } catch (e) {
      errorMessage.value = 'Failed to setup card: ${e.toString()}';
      if (kDebugMode) {
        print('Setup card exception: $e');
      }
      return false;
    }
  }
}
