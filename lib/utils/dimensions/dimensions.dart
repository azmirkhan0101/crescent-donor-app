import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Dimensions {
  //screen size
  static double mobileScreenWidth = 575;
  static double tabletScreenWidth = 1100;

  // padding and margin
  static double paddingSize = 24.00.h;
  static double marginBetweenInputTitleAndBox = 8.h;
  static double marginBetweenInputBox = 16.h;
  static double marginSizeHorizontal = 24.00.w;
  static double marginSizeVertical = 24.00.h;
  static double marginSizeBetweenColumn = 16.00.w;

  // widget size
  static double buttonHeight = 56.00.h;
  static double inputBoxHeight = 56.00.h;
  static double appBarHeight = 64.4.h;

  static double iconSizeSmall = 8.00.h;
  static double iconSizeDefault = 16.00.h;
  static double iconSizeLarge = 24.00.h;

  // typography size
  static double headingTextSize1 = 24.00.sp;
  static double headingTextSize2 = 20.00.sp;
  static double headingTextSize3 = 16.00.sp;
  static double headingTextSize4 = 14.00.sp;
  static double headingTextSize5 = 12.00.sp;
  static double headingTextSize6 = 10.00.sp;

  //font size
  static double getFontSizeSmall(BuildContext context) =>
      context.width >= 1300 ? 15.sp : 12.sp;
  static double getFontSizeSemiSmall(BuildContext context) =>
      context.width >= 1300 ? 15.sp : 13.sp;
  static double getFontSizeDefault(BuildContext context) =>
      context.width >= 1300 ? 17.sp : 14.sp;
  static double getFontSizeLarge(BuildContext context) =>
      context.width >= 1300 ? 20.sp : 16.sp;
  static double getFontSizeExtraLarge(BuildContext context) =>
      context.width >= 1300 ? 20.sp : 18.sp;
  static double getButtonFontSize(BuildContext context) =>
      context.width >= 1300 ? 26.sp : 20.sp;
  static double getButtonFontSizeLarge(BuildContext context) =>
      context.width >= 1300 ? 30.sp : 24.sp;

  static double getFontSizeOverLarge(BuildContext context) =>
      context.width >= 1300 ? 56.sp : 46.sp;
  static double getFontSizeForReview(BuildContext context) => 36.sp;

  // radius size
  static double radius = 10.00.r;
  static double radiusSmall = 5.0.r;
  static double radiusDefault = 16.0.r;
  static double radiusLarge = 20.0.r;
  static double radiusExtraLarge = 32.0.r;
  static double radiusExtraMoreLarge = 50.0.r;

  // default height and width size
  static double heightSize = 12.00.h;
  static double widthSize = 10.00.w;
}
