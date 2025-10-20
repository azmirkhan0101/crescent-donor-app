import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  // Text controllers
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable variables
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;
  var isNewPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  // Password validation observables
  var hasMinLength = false.obs;
  var hasUppercase = false.obs;
  var hasLowercase = false.obs;
  var hasNumber = false.obs;
  var hasSpecialChar = false.obs;
  var passwordsMatch = false.obs;

  // Computed properties
  bool get isPasswordValid =>
      hasMinLength.value &&
      hasUppercase.value &&
      hasLowercase.value &&
      hasNumber.value &&
      hasSpecialChar.value;

  bool get canSubmit => isPasswordValid && passwordsMatch.value;

  @override
  void onInit() {
    super.onInit();

    // Listen to password changes
    newPasswordController.addListener(() {
      newPassword.value = newPasswordController.text;
      validatePassword(newPasswordController.text);
      checkPasswordsMatch();
    });

    confirmPasswordController.addListener(() {
      confirmPassword.value = confirmPasswordController.text;
      checkPasswordsMatch();
    });
  }

  void validatePassword(String password) {
    // At least 8 characters
    hasMinLength.value = password.length >= 8;

    // At least one uppercase letter
    hasUppercase.value = password.contains(RegExp(r'[A-Z]'));

    // At least one lowercase letter
    hasLowercase.value = password.contains(RegExp(r'[a-z]'));

    // At least one number
    hasNumber.value = password.contains(RegExp(r'[0-9]'));

    // At least one special character
    hasSpecialChar.value = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  void checkPasswordsMatch() {
    passwordsMatch.value =
        newPassword.value.isNotEmpty &&
        newPassword.value == confirmPassword.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.toggle();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.toggle();
  }

  void resetPassword() {
    if (canSubmit) {
      // TODO: Implement actual reset password logic
      Get.snackbar(
        'Success',
        'Password reset successfully',
        snackPosition: SnackPosition.TOP,
      );
      // Navigate to login or success page
    } else {
      Get.snackbar(
        'Error',
        'Please meet all password requirements',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
