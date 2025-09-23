import 'package:flutter/material.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/tabbed_redemption_bottom_sheet.dart';

void showTabbedRedemptionBottomSheet(
  BuildContext context, {
  required String rewardTitle,
  required String rewardDescription,
  required String redemptionCode,
  required String expiryDate,
  Widget? brandIcon,
  RedemptionMethod initialMethod = RedemptionMethod.qrCode,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    useRootNavigator: true,
    elevation: 10,
    enableDrag: true,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    builder: (context) => Material(
      type: MaterialType.transparency,
      child: TabbedRedemptionBottomSheet(
        rewardTitle: rewardTitle,
        rewardDescription: rewardDescription,
        redemptionCode: redemptionCode,
        expiryDate: expiryDate,
        brandIcon: brandIcon,
        initialMethod: initialMethod,
      ),
    ),
  );
}
