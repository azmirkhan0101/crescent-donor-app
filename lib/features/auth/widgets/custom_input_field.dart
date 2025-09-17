import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    this.controller,
    this.obscureText,
    this.keyboardType,
    this.textInputAction,
    this.hintText,
    this.prefixIcon,
    this.isPrefixIcon = true,
    this.minLines = 1,
  });

  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Widget? prefixIcon;
  final bool isPrefixIcon;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: minLines,
      maxLines: minLines,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      textInputAction: textInputAction ?? TextInputAction.next,
      style: AppTextStyles.baseStyle().copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
      decoration: InputDecoration(
        hint: hintText?.text(
          AppTextStyles.baseStyle().copyWith(
            fontWeight: FontWeight.w500,
            color: "#CCCCCC".hexColor,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
        ),
        prefixIcon: isPrefixIcon
            ? (prefixIcon ?? Assets.icons.mail.svg()).paddingOnly(
                left: 16.rw,
                right: 8.rw,
              )
            : null,
        prefixIconConstraints: BoxConstraints(
          minWidth: 16.rw,
          minHeight: 14.rh,
        ),
        suffixIcon: obscureText == true
            ? GestureDetector(
                onTap: () {
                  // toggle password visibility
                },
                child: Assets.icons.eye.svg().paddingOnly(right: 16.rw),
                // child: Icon(
                //   Icons.visibility_off,
                //   color: "#CCCCCC".hexColor,
                //   size: 20.rw,
                // ).paddingOnly(right: 16.rw),
              )
            : null,
        suffixIconConstraints: BoxConstraints(
          minWidth: 16.rw,
          minHeight: 10.rh,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.rw),
          borderSide: BorderSide(color: "#E4E4E4".hexColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.rw),
          borderSide: BorderSide(color: "#E4E4E4".hexColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.rw),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.rh,
          horizontal: 16.rw,
        ),
      ),
    );
  }
}
