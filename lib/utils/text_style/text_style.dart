import 'package:flutter/material.dart';

import 'dart:io';

const interLight = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w300,
);

const interExtraLight = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w200,
);

const interThin = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w100,
);

const interRegular = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,
);

const interMedium = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w500,
);

const interSemiBold = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

const interBold = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w700,
);

const interExtraBold = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w800,
);

const interBlack = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w900,
);

//==============custom text styles================
//------------------------------------------------

TextStyle regularText(double size, {Color color = Colors.black}) => TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w400,
    );

TextStyle mediumText(double size, {Color color = Colors.black}) => TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
    );

TextStyle semiBoldText(double size, {Color color = Colors.black}) => TextStyle(
      fontSize: size,
      color: color,
      fontWeight: Platform.isIOS ? FontWeight.w500 : FontWeight.w600,
    );

TextStyle boldText(double size, {Color color = Colors.black}) => TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w700,
    );

TextStyle extraBoldText(double size, {Color color = Colors.black}) => TextStyle(
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w900,
    );
