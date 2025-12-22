import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Visibility
  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  // Validation flags
  RxBool hasMinLength = false.obs;
  RxBool hasUppercase = false.obs;
  RxBool hasLowercase = false.obs;
  RxBool hasNumber = false.obs;
  RxBool hasSpecialChar = false.obs;
  RxBool passwordsMatch = false.obs;

  // Errors & loading
  RxString newPasswordError = ''.obs;
  RxString confirmPasswordError = ''.obs;
  RxString errorMessage = ''.obs;
  RxBool isLoading = false.obs;

  String? _resetToken; // obtained from previous flow

  bool get isPasswordValid =>
      hasMinLength.value &&
      hasUppercase.value &&
      hasLowercase.value &&
      hasNumber.value &&
      hasSpecialChar.value;
  bool get canSubmit =>
      isPasswordValid &&
      passwordsMatch.value &&
      newPasswordError.value.isEmpty &&
      confirmPasswordError.value.isEmpty;

  @override
  void onInit() {
    super.onInit();
    // Try to obtain token from OTP or forgot password controllers (if present)
    // if (Get.isRegistered<ForgotPasswordOtpController>()) {
    //   _resetToken = Get.find<ForgotPasswordOtpController>().token.value;
    // } else if (Get.isRegistered<ForgotPasswordController>()) {
    //   _resetToken = Get.find<ForgotPasswordController>().resetToken.value;
    // }

    newPasswordController.addListener(() {
      final pwd = newPasswordController.text;
      _validatePassword(pwd);
      _validateConfirm(confirmPasswordController.text);
    });
    confirmPasswordController.addListener(() {
      _validateConfirm(confirmPasswordController.text);
    });
  }

  void _validatePassword(String password) {
    hasMinLength.value = password.length >= 8;
    hasUppercase.value = password.contains(RegExp(r'[A-Z]'));
    hasLowercase.value = password.contains(RegExp(r'[a-z]'));
    hasNumber.value = password.contains(RegExp(r'[0-9]'));
    hasSpecialChar.value = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (password.isEmpty) {
      newPasswordError.value = 'Password is required';
    } else if (!hasMinLength.value) {
      newPasswordError.value = 'Min 8 characters';
    } else if (!hasUppercase.value) {
      newPasswordError.value = 'Add uppercase letter';
    } else if (!hasLowercase.value) {
      newPasswordError.value = 'Add lowercase letter';
    } else if (!hasNumber.value) {
      newPasswordError.value = 'Add a number';
    } else if (!hasSpecialChar.value) {
      newPasswordError.value = 'Add special character';
    } else {
      newPasswordError.value = '';
    }
  }

  void _validateConfirm(String value) {
    passwordsMatch.value =
        newPasswordController.text.isNotEmpty &&
        value == newPasswordController.text;
    if (value.isEmpty) {
      confirmPasswordError.value = 'Confirm your password';
    } else if (!passwordsMatch.value) {
      confirmPasswordError.value = 'Passwords do not match';
    } else {
      confirmPasswordError.value = '';
    }
  }

  void toggleNewPasswordVisibility() => isNewPasswordVisible.toggle();
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.toggle();

  Future<bool> resetPassword(String resetToken) async {
    errorMessage.value = '';
    _validatePassword(newPasswordController.text);
    _validateConfirm(confirmPasswordController.text);
    if (!canSubmit) return false;
    if (resetToken.isEmpty) {
      errorMessage.value = 'Reset token missing. Restart flow.';
      return false;
    }
    isLoading.value = true;
    // try {
    final network = Get.find<NetworkHelper>();
    final result = await network.request<dynamic>(
      'POST',
      ApiUrl.resetPassword,
      body: {
        'newPassword': newPasswordController.text.trim(),
        "resetPasswordToken": resetToken,
      },
      withAuth: false,
      parser: (d) => d,
    );

    isLoading.value = false;

    return result.fold(
      (l) {
        errorMessage.value = l.message ?? 'Reset failed';
        return false;
      },
      (r) {
        if (r is Map && r['success'] == true) {
          return true;
        }
        errorMessage.value = (r is Map && r['message'] != null)
            ? r['message']
            : 'Reset failed';
        return false;
      },
    );
    // } catch (e) {
    //   errorMessage.value = 'Reset error';
    //   return false;
    // } finally {
    //   isLoading.value = false;
    // }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
