import 'dart:io';

import 'package:flutter/foundation.dart';

class SigninRequestModel {
  final String email;
  final String password;
  final String? fcmToken;
  final String? deviceType;

  SigninRequestModel({
    required this.email,
    required this.password,
    this.fcmToken,
    this.deviceType,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fcmToken': fcmToken ?? '',
      'deviceType': deviceType ?? _getDeviceType(),
    };
  }

  /// Get device type based on platform
  static String _getDeviceType() {
    if (kIsWeb) {
      return 'web';
    } else if (Platform.isAndroid) {
      return 'android';
    } else if (Platform.isIOS) {
      return 'ios';
    } else {
      return 'web';
    }
  }
}
