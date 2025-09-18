import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';

/// Donation Page
///
/// This page displays donation history, ongoing campaigns, and donation management.
/// Users can track their contributions and discover new donation opportunities.
class DonationPage extends StatelessWidget {
  const DonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.volunteer_activism_outlined,
              size: 80.rfs,
              color: const Color(0xFF10B981),
            ),
            24.rh.heightWidth,
            Text(
              "Donations",
              style: AppTextStyles.baseStyle().copyWith(
                fontSize: 24.rfs,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            12.rh.heightWidth,
            Text(
              "Track your donations and discover new causes",
              style: AppTextStyles.f14W400().copyWith(
                color: const Color(0xFF64748B),
                fontSize: 16.rfs,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
