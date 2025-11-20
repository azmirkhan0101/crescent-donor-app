import 'package:cresent_charge_user_app/features/main-layout/widgets/bottom_nav.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

/// Main Layout Page
///
/// This page serves as the main container for the app after authentication.
/// It handles the bottom navigation and displays different pages based on
/// the selected tab with a floating bottom navigation.
class MainLayoutPage extends StatelessWidget {
  /// The child widget to display in the main content area
  final Widget child;

  const MainLayoutPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          child,
          // Floating bottom navigation
          Positioned(
            left: 24.rw,
            right: 24.rw,
            bottom: 10.rh,
            child: const BottomNav(),
          ),
        ],
      ),
    ).scaffoldSafeArea();
  }
}
