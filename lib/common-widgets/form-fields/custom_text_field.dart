import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.label,
    this.hintText,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.helperText,
    this.fillColor,
    this.borderRadius,
    this.contentPadding,
    this.inputFormatters,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.expands = false,
  });

  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final String? helperText;
  final Color? fillColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final bool expands;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (label != null) ...[
          Text(
            label!,
            style: AppTextStyles.baseStyle().copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          8.rh.heightWidth,
        ],

        // Text Field
        TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          onTap: onTap,
          onFieldSubmitted: onFieldSubmitted,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          autofocus: autofocus,
          maxLines: expands ? null : maxLines,
          minLines: minLines,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          focusNode: focusNode,
          textCapitalization: textCapitalization,
          textAlign: textAlign,
          expands: expands,
          style: AppTextStyles.baseStyle().copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.baseStyle().copyWith(
              fontWeight: FontWeight.w500,
              color: "#CCCCCC".hexColor,
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
            errorText: errorText,
            helperText: helperText,
            helperStyle: AppTextStyles.baseStyle().copyWith(
              fontSize: 12.rfs,
              color: AppColors.grayColor,
            ),
            errorStyle: AppTextStyles.baseStyle().copyWith(
              fontSize: 12.rfs,
              color: AppColors.redColor,
            ),
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(left: 16.rw, right: 8.rw),
                    child: prefixIcon!,
                  )
                : null,
            prefixIconConstraints: prefixIcon != null
                ? BoxConstraints(minWidth: 16.rw, minHeight: 14.rh)
                : null,
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: EdgeInsets.only(right: 16.rw),
                    child: suffixIcon!,
                  )
                : null,
            suffixIconConstraints: suffixIcon != null
                ? BoxConstraints(minWidth: 16.rw, minHeight: 10.rh)
                : null,
            filled: fillColor != null,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: "#E4E4E4".hexColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: "#E4E4E4".hexColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: AppColors.redColor, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12.rw),
              borderSide: BorderSide(color: AppColors.redColor, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(12.rw),
              borderSide: BorderSide(
                color: "#E4E4E4".hexColor.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            isDense: true,
            contentPadding:
                contentPadding ??
                EdgeInsets.symmetric(vertical: 16.rh, horizontal: 16.rw),
          ),
        ),
      ],
    );
  }
}
