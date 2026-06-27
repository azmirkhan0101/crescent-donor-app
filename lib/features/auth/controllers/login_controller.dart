import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cresent_charge_user_app/core/go-router/guard/auth_guard.dart';
import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/auth/models/signin_request_model.dart';
import 'package:cresent_charge_user_app/features/auth/models/signin_response_model.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/get_profile_controller.dart';
import 'package:cresent_charge_user_app/service/api_service.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/helper/api_response.dart';
import '../../../service/google_signin_service.dart';

class LoginController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  // TextEditingControllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

  //================GOOGLE SIGN IN==================
  Future<void> loginWithGoogle({required VoidCallback onLoginSuccess, required VoidCallback onSocialSignup}) async {
    try {
      isLoading.value = true;

      final GoogleSigninService googleSignInService = GoogleSigninService();

      final GoogleSignInAccount account = await googleSignInService
          .signInWithGoogle();

      final GoogleSignInAuthentication auth = googleSignInService.getAuthTokens(
          account
      );

      final AuthCredential authCredential = GoogleAuthProvider.credential( idToken: auth.idToken );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential( authCredential );
      String? firebaseIdToken = await userCredential.user?.getIdToken();
      if( firebaseIdToken == null ){
        throw Exception("Failed to retrieve Firebase ID Token.");
      }

      Map<String, dynamic> credentials = {
        "role": "CLIENT",
        "firebaseIdToken": firebaseIdToken,
        "displayName": account.displayName ?? "Unknown"
      };
      ApiResponse response = await apiService.networkRequest(
          method: 'POST',
          isAuthRequired: false,
          endPoint: ApiUrl.socialLogin,
          body: credentials
      );
      if( response.statusCode == 200 || response.statusCode == 201 ){
        await AppStorageService.saveAuthToken(response.data['data']['accessToken']);
        await AppStorageService.writeSecure(
          'refresh_token',
          response.data['data']['refreshToken'],
        );
        bool requiresProfile = response.data['data']['requiresProfile'];
        if( requiresProfile ){
          //onSocialSignup();
          //SKIPPED UPDATE PROFILE ON SOCIAL SIGNUP
          handleSocialLoginSuccess( email: account.email, onLoginSuccess: onLoginSuccess );
        }else{
          handleSocialLoginSuccess( email: account.email, onLoginSuccess: onLoginSuccess );
        }
      }else{
        ToastMsg.api(statusCode: response.statusCode, data: response.data );
      }

    } on GoogleSignInException catch (e) {
      if (e.code != GoogleSignInExceptionCode.canceled) {
        ToastMsg.api(statusCode: null, data: null, msg: e.description ?? "Google Sign-In was not successful." );
      }
    } catch (e) {
      ToastMsg.error("Something went wrong. Please try again.");
    }finally{
      isLoading.value = false;
    }
  }
  
  //==================APPLE SIGN IN=================
  //==================APPLE SIGN IN=================
  Future<void> loginWithApple({required VoidCallback onLoginSuccess, required VoidCallback onSocialSignup}) async {
    // Ensure this runs only on iOS devices
    if (!Platform.isIOS) {
      ToastMsg.error("Apple Sign-In is only supported on iOS devices.");
      return;
    }

    try {
      isLoading.value = true;

      // 1. Generate secure nonces to prevent replay attacks (required by Firebase)
      final String rawNonce = _generateNonce();
      final String hashedNonce = _sha256ofString(rawNonce);

      // 2. Request credentials from Apple
      final AuthorizationCredentialAppleID appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );

      // 3. Create a Firebase OAuthCredential
      // Passing the authorizationCode as the accessToken is a recommended practice to avoid validation issues
      final AuthCredential authCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode,
      );

      // 4. Sign in to Firebase using the Apple credential
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);

      String? firebaseIdToken = await userCredential.user?.getIdToken();
      if (firebaseIdToken == null) {
        throw Exception("Failed to retrieve Firebase ID Token.");
      }

      // 5. Handle Name & Email extraction
      // Note: Apple only returns the email and name on the FIRST sign-in.
      // For subsequent sign-ins, we extract these details from the Firebase user object.
      String email = appleCredential.email ?? userCredential.user?.email ?? "";
      if (email.isEmpty) {
        throw Exception("Failed to retrieve user email from Apple Sign-In.");
      }

      String displayName = "Unknown";
      if (appleCredential.givenName != null) {
        displayName = "${appleCredential.givenName} ${appleCredential.familyName ?? ''}".trim();
      } else if (userCredential.user?.displayName != null && userCredential.user!.displayName!.isNotEmpty) {
        displayName = userCredential.user!.displayName!;
      }

      // 6. Assemble payload and verify session with your backend
      Map<String, dynamic> credentials = {
        "role": "CLIENT",
        "firebaseIdToken": firebaseIdToken,
        "displayName": displayName,
      };

      ApiResponse response = await apiService.networkRequest(
          method: 'POST',
          isAuthRequired: false,
          endPoint: ApiUrl.socialLogin,
          body: credentials
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await AppStorageService.saveAuthToken(response.data['data']['accessToken']);
        await AppStorageService.writeSecure(
          'refresh_token',
          response.data['data']['refreshToken'],
        );
        bool requiresProfile = response.data['data']['requiresProfile'];
        if (requiresProfile) {
          // onSocialSignup();
          // SKIPPED UPDATE PROFILE ON SOCIAL SIGNUP
          handleSocialLoginSuccess(email: email, onLoginSuccess: onLoginSuccess);
        } else {
          handleSocialLoginSuccess(email: email, onLoginSuccess: onLoginSuccess);
        }
      } else {
        ToastMsg.api(statusCode: response.statusCode, data: response.data);
      }

    } on SignInWithAppleAuthorizationException catch (e) {
      // Silence errors if the user explicitly cancels the iOS native bottom sheet
      if (e.code != AuthorizationErrorCode.canceled) {
        ToastMsg.api(statusCode: null, data: null, msg: e.message);
      }
    } catch (e) {
      ToastMsg.error("Something went wrong. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  // Helper method: Generates a cryptographically secure random nonce
  String _generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  // Helper method: Returns the sha256 hash of the input in hex notation
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  void handleSocialLoginSuccess({required String email, required VoidCallback onLoginSuccess}) async{

    // save is guest user
    await AppStorageService.saveIsGuestUser(false);

    // Save user data
    await AppStorageService.saveUserEmail(email);
    await AppStorageService.saveUserId(
      'user_${email.split('@')[0]}',
    );

    // Clear guest mode since user is now authenticated
    await AuthGuard.setGuestMode(false);

    // Save last login time
    await AppStorageService.saveLastLogin(DateTime.now());
    // Fetch profile after successful login
    final profileCtrl = Get.isRegistered<GetProfileController>()
        ? Get.find<GetProfileController>()
        : Get.put(GetProfileController());
    profileCtrl.fetchProfile();
    onLoginSuccess();
  }

  String? getHighResImageUrl(String? url) {
    if (url == null) return null;
    return url.replaceAll('s96-c', 's500-c');
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
        //Clear saved credentials if remember password is disabled
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

        if( Platform.isIOS ){
          String? apnsToken;
          for( int i = 0; i < 5; i++ ){
            apnsToken = await FirebaseMessaging.instance.getAPNSToken();
            if( apnsToken != null ){
              break;
            }
            await Future.delayed(const Duration(seconds: 2));
          }
        }
        fcmToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {
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

      result.printError();

      return result.fold(
        (error) {
          // Handle error
          errorMessage.value =
              error.message ?? 'Login failed. Please try again.';
          ToastMsg.error(errorMessage.value);
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

            // save is guest user
            await AppStorageService.saveIsGuestUser(false);

            // Save user data
            await AppStorageService.saveUserEmail(emailController.text);
            await AppStorageService.saveUserId(
              'user_${emailController.text.split('@')[0]}',
            );

            // Clear guest mode since user is now authenticated
            await AuthGuard.setGuestMode(false);

            // Save last login time
            await AppStorageService.saveLastLogin(DateTime.now());
            // Save credentials if remember password is enabled
            await _saveCredentialsIfRemembered();
            // Fetch profile after successful login
            // final profileCtrl = Get.isRegistered<GetProfileController>()
            //     ? Get.find<GetProfileController>()
            //     : Get.put(GetProfileController());
            // profileCtrl.fetchProfile();
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

  ///  ==========> Login as guest <==========
  var isLoadingGuest = false.obs;
  var guestErrorMessage = ''.obs;

  Future<bool> loginAsGuest() async {
    isLoadingGuest.value = true;
    guestErrorMessage.value = '';

    final response = await Get.find<NetworkHelper>()
        .request<Map<String, dynamic>>(
          'POST',
          ApiUrl.guestLogin,
          withAuth: false,
          parser: (data) => data as Map<String, dynamic>,
        );

    isLoadingGuest.value = false;

    return response.fold(
      (error) {
        guestErrorMessage.value =
            error.message ?? 'Guest login failed. Please try again.';
        ToastMsg.error(guestErrorMessage.value);
        debugPrint('❌ Guest login error: ${error.message}');
        return false;
      },
      (response) async {
        // Handle success
        if (response['success'] == true) {
          // Clear previous auth tokens
          await AppStorageService.clearAll();

          // Save access token
          await AppStorageService.saveAuthToken(
            response['data']?['accessToken'] ?? '',
          );

          // Save refresh token
          await AppStorageService.writeSecure(
            'refresh_token',
            response['data']?['refreshToken'] ?? '',
          );

          // Save is guest user
          await AppStorageService.saveIsGuestUser(true);

          // Set guest mode to true
          await AuthGuard.setGuestMode(true);

          // Save last login time
          await AppStorageService.saveLastLogin(DateTime.now());

          debugPrint('✅ Login successful for guest user');

          // Fetch profile after successful login
          final profileCtrl = Get.isRegistered<GetProfileController>()
              ? Get.find<GetProfileController>()
              : Get.put(GetProfileController());
          profileCtrl.fetchProfile();
          return true;
        } else {
          guestErrorMessage.value =
              response['message'] ?? 'Guest login failed.';
          debugPrint('❌ Guest login failed: ${response['message']}');
          return false;
        }
      },
    );
  }

  /// Check if form is valid for enabling login button
  bool get isFormValid {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        GetUtils.isEmail(emailController.text) &&
        passwordController.text.length >= 6;
  }
}
