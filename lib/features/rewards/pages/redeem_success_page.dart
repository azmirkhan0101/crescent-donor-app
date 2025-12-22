import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RedeemSuccessPage extends StatelessWidget {
  const RedeemSuccessPage({
    super.key,
    this.rewardTitle = "Reward redeemed successfully!",
    this.rewardDescription =
        "Your reward has been redeemed successfully via QR code at the store.",
    this.onDone,
  });

  final String rewardTitle;
  final String rewardDescription;
  final VoidCallback? onDone;

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
              AppColors.secondaryColor.withValues(alpha: 0.05),
              AppColors.secondaryColor.withValues(alpha: 0.1),
              AppColors.secondaryColor,
            ],
            stops: const [0.0, 0.15, 1.0],
          ),
        ),
        child: SafeArea(
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
              // Success icon with decorative elements
              Assets.rewards.redeemCompleted.image(width: 96.rw, height: 96.rh),
              38.rh.heightWidth,
              // Title and description
              Column(
                children: [
                  Text(
                    rewardTitle,
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
                    rewardDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF575757),
                      fontSize: 14.rfs,
                      fontFamily: 'Inter Display',
                      fontWeight: FontWeight.w400,
                      height: 1.57,
                    ),
                  ).paddingX(16.rw),
                ],
              ).paddingX(8.rw),

              Spacer(),
              // Done button
              GestureDetector(
                onTap: onDone ?? () => context.pop(),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.rw),
                  height: 56.rh,
                  decoration: BoxDecoration(
                    color: const Color(0xFF000C0B),
                    borderRadius: BorderRadius.circular(12.rw),
                  ),
                  child: Center(
                    child: Text(
                      'Done',
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
          ).paddingAll(16.rw),
        ),
      ),
    );
  }
}
