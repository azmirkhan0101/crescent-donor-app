import 'dart:async';

import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class SignupOtpController extends GetxController {
  RxString email = ''.obs;
  RxString otpValue = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isResendLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxInt timer = 0.obs; // seconds remaining for resend
  Timer? _countdown;

  void setEmail(String value) {
    email.value = value.trim();
  }

  void clearErrors() {
    errorMessage.value = '';
  }

  bool get canResend => timer.value == 0 && !isResendLoading.value;

  void startTimer([int seconds = 500]) {
    timer.value = seconds;
    _countdown?.cancel();
    _countdown = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timer.value <= 1) {
        t.cancel();
        timer.value = 0;
      } else {
        timer.value = timer.value - 1;
      }
    });
  }

  /// Verify OTP for signup
  Future<bool> verifyOtp() async {
    clearErrors();
    if (otpValue.value.length != 6) {
      errorMessage.value = 'Enter 6-digit OTP';
      return false;
    }
    if (email.value.isEmpty) {
      errorMessage.value = 'Email missing';
      return false;
    }

    isLoading.value = true;

    final req = {"otp": otpValue.value, "email": email.value};

    final network = Get.find<NetworkHelper>();
    final result = await network.request<dynamic>(
      'POST',
      ApiUrl.verifySignupOtp,
      body: req,
      parser: (d) => d,
      withAuth: false,
    );

    isLoading.value = false;

    return result.fold(
      (l) {
        errorMessage.value = l.message ?? 'Verification failed';
        return false;
      },
      (r) {
        // r is a Map<String, dynamic> from the parser
        final success = r['success'] as bool? ?? false;
        if (!success) {
          errorMessage.value = r['message'] as String? ?? 'Verification failed';
          return false;
        }

        // save access token and refresh token into secure storage
        final data = r['data'] as Map<String, dynamic>?;
        if (data != null) {
          AppStorageService.saveAuthToken(data['accessToken'] as String);
          AppStorageService.saveRefreshToken(data['refreshToken'] as String);
        }

        return true;
      },
    );
  }

  /// Resend OTP for signup
  Future<void> resendOtp() async {
    if (!canResend) return;
    clearErrors();
    if (email.value.isEmpty) {
      errorMessage.value = 'Email missing';
      return;
    }
    isResendLoading.value = true;
    try {
      final network = Get.find<NetworkHelper>();
      final result = await network.request<dynamic>(
        'POST',
        ApiUrl.resendSignupOtp,
        body: {'email': email.value},
        parser: (d) => d,
        withAuth: false,
      );
      result.fold(
        (l) {
          errorMessage.value = l.message ?? 'Resend failed';
        },
        (r) {
          startTimer();
        },
      );
    } catch (e) {
      errorMessage.value = 'Resend error';
    } finally {
      isResendLoading.value = false;
    }
  }

  @override
  void onClose() {
    _countdown?.cancel();
    super.onClose();
  }
}
