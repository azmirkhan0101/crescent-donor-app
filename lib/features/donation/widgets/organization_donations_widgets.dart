import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/organization_donations_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

/// Organization Detail Card Widget
///
/// Displays organization information including cover image, logo, name,
/// verification badge, tags, and description
class OrganizationDetailCard extends StatelessWidget {
  final OrganizationData organization;

  const OrganizationDetailCard({super.key, required this.organization});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(height: 160.rh),
            Container(
              height: 120.rh,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.rw)),
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/343/120"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 80.rw,
                height: 80.rh,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100.rw)),
                  border: Border.all(color: Color(0xFFE9B7AD)),
                  image: DecorationImage(
                    alignment: Alignment.center,
                    image: NetworkImage("https://picsum.photos/id/237/200/300"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),

        Gap(12.rh),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.rw,
          children: [
            Text(
              'Hope for Learning Foundation',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF000C0B) /* Colors-Off-Black */,
                fontSize: 18,
                fontFamily: 'Familjen Grotesk',
                fontWeight: FontWeight.w700,
                height: 1.33,
                letterSpacing: -0.18,
              ),
            ),

            SvgPicture.asset('assets/common/verified.svg'),
          ],
        ),

        Gap(12.rh),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.rw,
          children: [
            _buildTag('📚 Education', const Color(0xFFC5F6C9)),
            _buildTag('🌍 South Asia', const Color(0xFFFFFFFF)),
          ],
        ),
      ],
    );
  }

  Container _buildTag(String tag, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.rw, vertical: 4.rh),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 4,
        children: [
          Text(
            tag,
            style: TextStyle(
              color: const Color(0xFF000C0B) /* Colors-Off-Black */,
              fontSize: 10,
              fontFamily: 'Inter Display',
              fontWeight: FontWeight.w400,
              height: 1.20,
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
      height: 78.rh,
      padding: EdgeInsets.all(8.rw),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.rw),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (donation.status != DonationStatus.failed)
            Assets.common.rewardCoin.svg(
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
            ),
          Text(
            'Wed',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontFamily: 'Inter Display',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.24,
            ),
          ),
          Text(
            '17',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontFamily: 'Inter Display',
              fontWeight: FontWeight.w500,
            ),
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
