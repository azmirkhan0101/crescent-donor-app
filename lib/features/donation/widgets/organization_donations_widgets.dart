import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/organization_donations_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Organization Detail Card Widget
///
/// Displays organization information including cover image, logo, name,
/// verification badge, tags, and description
class OrganizationDetailCard extends StatelessWidget {
  final OrganizationData organization;

  const OrganizationDetailCard({super.key, required this.organization});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.rw,
      height: 260.rh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.rw),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            offset: Offset(0, 2.rh),
            blurRadius: 5.rw,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Cover Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120.rh,
              decoration: BoxDecoration(
                color: const Color(0xFFF4E4C1), // Fallback color from Figma
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.rw),
                  topRight: Radius.circular(16.rw),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.rw),
                  topRight: Radius.circular(16.rw),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFF4E4C1), Color(0xFFE8D5A8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: 40.rw,
                      color: Colors.brown.withValues(alpha: 0.3),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content Container
          Positioned(
            top: 80.rh,
            left: 32.rw,
            right: 32.rw,
            child: Container(
              height: 180.rh,
              decoration: BoxDecoration(
                color: DonationConstants.cardWhite,
                borderRadius: BorderRadius.circular(16.rw),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.rw, vertical: 16.rh),
              child: Column(
                children: [
                  // Logo
                  Container(
                    width: 80.rw,
                    height: 80.rh,
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFE91E63,
                      ), // Pink background for sample logo
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE4E4E4),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'HOPE',
                        style: TextStyle(
                          fontFamily: DonationFonts.familjenGrotesk,
                          fontSize: 12.rfs,
                          fontWeight: FontWeight.bold,
                          color: DonationConstants.cardWhite,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 12.rh),

                  // Organization Details
                  Column(
                    children: [
                      // Name with verification badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              organization.name,
                              style: TextStyle(
                                fontFamily: DonationFonts.familjenGrotesk,
                                fontSize: 18.rfs,
                                fontWeight: FontWeight.bold,
                                color: DonationConstants.offBlack,
                                letterSpacing: -0.18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          if (organization.isVerified) ...[
                            SizedBox(width: 8.rw),
                            Container(
                              width: 20.rw,
                              height: 20.rh,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1AC461),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                size: 12.rw,
                                color: DonationConstants.cardWhite,
                              ),
                            ),
                          ],
                        ],
                      ),

                      SizedBox(height: 8.rh),

                      // Tags
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: organization.tags
                            .map(
                              (tag) => Padding(
                                padding: EdgeInsets.only(right: 8.rw),
                                child: _buildTag(tag),
                              ),
                            )
                            .toList(),
                      ),

                      SizedBox(height: 8.rh),

                      // Description
                      Text(
                        organization.description,
                        style: TextStyle(
                          fontFamily: DonationFonts.interDisplay,
                          fontSize: 12.rfs,
                          fontWeight: FontWeight.w400,
                          color: DonationConstants.offBlack,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build tag widget
  Widget _buildTag(OrganizationTag tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.rw, vertical: 4.rh),
      decoration: BoxDecoration(
        color: tag.isHighlighted
            ? const Color(0xFFC6F7C9)
            : DonationConstants.cardWhite,
        borderRadius: BorderRadius.circular(24.rw),
        border: tag.isHighlighted
            ? null
            : Border.all(color: const Color(0xFFE4E4E4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tag.emoji, style: TextStyle(fontSize: 10.rfs)),
          SizedBox(width: 4.rw),
          Text(
            tag.label,
            style: TextStyle(
              fontFamily: DonationFonts.interDisplay,
              fontSize: 10.rfs,
              fontWeight: FontWeight.w400,
              color: DonationConstants.offBlack,
            ),
          ),
        ],
      ),
    );
  }
}

/// Organization Donation Item Widget
///
/// Displays individual donation items with date calendar, title,
/// status and amount based on the donation state
class OrganizationDonationItem extends StatelessWidget {
  final OrganizationDonation donation;
  final bool isUpcoming;

  const OrganizationDonationItem({
    super.key,
    required this.donation,
    required this.isUpcoming,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date Calendar
        _buildDateCalendar(),

        SizedBox(width: 9.rw),

        // Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.rh),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  donation.title,
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: 14.rfs,
                    fontWeight: FontWeight.w500,
                    color: DonationConstants.offBlack,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 8.rh),

                // Status and Amount Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_buildStatusSection(), _buildAmountSection()],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Build date calendar widget
  Widget _buildDateCalendar() {
    final isUpcomingStyle = isUpcoming;
    final bgColor = isUpcomingStyle
        ? DonationConstants.calendarActiveBg
        : (donation.status == DonationStatus.successful
              ? DonationConstants.cardWhite
              : const Color(0x14F0323C)); // rgba(240,50,60,0.08)

    final borderColor = isUpcomingStyle
        ? DonationConstants.calendarActiveBg
        : (donation.status == DonationStatus.successful
              ? DonationConstants.calendarActiveBorder
              : const Color(0xFFF0323C));

    final textColor = isUpcomingStyle
        ? DonationConstants.cardWhite
        : (donation.status == DonationStatus.successful
              ? DonationConstants.calendarActiveBg
              : const Color(0xFFF0323C));

    return Container(
      width: 56.rw,
      padding: EdgeInsets.all(8.rw),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.rw),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          // Icon (only for upcoming donations)
          if (isUpcoming) ...[
            SvgPicture.asset(
              Assets.common.calendar.path,
              width: 24.rw,
              height: 24.rh,
              colorFilter: ColorFilter.mode(
                DonationConstants.cardWhite,
                BlendMode.srcIn,
              ),
            ),
          ] else ...[
            Container(
              width: 24.rw,
              height: 24.rh,
              decoration: BoxDecoration(
                color: donation.status == DonationStatus.successful
                    ? DonationConstants.calendarActiveBg
                    : const Color(0xFFF0323C),
                shape: BoxShape.circle,
              ),
              child: Icon(
                donation.status == DonationStatus.successful
                    ? Icons.check
                    : Icons.close,
                size: 16.rw,
                color: DonationConstants.cardWhite,
              ),
            ),
          ],

          SizedBox(height: 2.rh),

          // Day name
          Text(
            donation.dayName,
            style: TextStyle(
              fontFamily: DonationFonts.interDisplay,
              fontSize: 12.rfs,
              fontWeight: FontWeight.w400,
              color: textColor,
              letterSpacing: -0.24,
            ),
            textAlign: TextAlign.center,
          ),

          // Day number
          Text(
            donation.dayNumber,
            style: TextStyle(
              fontFamily: DonationFonts.interDisplay,
              fontSize: 16.rfs,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build status section (tag and date/time)
  Widget _buildStatusSection() {
    if (isUpcoming) {
      // For upcoming donations, show timer icon and date/time
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 8.rh),
        decoration: BoxDecoration(
          color: donation.status.backgroundColor,
          borderRadius: BorderRadius.circular(16.rw),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              Assets.common.timer.path,
              width: 16.rw,
              height: 16.rh,
            ),
            SizedBox(width: 4.rw),
            Text(
              '${donation.formattedDate} - ${donation.time}',
              style: TextStyle(
                fontFamily: DonationFonts.interDisplay,
                fontSize: 12.rfs,
                fontWeight: FontWeight.w400,
                color: DonationConstants.offBlack,
              ),
            ),
          ],
        ),
      );
    } else {
      // For previous donations, show status and date/time
      return Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 8.rh),
            decoration: BoxDecoration(
              color: donation.status.backgroundColor,
              borderRadius: BorderRadius.circular(16.rw),
            ),
            child: Text(
              donation.status.displayName,
              style: TextStyle(
                fontFamily: DonationFonts.interDisplay,
                fontSize: 12.rfs,
                fontWeight: FontWeight.w400,
                color: donation.status.textColor,
              ),
            ),
          ),
          SizedBox(width: 8.rw),
          Text(
            '${donation.formattedDate} - ${donation.time}',
            style: TextStyle(
              fontFamily: DonationFonts.interDisplay,
              fontSize: 12.rfs,
              fontWeight: FontWeight.w400,
              color: DonationConstants.offBlack,
            ),
          ),
        ],
      );
    }
  }

  /// Build amount section
  Widget _buildAmountSection() {
    final displayText = donation.status.amountDisplay.isEmpty
        ? '${donation.status.amountPrefix}${donation.amount.toInt()}'
        : donation.status.amountDisplay;

    return Text(
      displayText,
      style: TextStyle(
        fontFamily: DonationFonts.interDisplay,
        fontSize: 14.rfs,
        fontWeight: FontWeight.w400,
        color: donation.status.amountColor,
      ),
    );
  }
}
