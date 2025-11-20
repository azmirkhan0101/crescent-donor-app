import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Calendar Day State Enum
/// Defines the different states a calendar day can have
enum CalendarDayState {
  uncompletedPrevious, // Both background and border: #EBE9EC
  uncompletedCurrent, // Both background and border: #1AC461
  completed, // Background: #FFFFFF, border: #1AC461
  upcoming, // Both background and border: white
}

/// Round Up Donation Card Widget
///
/// Displays the main round-up donation information with amount and auto-donation details
class RoundUpCard extends StatelessWidget {
  final String roundUpAmount;
  final String donationOrganization;
  final String daysUntilDonation;
  final VoidCallback? onTap;

  const RoundUpCard({
    super.key,
    required this.roundUpAmount,
    required this.donationOrganization,
    required this.daysUntilDonation,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: DonationConstants.roundUpCardBg,
          borderRadius: BorderRadius.circular(
            DonationConstants.cardBorderRadius.rw,
          ),
          border: Border.all(color: DonationConstants.roundUpBorder, width: 1),
        ),
        padding: EdgeInsets.all(16.rw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card header with icon and title
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.rw),
                  decoration: BoxDecoration(
                    color: DonationConstants.cardWhite,
                    borderRadius: BorderRadius.circular(
                      DonationConstants.buttonBorderRadius.rw,
                    ),
                  ),
                  child: Icon(
                    Icons.change_circle_outlined,
                    size: DonationConstants.iconSizeMedium.rfs,
                    color: DonationConstants.offBlack,
                  ),
                ),
                SizedBox(width: 8.rw),
                Text(
                  'Round Up',
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: DonationConstants.fontSize14.rfs,
                    fontWeight: FontWeight.w600,
                    color: DonationConstants.offBlack,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.rh),
            // Main content area
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You've rounded up",
                        style: TextStyle(
                          fontFamily: DonationFonts.interDisplay,
                          fontSize: DonationConstants.fontSize12.rfs,
                          fontWeight: FontWeight.w400,
                          color: DonationConstants.offBlack,
                        ),
                      ),
                      SizedBox(height: 4.rh),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\$',
                              style: TextStyle(
                                fontFamily: DonationFonts.familjenGrotesk,
                                fontSize: DonationConstants.fontSize40.rfs,
                                fontWeight: FontWeight.w700,
                                color: DonationConstants.roundUpAmountColor
                                    .withValues(
                                      alpha: DonationConstants.amountOpacity,
                                    ),
                                letterSpacing: -0.7,
                              ),
                            ),
                            TextSpan(
                              text: roundUpAmount,
                              style: TextStyle(
                                fontFamily: DonationFonts.familjenGrotesk,
                                fontSize: DonationConstants.fontSize40.rfs,
                                fontWeight: FontWeight.w700,
                                color: DonationConstants.roundUpAmountColor,
                                letterSpacing: -0.7,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.rw),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: DonationFonts.interDisplay,
                        fontSize: DonationConstants.fontSize12.rfs,
                        fontWeight: FontWeight.w400,
                        color: DonationConstants.offBlack,
                        height: 16 / 12,
                      ),
                      children: [
                        const TextSpan(text: 'Auto-donating to '),
                        TextSpan(
                          text: donationOrganization,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: DonationConstants.primaryPurpleDark,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(text: ' in $daysUntilDonation days.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.rh),
            // Divider line
            Container(height: 1, color: DonationConstants.lightGray),
            SizedBox(height: 24.rh),
            // Footer message
            Text(
              "Keep going—You're making real change.",
              style: TextStyle(
                fontFamily: DonationFonts.interDisplay,
                fontSize: DonationConstants.fontSize12.rfs,
                fontWeight: FontWeight.w400,
                color: DonationConstants.offBlack,
                height: 16 / 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small Donation Card Widget (for Recurring and One Time cards)
///
/// Displays donation type with amount in a compact format
class SmallDonationCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color backgroundColor;
  final Color borderColor;
  final Color amountColor;
  final String icon;
  final VoidCallback? onTap;

  const SmallDonationCard({
    super.key,
    required this.title,
    required this.amount,
    required this.backgroundColor,
    required this.borderColor,
    required this.amountColor,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: DonationConstants.smallCardWidth.rw,
        height: DonationConstants.smallCardHeight.rh,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            DonationConstants.cardBorderRadius.rw,
          ),
          border: Border.all(color: borderColor, width: 1),
        ),
        padding: EdgeInsets.all(16.rw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card header with icon and title
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.rw),
                  decoration: BoxDecoration(
                    color: DonationConstants.cardWhite,
                    borderRadius: BorderRadius.circular(
                      DonationConstants.buttonBorderRadius.rw,
                    ),
                  ),
                  child: SvgPicture.asset(icon),
                ),
                SizedBox(width: 8.rw),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: DonationFonts.interDisplay,
                      fontSize: DonationConstants.fontSize14.rfs,
                      fontWeight: FontWeight.w600,
                      color: DonationConstants.offBlack,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Amount display
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\$',
                    style: TextStyle(
                      fontFamily: DonationFonts.familjenGrotesk,
                      fontSize: DonationConstants.fontSize40.rfs,
                      fontWeight: FontWeight.w700,
                      color: amountColor.withValues(
                        alpha: DonationConstants.amountOpacity,
                      ),
                      letterSpacing: -0.7,
                    ),
                  ),
                  TextSpan(
                    text: amount,
                    style: TextStyle(
                      fontFamily: DonationFonts.familjenGrotesk,
                      fontSize: DonationConstants.fontSize40.rfs,
                      fontWeight: FontWeight.w700,
                      color: amountColor,
                      letterSpacing: -0.7,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Calendar Day Widget
/// Displays a single day in the calendar with different states based on CalendarDayState enum
class CalendarDayWidget extends StatelessWidget {
  final String dayName;
  final String dayNumber;
  final CalendarDayState state;
  final bool hasIcon;
  final bool isToday;

  const CalendarDayWidget({
    super.key,
    required this.dayName,
    required this.dayNumber,
    required this.state,
    this.hasIcon = false,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color borderColor;
    Color iconColor;
    Color dayColor;
    Color dateColor;

    switch (state) {
      case CalendarDayState.upcoming:
        backgroundColor = AppColors.white;
        borderColor = AppColors.white;
        iconColor = AppColors.white;
        dayColor = Color(0xFFBFC2C2);
        dateColor = Color(0xFF000C0B);
        break;
      case CalendarDayState.completed:
        backgroundColor = Color(0xFFEBE9EC);
        borderColor = Color(0xFFEBE9EC);
        iconColor = Color(0xFFEBE9EC);
        dayColor = Color(0xFFB0B2B4);
        dateColor = Color(0xFFB0B2B4);
        break;
      case CalendarDayState.uncompletedPrevious:
        backgroundColor = AppColors.white;
        borderColor = Color(0xFF1AC461);
        dayColor = Color(0xFF1AC461);
        dateColor = Color(0xFF1AC461);
        iconColor = Color(0xFF1AC461);
        break;
      case CalendarDayState.uncompletedCurrent:
        backgroundColor = Color(0xFF1AC461);
        borderColor = Color(0xFF1AC461);
        dayColor = AppColors.white;
        dateColor = AppColors.white;
        iconColor = AppColors.white;
        break;
    }

    return Container(
      height: 78.rh,
      padding: EdgeInsets.all(8.rw),
      width: 56.rw,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.rw),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (state == CalendarDayState.uncompletedPrevious ||
              state == CalendarDayState.uncompletedCurrent)
            Assets.common.rewardCoin
                .svg(colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn))
                .paddingB(4.rh),

          Text(
            dayName,
            style: TextStyle(
              fontFamily: DonationFonts.interDisplay,
              fontSize: 10.rfs,
              fontWeight: FontWeight.w400,
              color: dayColor,
              letterSpacing: -0.24,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            dayNumber,
            style: TextStyle(
              fontFamily: DonationFonts.interDisplay,
              fontSize: 14.rfs,
              fontWeight: FontWeight.w500,
              color: dateColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// Badge Card Widget
///
/// Displays achievement badges with progress indicators
// class BadgeCard extends StatelessWidget {
//   final String badgeName;
//   final String? progressText;
//   final String description;
//   final String? badgeImage;
//   final double progress; // 0.0 to 1.0

//   const BadgeCard({
//     super.key,
//     required this.badgeName,
//     this.progressText,
//     required this.description,
//     this.badgeImage,
//     required this.progress,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: DonationConstants.badgeCardWidth.rw,
//       height: 230.rh, // Fixed height to prevent overflow
//       decoration: BoxDecoration(
//         color: DonationConstants.cardWhite,
//         borderRadius: BorderRadius.circular(
//           DonationConstants.cardBorderRadius.rw,
//         ),
//         border: Border.all(color: DonationConstants.cardBorder, width: 1),
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 6.rw, vertical: 6.rh),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Badge image container
//           Container(
//             height: 100.rh, // Reduced height
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: DonationConstants.offWhite,
//               borderRadius: BorderRadius.circular(
//                 DonationConstants.smallCardBorderRadius.rw,
//               ),
//             ),
//             child: badgeImage != null
//                 ? Center(
//                     child: Image.asset(
//                       badgeImage!,
//                       width: 72.rw, // Reduced size
//                       height: 72.rw,
//                       fit: BoxFit.contain,
//                     ),
//                   )
//                 : Icon(
//                     Icons.emoji_events_outlined,
//                     size: 72.rfs, // Reduced size
//                     color: DonationConstants.mediumGrayText,
//                   ),
//           ),
//           SizedBox(height: 6.rh), // Reduced spacing
//           // Badge info
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 4.rw),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Text(
//                           badgeName,
//                           style: TextStyle(
//                             fontFamily: DonationFonts.interDisplay,
//                             fontSize: 12.rfs, // Reduced font size
//                             fontWeight: FontWeight.w500,
//                             color: DonationConstants.offBlack,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       if (progressText != null)
//                         Text(
//                           progressText!,
//                           style: TextStyle(
//                             fontFamily: DonationFonts.interDisplay,
//                             fontSize: 10.rfs, // Reduced font size
//                             fontWeight: FontWeight.w400,
//                             color: DonationConstants.mediumGrayText,
//                           ),
//                         ),
//                     ],
//                   ),
//                   SizedBox(height: 6.rh), // Reduced spacing
//                   // Progress bar
//                   Container(
//                     height: DonationConstants.progressBarHeight.rh,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: DonationConstants.lightGray,
//                       borderRadius: BorderRadius.circular(24.rw),
//                     ),
//                     child: FractionallySizedBox(
//                       alignment: Alignment.centerLeft,
//                       widthFactor: progress.clamp(0.0, 1.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: DonationConstants.offBlack,
//                           borderRadius: BorderRadius.circular(24.rw),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 6.rh), // Reduced spacing
//                   // Description
//                   Expanded(
//                     child: Text(
//                       description,
//                       style: TextStyle(
//                         fontFamily: DonationFonts.interDisplay,
//                         fontSize: 10.rfs, // Reduced font size
//                         fontWeight: FontWeight.w400,
//                         color: DonationConstants.mediumGrayText,
//                         height: 14 / 10,
//                       ),
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
