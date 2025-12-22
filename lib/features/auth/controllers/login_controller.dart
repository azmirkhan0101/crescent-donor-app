import 'package:cresent_charge_user_app/core/go-router/guard/auth_guard.dart';
import 'package:cresent_charge_user_app/features/auth/models/signin_request_model.dart';
import 'package:cresent_charge_user_app/features/auth/models/signin_response_model.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/get_profile_controller.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:cresent_charge_user_app/service/firebase_notification_service.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // TextEditingControllers
  final emailController = TextEditingController(
    text: kDebugMode ? 'mostafizurrahaman0401@gmail.com' : '',
  );
  final passwordController = TextEditingController(
    text: kDebugMode ? 'test123@PASS' : '',
  );

  // Observable variables
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool rememberPassword = false.obs;
  RxString errorMessage = ''.obs;
  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadRememberedCredentials();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.toggle();
  }

  /// Toggle remember password
  void toggleRememberPassword() {
    rememberPassword.toggle();
  }

  /// Clear all error messages
  void clearErrors() {
    errorMessage.value = '';
    emailError.value = '';
    passwordError.value = '';
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
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Load remembered credentials if available
  Future<void> _loadRememberedCredentials() async {
    // Skip loading saved credentials in debug mode to use debug values
    if (kDebugMode) {
      return;
    }

    try {
      final savedEmail = await AppStorageService.readSecure('remembered_email');
      final savedPassword = await AppStorageService.readSecure(
        'remembered_password',
      );
      final isRemembered =
          AppStorageService.readPreferenceBool('remember_password') ?? false;

      if (isRemembered && savedEmail != null) {
        emailController.text = savedEmail;
        if (savedPassword != null) {
          passwordController.text = savedPassword;
        }
        rememberPassword.value = true;
      }
    } catch (e) {
      debugPrint('Error loading remembered credentials: $e');
    }
  }

  /// Save credentials if remember password is enabled
  Future<void> _saveCredentialsIfRemembered() async {
    try {
      if (rememberPassword.value) {
        await AppStorageService.writeSecure(
          'remembered_email',
          emailController.text,
        );
        await AppStorageService.writeSecure(
          'remembered_password',
          passwordController.text,
        );
        await AppStorageService.writePreferenceBool('remember_password', true);
      } else {
        // Clear saved credentials if remember password is disabled
        await AppStorageService.deleteSecure('remembered_email');
        await AppStorageService.deleteSecure('remembered_password');
        await AppStorageService.writePreferenceBool('remember_password', false);
      }
    } catch (e) {
      debugPrint('Error saving credentials: $e');
    }
  }

  /// Perform login with validation and authentication
  Future<bool> login() async {
    try {
      clearErrors();

      isLoading.value = true;

      // Get FCM token
      String? fcmToken;
      try {
        fcmToken = await FirebaseNotificationService.instance.getToken();
        debugPrint(
          '🔔 FCM Token obtained for login: ${fcmToken?.substring(0, 20)}...',
        );
      } catch (e) {
        debugPrint('⚠️ Failed to get FCM token for login: $e');
      }

      // Create request model with FCM token
      final requestModel = SigninRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text,
        fcmToken: fcmToken,
      );

      // Call signin API
      final networkHelper = Get.find<NetworkHelper>();
      final result = await networkHelper.request<SigninResponseModel>(
        'POST',
        ApiUrl.login,
        body: requestModel.toJson(),
        parser: (data) => SigninResponseModel.fromJson(data),
        withAuth: false,
      );

      return result.fold(
        (error) {
          // Handle error
          errorMessage.value =
              error.message ?? 'Login failed. Please try again.';
          debugPrint('❌ Login error: ${error.message}');
          return false;
        },
        (response) async {
          // Handle success
          if (response.success) {
            // Save access token
            await AppStorageService.saveAuthToken(response.data.accessToken);

            // Save refresh token
            await AppStorageService.writeSecure(
              'refresh_token',
              response.data.refreshToken,
            );

            // Save user data
            await AppStorageService.saveUserEmail(emailController.text);
            await AppStorageService.saveUserId(
              'user_${emailController.text.split('@')[0]}',
            );

            // Save credentials if remember password is enabled
            await _saveCredentialsIfRemembered();

            // Clear guest mode since user is now authenticated
            await AuthGuard.setGuestMode(false);

            // Save last login time
            await AppStorageService.saveLastLogin(DateTime.now());

            debugPrint('✅ Login successful for: ${emailController.text}');

            // Fetch profile after successful login
            final profileCtrl = Get.isRegistered<GetProfileController>()
                ? Get.find<GetProfileController>()
                : Get.put(GetProfileController());
            profileCtrl.fetchProfile();
            return true;
          } else {
            errorMessage.value = response.message;
            debugPrint('❌ Login failed: ${response.message}');
            return false;
          }
        },
      );
    } catch (e) {
      errorMessage.value = 'Login failed. Please try again.';
      debugPrint('❌ Login error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Login as guest
  Future<bool> loginAsGuest() async {
    try {
      isLoading.value = true;
      clearErrors();

      // Set guest mode
      await AuthGuard.setGuestMode(true);

      debugPrint('👤 Guest login successful');
      return true;
    } catch (e) {
      errorMessage.value = 'Failed to login as guest. Please try again.';
      debugPrint('❌ Guest login error: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if form is valid for enabling login button
  bool get isFormValid {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        GetUtils.isEmail(emailController.text) &&
        passwordController.text.length >= 6;
  }
}
