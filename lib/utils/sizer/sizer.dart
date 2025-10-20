// lib/utils/responsive.dart
import 'dart:math';

import 'package:get/get.dart';

class Sizer {
  static const String tag = 'Responsive';
  static const double figmaWidth = 375;
  static const double figmaHeight = 812;

  static double responsiveWidth(double px) => (px / figmaWidth) * Get.width;
  static double responsiveHeight(double px) => (px / figmaHeight) * Get.height;

  static double responsiveFontSize(double px) {
    final wScale = Get.width / figmaWidth;
    final hScale = Get.height / figmaHeight;
    final scale = min(wScale, hScale).clamp(0.75, 1.25);
    return px * scale;
  }

  // Extensions for clean syntax
}

extension ResponsiveIntExt on int {
  double get rw => Sizer.responsiveWidth(toDouble());
  double get rh => Sizer.responsiveHeight(toDouble());
  double get rfs => Sizer.responsiveFontSize(toDouble());
}

extension ResponsiveExt on double {
  double get rw => Sizer.responsiveWidth(this);
  double get rh => Sizer.responsiveHeight(this);
  double get rfs => Sizer.responsiveFontSize(this);
}
