import 'package:flutter/material.dart';

/// Donation Page Constants
///
/// Contains all the colors, dimensions, and styling constants for the donation page
/// following the Figma design specifications
class DonationConstants {
  // Colors from Figma design
  static const Color backgroundColor = Color(0xFFF7F7F7);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color offBlack = Color(0xFF000C0B);
  static const Color primaryPurple = Color(0xFFC08FFF);
  static const Color primaryPurpleDark = Color(0xFF9D68DE);
  static const Color secondaryLime = Color(0xFFD1FF43);
  static const Color lightGray = Color(0xFFEBE9EC);
  static const Color offWhite = Color(0xFFF9F7F9);
  static const Color grayText = Color(0xFF515A59);
  static const Color lightGrayText = Color(0xFF657271);
  static const Color mediumGrayText = Color(0xFF818F8D);
  static const Color neutralGray = Color(0xFF171717);
  static const Color black = Color(0xFF000000);

  // Specific card background colors from Figma
  static const Color roundUpCardBg = Color(0xFFF5F0FC);
  static const Color recurringCardBg = Color(0xFFE6FAED);
  static const Color oneTimeCardBg = Color(0xFFFFE8FD);
  static const Color progressCardBg = Color(0xFFFFFFFF);
  static const Color calendarActiveBg = Color(0xFF1AC461);
  static const Color calendarInactiveBg = Color(0xFFEBE9EC);
  static const Color upcomingDonationTagBg = Color(0x40A6F6E6);

  // Border colors
  static const Color roundUpBorder = Color(0xFFC08FFF);
  static const Color recurringBorder = Color(0xFF9DF2C1);
  static const Color oneTimeBorder = Color(0xFFFED0F9);
  static const Color cardBorder = Color(0xFFEDEDED);
  static const Color calendarActiveBorder = Color(0xFF1AC461);

  // Calendar specific colors based on requirements
  static const Color calendarCompletedPreviousBg = Color(0xFFEBE9EC);
  static const Color calendarCompletedPreviousBorder = Color(0xFFEBE9EC);
  static const Color calendarCompletedCurrentBg = Color(0xFF1AC461);
  static const Color calendarCompletedCurrentBorder = Color(0xFF1AC461);
  static const Color calendarUncompletedBg = Color(0xFFFFFFFF);
  static const Color calendarUncompletedBorder = Color(0xFF1AC461);
  static const Color calendarUpcomingBg = Color(0xFFFFFFFF);
  static const Color calendarUpcomingBorder = Color(0xFFFFFFFF);

  // Text colors for amounts
  static const Color roundUpAmountColor = Color(0xFF9D68DE);
  static const Color recurringAmountColor = Color(0xFF049758);
  static const Color oneTimeAmountColor = Color(0xFFCC55AE);
  static const Color calendarActiveText = Color(0xFF1AC461);

  // Spacing and sizing constants
  static const double paddingHorizontal = 16.0;
  static const double paddingVertical = 20.0;
  static const double cardBorderRadius = 12.0;
  static const double smallCardBorderRadius = 8.0;
  static const double buttonBorderRadius = 32.0;
  static const double tagBorderRadius = 16.0;

  // Card dimensions
  static const double headerHeight = 44.0;
  static const double cardSpacing = 8.0;
  static const double sectionSpacing = 12.0;
  static const double roundUpCardHeight = 160.0;
  static const double smallCardWidth = 167.5;
  static const double smallCardHeight = 160.0;
  static const double calendarDaySize = 56.0;
  static const double badgeCardWidth = 160.0;
  static const double progressBarHeight = 6.0;

  // Icon sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 20.0;
  static const double iconSizeLarge = 24.0;
  static const double avatarSize = 44.0;

  // Typography sizes (matching Figma)
  static const double fontSize40 = 40.0;
  static const double fontSize28 = 28.0;
  static const double fontSize24 = 24.0;
  static const double fontSize20 = 20.0;
  static const double fontSize16 = 16.0;
  static const double fontSize14 = 14.0;
  static const double fontSize12 = 12.0;
  static const double fontSize10 = 10.0;

  // Opacity values
  static const double amountOpacity = 0.25;
  static const double inactiveOpacity = 0.25;
}

/// Font families used in the design
class DonationFonts {
  static const String familjenGrotesk = 'Familjen Grotesk';
  static const String interDisplay = 'Inter Display';
  static const String inter = 'Inter';
}
