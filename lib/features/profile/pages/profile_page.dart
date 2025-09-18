import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';

/// Profile Page
///
/// This page displays user profile information, settings, and account management.
/// Users can update their personal details and app preferences.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.rw,
              height: 80.rh,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF8B5CF6),
              ),
              child: Icon(
                Icons.person_outline,
                size: 40.rfs,
                color: Colors.white,
              ),
            ),
            24.rh.heightWidth,
            Text(
              "Profile",
              style: AppTextStyles.baseStyle().copyWith(
                fontSize: 24.rfs,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            12.rh.heightWidth,
            Text(
              "Manage your account and preferences",
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
