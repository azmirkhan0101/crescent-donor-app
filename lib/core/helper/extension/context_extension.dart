import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;

  bool get isMobileDevice => width < 600;
  bool get isTabletDevice => width >= 600;
}
