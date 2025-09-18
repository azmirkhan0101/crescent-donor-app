import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Assets.bottomNav.home.svg()),
        BottomNavigationBarItem(icon: Assets.bottomNav.starEmphasis.svg()),
        BottomNavigationBarItem(icon: Assets.bottomNav.donation.svg()),
        BottomNavigationBarItem(icon: Assets.bottomNav.user.svg()),
      ],
    );
  }
}
