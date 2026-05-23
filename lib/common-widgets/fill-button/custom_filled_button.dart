import 'package:cresent_charge_user_app/common-widgets/custom_loader/custom_loader.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/helper/extension/context_extension.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    this.title,
    this.onTap,
    this.fillColor,
    this.textColor,
    this.borderColor,
    this.loadingText,
  });
  final String? title;
  final VoidCallback? onTap;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final String? loadingText;

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    return FilledButton(
      onPressed: onTap ?? () {},
      style: FilledButton.styleFrom(
        backgroundColor: fillColor ?? AppColors.secondaryColor,
        fixedSize: Size(double.maxFinite, isTab ? 70 : 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(
          color:
              borderColor ??
              (fillColor == null ? Colors.transparent : AppColors.black),
          width: 1,
        ),
      ),
      child: loadingText != null
          ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingIndicator.small(color: AppColors.black),
                  SizedBox(width: 12.rw),
                  Text(
                    loadingText!,
                    style: GoogleFonts.familjenGrotesk(
                      fontSize: isTab ? 8.sp : 18,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          : Text(
              title ?? "Get Started",
              style: GoogleFonts.familjenGrotesk(
                fontSize: isTab ? 8.sp : 18,
                color: textColor ?? AppColors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
    );
  }
}
