import 'package:cresent_charge_user_app/features/auth/models/verify_otp_request_model.dart';
import 'package:cresent_charge_user_app/features/auth/models/verify_otp_response_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  // Text controller for OTP input
  final otpController = TextEditingController();

  // Observable variables
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString email = ''.obs;
  RxString token = ''.obs;
  RxBool isForSignup = false.obs;

  // OTP value
  RxString otpValue = ''.obs;

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  /// Clear all error messages
  void clearErrors() {
    errorMessage.value = '';
  }

  /// Set email and flow type
  void setEmailAndFlow({
    required String emailAddress,
    required bool forSignup,
  }) {
    email.value = emailAddress;
    isForSignup.value = forSignup;
  }

  /// Set token for forgot password flow
  void setToken(String resetToken) {
    token.value = resetToken;
  }

  /// Verify OTP for signup
  Future<bool> verifySignupOtp() async {
    try {
      clearErrors();

      if (otpValue.value.isEmpty || otpValue.value.length < 6) {
        errorMessage.value = 'Please enter a valid 6-digit OTP';
        return false;
      }

      if (email.value.isEmpty) {
        errorMessage.value = 'Email is required';
        return false;
      }

      isLoading.value = true;

      // Create request model
      final requestModel = VerifySignupOtpRequestModel(
        email: email.value,
        otp: otpValue.value,
      );

      // Call verify signup OTP API
      final networkHelper = Get.find<NetworkHelper>();
      final result = await networkHelper.request<VerifyOtpResponseModel>(
        'POST',
        ApiUrl.verifySignupOtp,
        body: requestModel.toJson(),
        parser: (data) => VerifyOtpResponseModel.fromJson(data),
        withAuth: false,
      );

      return result.fold(
        (error) {
          // Handle error
          errorMessage.value =
              error.message ?? 'OTP verification failed. Please try again.';
          debugPrint('❌ Verify signup OTP error: ${error.message}');
          return false;
        },
        (response) async {
          // Handle success
          if (response.success) {
            debugPrint(
              '✅ Signup OTP verified successfully: ${response.message}',
            );
            return true;
          } else {
            errorMessage.value = response.message;
            debugPrint('❌ Signup OTP verification failed: ${response.message}');
            return false;
          }
        },
      );
    } catch (e) {
      errorMessage.value = 'OTP verification failed. Please try again.';
      debugPrint('❌ Verify signup OTP error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Verify OTP for forgot password
  Future<bool> verifyForgotPasswordOtp() async {
    try {
      clearErrors();

      if (otpValue.value.isEmpty || otpValue.value.length < 6) {
        errorMessage.value = 'Please enter a valid 6-digit OTP';
        return false;
      }

      if (token.value.isEmpty) {
        errorMessage.value = 'Reset token is required';
        return false;
      }

      isLoading.value = true;

      // Create request model
      final requestModel = VerifyForgotPasswordOtpRequestModel(
        token: token.value,
        otp: otpValue.value,
      );

      // Call verify forgot password OTP API
      final networkHelper = Get.find<NetworkHelper>();
      final result = await networkHelper.request<VerifyOtpResponseModel>(
        'POST',
        ApiUrl.verifyForgotPasswordOtp,
        body: requestModel.toJson(),
        parser: (data) => VerifyOtpResponseModel.fromJson(data),
        withAuth: false,
      );

      return result.fold(
        (error) {
          // Handle error
          errorMessage.value =
              error.message ?? 'OTP verification failed. Please try again.';
          debugPrint('❌ Verify forgot password OTP error: ${error.message}');
          return false;
        },
        (response) async {
          // Handle success
          if (response.success) {
            debugPrint(
              '✅ Forgot password OTP verified successfully: ${response.message}',
            );
            return true;
          } else {
            errorMessage.value = response.message;
            debugPrint(
              '❌ Forgot password OTP verification failed: ${response.message}',
            );
            return false;
          }
        },
      );
    } catch (e) {
      errorMessage.value = 'OTP verification failed. Please try again.';
      debugPrint('❌ Verify forgot password OTP error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Resend OTP (to be implemented based on API)
  Future<void> resendOtp() async {
    try {
      clearErrors();
      // TODO: Implement resend OTP API call
      debugPrint('🔄 Resend OTP for: ${email.value}');

      Get.snackbar(
        'Success',
        'OTP has been resent to your email',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      errorMessage.value = 'Failed to resend OTP. Please try again.';
      debugPrint('❌ Resend OTP error: $e');
    }
  }
}
