import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RedeemErrorPage extends StatelessWidget {
  const RedeemErrorPage({
    super.key,
    this.errorTitle = "Reward has expired!",
    this.errorDescription =
        "Your reward has been expired. Browse other rewards and get discounts!",
    this.buttonText = "Explore Rewards",
    this.onButtonTap,
  });

  final String errorTitle;
  final String errorDescription;
  final String buttonText;
  final VoidCallback? onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(1.0, -1.0),
            radius: 1.5,
            colors: [
              const Color(0xFFBA1404).withValues(alpha: 0.15),
              const Color(0xFFBA1404).withValues(alpha: 0.2),
              const Color(0xFFBA1404).withValues(alpha: 0.45),
            ],
            stops: const [0.0, 0.15, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0.rw),
            child: Column(
              children: [
                // Close button
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 28.rw,
                      height: 28.rh,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.rw),
                      ),
                      child: Assets.common.cancel.svg(),
                    ),
                  ),
                ),

                Spacer(),

                // Error icon
                Center(
                  child: Container(
                    width: 80.rw,
                    height: 80.rh,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 31,
                          offset: const Offset(0, 31),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 20,
                          offset: const Offset(0, 20),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 11,
                          offset: const Offset(0, 11),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Center(child: Assets.rewards.errorCircle.svg()),
                  ),
                ),

                44.rh.heightWidth,

                // Title and description
                Column(
                  children: [
                    Text(
                      errorTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF171717),
                        fontSize: 20.rfs,
                        fontFamily: 'Familjen Grotesk',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                        height: 1.2,
                      ),
                    ),

                    8.rh.heightWidth,

                    Text(
                      errorDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF575757),
                        fontSize: 14.rfs,
                        fontFamily: 'Inter Display',
                        fontWeight: FontWeight.w400,
                        height: 1.57,
                      ),
                    ),
                  ],
                ).paddingX(40.rw),

                Spacer(),
                // Action button
                GestureDetector(
                  onTap: onButtonTap ?? () => context.pop(),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.rw),
                    height: 56.rh,
                    decoration: BoxDecoration(
                      color: const Color(0xFF000C0B),
                      borderRadius: BorderRadius.circular(12.rw),
                    ),
                    child: Center(
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.rfs,
                          fontFamily: 'Familjen Grotesk',
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.36,
                          height: 1.11,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
