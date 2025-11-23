import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController currentPasswordController =
      TextEditingController();
  // Text controllers
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable variables
  var newPassword = ''.obs;
  var passwordStrength = 3.obs;
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

  // Field-level error messages (for UI)
  RxString newPasswordError = ''.obs;
  RxString confirmPasswordError = ''.obs;

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
      _validatePassword(newPasswordController.text);
      _validateConfirm(confirmPasswordController.text);
    });

    confirmPasswordController.addListener(() {
      confirmPassword.value = confirmPasswordController.text;
      _validateConfirm(confirmPasswordController.text);
    });
  }

  // Internal validator that also sets field error text like ResetPasswordController
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
    // kept for compatibility; use changePassword() for the actual flow
    if (!canSubmit) {
      Get.snackbar(
        'Error',
        'Please meet all password requirements',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Errors & loading for change password flow
  RxString errorMessage = ''.obs;
  RxBool isLoading = false.obs;

  /// Call API to change password. Returns true on success.
  Future<bool> changePassword() async {
    errorMessage.value = '';

    // Validate locally first
    _validatePassword(newPasswordController.text);
    checkPasswordsMatch();
    if (!canSubmit) {
      errorMessage.value = 'Please satisfy password requirements';
      return false;
    }

    if (currentPasswordController.text.isEmpty) {
      errorMessage.value = 'Current password is required';
      return false;
    }

    isLoading.value = true;

    final network = Get.find<NetworkHelper>();
    final result = await network.patch<dynamic>(
      ApiUrl.changePassword,
      body: {
        'oldPassword': currentPasswordController.text.trim(),
        'newPassword': newPasswordController.text.trim(),
      },
      parser: (d) => d,
    );

    isLoading.value = false;

    return result.fold(
      (err) {
        errorMessage.value = err.message ?? 'Change password failed';
        return false;
      },
      (resData) {
        if (resData is Map && resData['success'] == true) {
          clear();
          // Save tokens if provided
          try {
            final data = resData['data'];
            if (data is Map) {
              final access = data['accessToken'] as String?;
              final refresh = data['refreshToken'] as String?;
              if (access != null && access.isNotEmpty) {
                AppStorageService.saveAuthToken(access);
              }
              if (refresh != null && refresh.isNotEmpty) {
                AppStorageService.saveRefreshToken(refresh);
              }
            }
          } catch (_) {}
          return true;
        }
        errorMessage.value = (resData is Map && resData['message'] != null)
            ? resData['message']
            : 'Change password failed';
        return false;
      },
    );
  }

  void clear() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    errorMessage.value = '';
    newPasswordError.value = '';
    confirmPasswordError.value = '';
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
