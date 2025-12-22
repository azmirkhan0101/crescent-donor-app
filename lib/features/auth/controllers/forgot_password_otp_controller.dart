import 'dart:async';

import 'package:cresent_charge_user_app/features/auth/models/verify_otp_response_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class ForgotPasswordOtpController extends GetxController {
  RxString token = ''.obs; // forgot password token
  RxString otpValue = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isResendLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxInt timer = 0.obs; // seconds remaining for resend
  Timer? _countdown;
  RxString resetPasswordToken = ''.obs;

  void setToken(String value) {
    token.value = value.trim();
  }

  void clearErrors() {
    errorMessage.value = '';
  }

  bool get canResend => timer.value == 0 && !isResendLoading.value;

  void startTimer([int seconds = 300]) {
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

  Future<bool> verifyOtp() async {
    clearErrors();
    if (otpValue.value.length != 6) {
      errorMessage.value = 'Enter 6-digit OTP';
      return false;
    }
    if (token.value.isEmpty) {
      errorMessage.value = 'Token missing';
      return false;
    }
    isLoading.value = true;
    try {
      final req = {'token': token.value, 'otp': otpValue.value};
      final network = Get.find<NetworkHelper>();
      final result = await network.request<VerifyOtpResponseModel>(
        'POST',
        ApiUrl.verifyForgotPasswordOtp,
        body: req,
        parser: (d) => VerifyOtpResponseModel.fromJson(d),
        withAuth: false,
      );
      return result.fold(
        (l) {
          errorMessage.value = l.message ?? 'Verification failed';
          return false;
        },
        (r) {
          if (!r.success) {
            errorMessage.value = r.message;
            return false;
          }
          resetPasswordToken.value = r.data.resetPasswordToken;
          return true;
        },
      );
    } catch (e) {
      errorMessage.value = 'Verification error';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp() async {
    if (!canResend) return;
    clearErrors();
    if (token.value.isEmpty) {
      errorMessage.value = 'Token missing';
      return;
    }
    isResendLoading.value = true;
    try {
      final network = Get.find<NetworkHelper>();
      final result = await network.request<dynamic>(
        'POST',
        ApiUrl.resendForgotPasswordOtp,
        body: {'token': token.value},
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
