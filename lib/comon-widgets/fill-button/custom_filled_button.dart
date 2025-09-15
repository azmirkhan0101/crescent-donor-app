import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key,
    this.title,
    this.onTap,
    this.fillColor,
    this.textColor,
  });
  final String? title;
  final VoidCallback? onTap;
  final Color? fillColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap ?? () {},
      style: FilledButton.styleFrom(
        backgroundColor: fillColor ?? AppColors.secondaryColor,
        fixedSize: const Size(double.maxFinite, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        title ?? "Get Started",
        style: GoogleFonts.familjenGrotesk(
          fontSize: 18,
          color: textColor ?? AppColors.blackLightColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
