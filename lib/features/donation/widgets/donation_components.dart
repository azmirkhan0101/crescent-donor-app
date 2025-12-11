import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/url_parser/image_url_parser.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/donation_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/donation_chart.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

/// Donation Page Header Widget
///
/// Contains profile avatar, points display, and filter dropdown
class DonationHeader extends StatelessWidget {
  final String pointsEarned;
  final String filterText;
  final VoidCallback? onFilterTap;
  final String? profileImageUrl;

  const DonationHeader({
    super.key,
    required this.pointsEarned,
    this.filterText = 'Last 30 Days',
    this.onFilterTap,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DonationConstants.paddingHorizontal.rw,
      ),
      child: Row(
        children: [
          // Profile Avatar
          Container(
            width: DonationConstants.avatarSize.rw,
            height: DonationConstants.avatarSize.rw,
            decoration: BoxDecoration(
              color: DonationConstants.cardWhite,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE4E4E4), width: 0.5),
            ),
            child: profileImageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                      DonationConstants.avatarSize.rw / 2,
                    ),
                    child: Image.network(
                      profileImageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildDefaultAvatar(),
                    ),
                  )
                : _buildDefaultAvatar(),
          ),
          SizedBox(width: 16.rw),

          // Points Display
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Points Earned:',
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: DonationConstants.fontSize14.rfs,
                    fontWeight: FontWeight.w400,
                    color: DonationConstants.grayText,
                    height: 18 / 14,
                  ),
                ),
                SizedBox(height: 2.rh),
                Row(
                  children: [
                    Assets.common.coins.svg(),
                    4.rw.heightWidth,
                    "16000".text(AppTextStyles.f20w600()),
                  ],
                ),
              ],
            ),
          ),
          // Filter Dropdown
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 10.rh),
              decoration: BoxDecoration(
                color: DonationConstants.cardWhite,
                borderRadius: BorderRadius.circular(
                  DonationConstants.smallCardBorderRadius.rw,
                ),
                border: Border.all(color: const Color(0x1A000000), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    filterText,
                    style: TextStyle(
                      fontFamily: DonationFonts.interDisplay,
                      fontSize: DonationConstants.fontSize14.rfs,
                      fontWeight: FontWeight.w500,
                      color: DonationConstants.offBlack,
                      height: 16 / 14,
                    ),
                  ),
                  SizedBox(width: 8.rw),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: DonationConstants.fontSize14.rfs,
                    color: DonationConstants.offBlack,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return SvgPicture.asset(
      Assets.profile.profileImage.path,
      width: DonationConstants.avatarSize.rw,
      height: DonationConstants.avatarSize.rw,
    );
  }
}

/// Progress Tracking Card Widget
///
/// Contains donation chart and statistics
class ProgressTrackingCard extends StatelessWidget {
  const ProgressTrackingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<DonationController>(
      builder: (controller) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: DonationConstants.progressCardBg,
            borderRadius: BorderRadius.circular(
              DonationConstants.cardBorderRadius.rw,
            ),
            border: Border.all(color: DonationConstants.cardBorder, width: 1),
          ),
          padding: EdgeInsets.all(16.rw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon and title
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.rw),
                    decoration: BoxDecoration(
                      color: DonationConstants.roundUpCardBg,
                      borderRadius: BorderRadius.circular(
                        DonationConstants.buttonBorderRadius.rw,
                      ),
                    ),
                    child: Assets.common.heartOnHand.svg(
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    // child: Icon(
                    //   Icons.volunteer_activism_outlined,
                    //   size: DonationConstants.iconSizeMedium.rfs,
                    //   color: DonationConstants.offBlack,
                    // ),
                  ),
                  SizedBox(width: 8.rw),
                  Text(
                    'Total Donations',
                    style: TextStyle(
                      fontFamily: DonationFonts.interDisplay,
                      fontSize: DonationConstants.fontSize14.rfs,
                      fontWeight: FontWeight.w600,
                      color: DonationConstants.offBlack,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.rh),
              // Total donation info
              Text(
                "You've donated a total of",
                style: TextStyle(
                  fontFamily: DonationFonts.interDisplay,
                  fontSize: DonationConstants.fontSize12.rfs,
                  fontWeight: FontWeight.w400,
                  color: DonationConstants.offBlack,
                  height: 16 / 12,
                ),
              ),
              SizedBox(height: 4.rh),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\$',
                          style: TextStyle(
                            fontFamily: DonationFonts.familjenGrotesk,
                            fontSize: DonationConstants.fontSize24.rfs,
                            fontWeight: FontWeight.w700,
                            color: DonationConstants.offBlack.withValues(
                              alpha: DonationConstants.amountOpacity,
                            ),
                            letterSpacing: -0.7,
                          ),
                        ),
                        TextSpan(
                          text:
                              controller.clientStats.value?.totalDonationAmount
                                  .toStringAsFixed(2) ??
                              '0.00',
                          style: TextStyle(
                            fontFamily: DonationFonts.familjenGrotesk,
                            fontSize: DonationConstants.fontSize24.rfs,
                            fontWeight: FontWeight.w700,
                            color: DonationConstants.offBlack,
                            letterSpacing: -0.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4.rw),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.rh),
                    child: Text(
                      'in last 30 days.',
                      style: TextStyle(
                        fontFamily: DonationFonts.interDisplay,
                        fontSize: DonationConstants.fontSize12.rfs,
                        fontWeight: FontWeight.w400,
                        color: DonationConstants.offBlack,
                        height: 16 / 12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.rh),
              // Donation Chart
              DonationChart(),
              SizedBox(height: 16.rh),
              // Divider
              Container(height: 1, color: DonationConstants.lightGray),
              SizedBox(height: 16.rh),
              // Statistics
              Row(
                children: [
                  Text(
                    'Avg. daily donation:',
                    style: TextStyle(
                      fontFamily: DonationFonts.interDisplay,
                      fontSize: DonationConstants.fontSize12.rfs,
                      fontWeight: FontWeight.w400,
                      color: DonationConstants.offBlack,
                      height: 16 / 12,
                    ),
                  ),
                  SizedBox(width: 4.rw),
                  Text(
                    '\$${controller.clientStats.value?.averageDonation.toStringAsFixed(2) ?? '0.00'}',
                    style: TextStyle(
                      fontFamily: DonationFonts.interDisplay,
                      fontSize: DonationConstants.fontSize12.rfs,
                      fontWeight: FontWeight.w500,
                      color: DonationConstants.primaryPurpleDark,
                      height: 16 / 12,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.rh),
              Row(
                children: [
                  Text(
                    'Donation streak:',
                    style: TextStyle(
                      fontFamily: DonationFonts.interDisplay,
                      fontSize: DonationConstants.fontSize12.rfs,
                      fontWeight: FontWeight.w400,
                      color: DonationConstants.offBlack,
                      height: 16 / 12,
                    ),
                  ),
                  SizedBox(width: 4.rw),
                  Text(
                    '${controller.clientStats.value?.maxConsistencyStreak ?? '0'} days',
                    style: TextStyle(
                      fontFamily: DonationFonts.interDisplay,
                      fontSize: DonationConstants.fontSize12.rfs,
                      fontWeight: FontWeight.w500,
                      color: DonationConstants.primaryPurpleDark,
                      height: 16 / 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Upcoming Donation Card Widget
///
/// Displays scheduled donation information
class UpcomingDonationCard extends StatelessWidget {
  final String scheduledDate;
  final String organizationName;
  final String organizationLocation;
  final String donationAmount;
  final String? organizationImage;

  const UpcomingDonationCard({
    super.key,
    required this.scheduledDate,
    required this.organizationName,
    required this.organizationLocation,
    required this.donationAmount,
    this.organizationImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: DonationConstants.cardWhite,
        borderRadius: BorderRadius.circular(
          DonationConstants.cardBorderRadius.rw,
        ),
        border: Border.all(color: DonationConstants.cardBorder, width: 1),
      ),
      padding: EdgeInsets.all(16.rw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with date and donation icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Date tag
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.rw,
                  vertical: 8.rh,
                ),
                decoration: BoxDecoration(
                  color: DonationConstants.upcomingDonationTagBg,
                  borderRadius: BorderRadius.circular(
                    DonationConstants.tagBorderRadius.rw,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.common.timer.svg(),
                    SizedBox(width: 4.rw),
                    Text(
                      scheduledDate,
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
              // Donation icon
              Container(
                padding: EdgeInsets.all(10.rw),
                decoration: BoxDecoration(
                  color: DonationConstants.roundUpCardBg,
                  borderRadius: BorderRadius.circular(
                    DonationConstants.buttonBorderRadius.rw,
                  ),
                ),
                child: Assets.common.heartOnHand.svg(),
              ),
            ],
          ),
          SizedBox(height: 16.rh),
          // Organization info and amount
          Row(
            children: [
              // Organization info
              Expanded(
                child: Row(
                  children: [
                    // Organization image
                    if (organizationImage != null)
                      ClipOval(
                        child: Image.network(
                          parseImageUrl(organizationImage!),
                          width: 48.rw,
                          height: 48.rh,
                          errorBuilder: (context, error, stackTrace) =>
                              SizedBox(
                                width: 48.rw,
                                height: 48.rh,
                                child: Icon(
                                  Icons.image_not_supported,
                                  size: 24.rfs,
                                  color: DonationConstants.mediumGrayText,
                                ),
                              ),
                        ),
                      )
                    else
                      SizedBox(
                        width: 48.rw,
                        height: 48.rh,
                        child: Icon(
                          Icons.image_not_supported,
                          size: 24.rfs,
                          color: DonationConstants.mediumGrayText,
                        ),
                      ),
                    SizedBox(width: 8.rw),
                    // Organization details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            organizationName,
                            style: TextStyle(
                              fontFamily: DonationFonts.interDisplay,
                              fontSize: DonationConstants.fontSize16.rfs,
                              fontWeight: FontWeight.w500,
                              color: DonationConstants.offBlack,
                              height: 20 / 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.rh),
                          Text(
                            organizationLocation,
                            style: TextStyle(
                              fontFamily: DonationFonts.interDisplay,
                              fontSize: DonationConstants.fontSize12.rfs,
                              fontWeight: FontWeight.w400,
                              color: DonationConstants.lightGrayText,
                              height: 16 / 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.rw),
              // Donation amount
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$',
                      style: TextStyle(
                        fontFamily: DonationFonts.familjenGrotesk,
                        fontSize: DonationConstants.fontSize24.rfs,
                        fontWeight: FontWeight.w700,
                        color: DonationConstants.neutralGray.withValues(
                          alpha: DonationConstants.amountOpacity,
                        ),
                        letterSpacing: -0.48,
                      ),
                    ),
                    TextSpan(
                      text: donationAmount,
                      style: TextStyle(
                        fontFamily: DonationFonts.familjenGrotesk,
                        fontSize: DonationConstants.fontSize24.rfs,
                        fontWeight: FontWeight.w700,
                        color: DonationConstants.neutralGray,
                        letterSpacing: -0.48,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _buildDefaultOrgIcon() {
  //   return Icon(
  //     Icons.favorite_outline,
  //     size: 24.rfs,
  //     color: DonationConstants.mediumGrayText,
  //   );
  // }
}
