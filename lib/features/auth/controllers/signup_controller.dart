import 'package:cresent_charge_user_app/features/auth/models/signup_request_model.dart';
import 'package:cresent_charge_user_app/features/auth/models/signup_response_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  // GlobalKey for the form
  final formKey = GlobalKey<FormState>();

  // TextEditingControllers
  final emailController = TextEditingController(
    text: kDebugMode ? 'crescent@yopmail.com' : '',
  );
  final passwordController = TextEditingController(
    text: kDebugMode ? 'Test123@Pass' : '',
  );
  final confirmPasswordController = TextEditingController(
    text: kDebugMode ? 'Test123@Pass' : '',
  );

  // Observable variables
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  RxInt passwordStrength = 3.obs;
  RxBool agreeToTerms = false.obs;
  RxString errorMessage = ''.obs;
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;
  RxString confirmPasswordError = ''.obs;

  // Store signup response data
  Rx<SignupData?> signupData = Rx<SignupData?>(null);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  /// Clear all error messages
  void clearErrors() {
    errorMessage.value = '';
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
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

  /// Validate password field
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  /// Validate confirm password field
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Calculate password strength
  void calculatePasswordStrength(String password) {
    int strength = 0;

    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

    passwordStrength.value = strength;
  }

  /// Perform signup with validation
  Future<bool> signup() async {
    try {
      clearErrors();

      // Validate form
      if (!formKey.currentState!.validate()) {
        return false;
      }

      // Check if passwords match
      if (passwordController.text != confirmPasswordController.text) {
        confirmPasswordError.value = 'Passwords do not match';
        return false;
      }

      isLoading.value = true;

      // Create request model
      final requestModel = SignupRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Call signup API
      final networkHelper = Get.find<NetworkHelper>();
      final result = await networkHelper.request<SignupResponseModel>(
        'POST',
        ApiUrl.signup,
        body: requestModel.toJson(),
        parser: (data) => SignupResponseModel.fromJson(data),
        withAuth: false,
      );

      return result.fold(
        (error) {
          // Handle error
          errorMessage.value =
              error.message ?? 'Signup failed. Please try again.';
          debugPrint('❌ Signup error: ${error.message}');
          return false;
        },
        (response) async {
          // Handle success
          if (response.success) {
            // Store signup data for OTP verification
            signupData.value = response.data;

            debugPrint('✅ Signup successful: ${response.message}');
            debugPrint('📧 OTP sent to: ${response.data.email}');
            return true;
          } else {
            errorMessage.value = response.message;
            debugPrint('❌ Signup failed: ${response.message}');
            return false;
          }
        },
      );
    } catch (e) {
      errorMessage.value = 'Signup failed. Please try again.';
      debugPrint('❌ Signup error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if form is valid for enabling signup button
  bool get isFormValid {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        GetUtils.isEmail(emailController.text) &&
        passwordController.text.length >= 6 &&
        passwordController.text == confirmPasswordController.text;
  }
}
