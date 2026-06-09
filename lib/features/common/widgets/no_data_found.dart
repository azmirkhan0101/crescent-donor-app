import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/extension/context_extension.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({
    super.key,
    required this.title,
    required this.description,
    this.icon,
  });
  final String title;
  final String description;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Container(
      height: isTab ? 350 : 230.rh,
      margin: EdgeInsets.symmetric(
        horizontal: DonationConstants.paddingHorizontal.rw,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.rw),
        border: Border.all(color: const Color(0xFFE4E4E4), width: 1),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.emoji_events_outlined,
              size: isTab ? 80 : 48.rw,
              color: const Color(0xFFB3B3B3),
            ),
            SizedBox(height: 12.rh),
            Text(
              title,
              style: TextStyle(
                fontFamily: DonationFonts.familjenGrotesk,
                fontSize: isTab ? 12.sp : 18.rfs,
                fontWeight: FontWeight.w600,
                color: DonationConstants.offBlack,
              ),
            ),
            SizedBox(height: 8.rh),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.rw),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: DonationFonts.interDisplay,
                  fontSize: isTab ? 10.sp : 14.rfs,
                  color: const Color(0xFF515A59),
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
