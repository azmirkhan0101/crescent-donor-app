import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

/// Section Header Widget
///
/// Reusable widget for section titles with optional "View all" action
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DonationConstants.paddingHorizontal.rw,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: DonationFonts.familjenGrotesk,
              fontSize: DonationConstants.fontSize20.rfs,
              fontWeight: FontWeight.w600,
              color: DonationConstants.neutralGray,
              letterSpacing: -0.2,
              height: 24 / 20,
            ),
          ),
          if (actionText != null)
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionText!,
                style: TextStyle(
                  fontFamily: DonationFonts.interDisplay,
                  fontSize: DonationConstants.fontSize14.rfs,
                  fontWeight: FontWeight.w500,
                  color: DonationConstants.primaryPurple,
                  height: 20 / 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
