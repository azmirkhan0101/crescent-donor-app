import 'package:flutter/material.dart';

void showRewardsBottomSheet(BuildContext context, Widget child) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    useRootNavigator: true,
    elevation: 10,
    enableDrag: true,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    builder: (context) =>
        Material(type: MaterialType.transparency, child: child),
  );
}
