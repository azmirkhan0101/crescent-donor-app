import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  /// base text style
  static TextStyle baseStyle([TextStyle? style]) {
    TextStyle fontFamily = style ?? GoogleFonts.familjenGrotesk();
    return fontFamily.copyWith(
      fontSize: 14.rfs,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF808080),
      letterSpacing: -0.5.rfs,
    );
  }

  /// f14 w400 styles
  static TextStyle f14W400([String? fontFamily]) {
    return TextStyle(
      fontSize: 14.rfs,
      fontWeight: FontWeight.w400,
      color: AppColors.grayColor,
      height: 20.rh / 14.rfs,
      letterSpacing: -0.5.rfs / 100 * 14,
      fontFamily: fontFamily ?? AppStrings.interDisplay,
    );
  }

  /// f20 w600 styles
  static TextStyle f20w600([String? fontFamily]) {
    return TextStyle(
      fontSize: 20.rfs,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF171717),
      height: 24.rh / 20.rfs,
      letterSpacing: -1.rfs / 100 * 20,
      fontFamily: fontFamily ?? AppStrings.familjenGrotesk,
    );
  }

  /// f28 w700 letterSpacing -2% styles
  static TextStyle f28W700([String? style]) {
    return TextStyle(
      fontSize: 28.rfs,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF000C0B),
      letterSpacing: -2.rfs / 100 * 28,
      height: 36.rh / 28.rfs,
      fontFamily: style ?? AppStrings.familjenGrotesk,
    );
  }

  ///
}

/// Extensions
extension TextStyleModifier on String {
  Text baseStyle({TextStyle? style}) {
    return Text(this, style: AppTextStyles.baseStyle(style));
  }
}

///
const interLight = TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w300);

const interExtraLight = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w200,
);

const interThin = TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w100);

const interRegular = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,
);

const interMedium = TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500);

const interSemiBold = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

const interBold = TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700);

const interExtraBold = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w800,
);

const interBlack = TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w900);

//==============custom text styles================
//------------------------------------------------

TextStyle regularText(double size, {Color color = Colors.black}) =>
    TextStyle(fontSize: size, color: color, fontWeight: FontWeight.w400);

TextStyle mediumText(double size, {Color color = Colors.black}) =>
    TextStyle(fontSize: size, color: color, fontWeight: FontWeight.w500);

TextStyle semiBoldText(double size, {Color color = Colors.black}) => TextStyle(
  fontSize: size,
  color: color,
  fontWeight: Platform.isIOS ? FontWeight.w500 : FontWeight.w600,
);

TextStyle boldText(double size, {Color color = Colors.black}) =>
    TextStyle(fontSize: size, color: color, fontWeight: FontWeight.w700);

TextStyle extraBoldText(double size, {Color color = Colors.black}) =>
    TextStyle(fontSize: size, color: color, fontWeight: FontWeight.w900);
