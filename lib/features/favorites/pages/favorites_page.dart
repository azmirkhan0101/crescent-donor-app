import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';

/// Favorites Page
///
/// This page displays the user's favorite charities and causes.
/// It allows users to quickly access and manage their preferred organizations.
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline,
              size: 80.rfs,
              color: const Color(0xFF8B5CF6),
            ),
            24.rh.heightWidth,
            Text(
              "Favorites",
              style: AppTextStyles.baseStyle().copyWith(
                fontSize: 24.rfs,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            12.rh.heightWidth,
            Text(
              "Your favorite charities and causes will appear here",
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
