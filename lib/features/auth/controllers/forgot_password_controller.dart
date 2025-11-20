import 'package:cresent_charge_user_app/features/auth/models/forgot_password_request_model.dart';
import 'package:cresent_charge_user_app/features/auth/models/forgot_password_response_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // GlobalKey for the form
  final formKey = GlobalKey<FormState>();

  // TextEditingController
  final emailController = TextEditingController(
    text: kDebugMode ? 'user@example.com' : '',
  );

  // Observable variables
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString resetToken = ''.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  /// Clear all error messages
  void clearErrors() {
    errorMessage.value = '';
  }

  /// Validate email field
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Send forgot password request
  Future<bool> sendForgotPasswordRequest() async {
    try {
      clearErrors();

      // Validate form
      if (!formKey.currentState!.validate()) {
        return false;
      }

      isLoading.value = true;

      // Create request model
      final requestModel = ForgotPasswordRequestModel(
        email: emailController.text.trim(),
      );

      // Call forgot password API
      final networkHelper = Get.find<NetworkHelper>();
      final result = await networkHelper.request<ForgotPasswordResponseModel>(
        'POST',
        ApiUrl.forgotPassword,
        body: requestModel.toJson(),
        parser: (data) => ForgotPasswordResponseModel.fromJson(data),
        withAuth: false,
      );

      return result.fold(
        (error) {
          // Handle error
          errorMessage.value =
              error.message ?? 'Request failed. Please try again.';
          debugPrint('❌ Forgot password error: ${error.message}');
          return false;
        },
        (response) async {
          // Handle success
          if (response.success) {
            // Store reset token if provided
            if (response.token != null && response.token!.isNotEmpty) {
              resetToken.value = response.token!;
            }

            debugPrint(
              '✅ Forgot password request successful: ${response.message}',
            );
            return true;
          } else {
            errorMessage.value = response.message;
            debugPrint('❌ Forgot password failed: ${response.message}');
            return false;
          }
        },
      );
    } catch (e) {
      errorMessage.value = 'Request failed. Please try again.';
      debugPrint('❌ Forgot password error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
