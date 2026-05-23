import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/models/recurring_states_model.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/extension/context_extension.dart';

/// Recurring Summary Card Widget
///
/// Displays the total weekly recurring donation amount
class RecurringSummaryCard extends StatelessWidget {
  final double totalAmount;
  final double weeklyAmount;
  final int organizationCount;

  const RecurringSummaryCard({
    super.key,
    required this.totalAmount,
    required this.weeklyAmount,
    required this.organizationCount,
  });

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 25.rh),
      decoration: BoxDecoration(
        color: DonationConstants.cardWhite,
        borderRadius: BorderRadius.circular(17.15),
        border: Border.all(color: const Color(0xFFEDEDED), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 0.715,
            offset: const Offset(0, 0.715),
          ),
        ],
      ),
      child: Column(
        children: [
          // Calendar icon
          Container(
            padding: EdgeInsets.all(20.rw),
            decoration: BoxDecoration(
              color: const Color(0xFFD1FAE0),
              borderRadius: BorderRadius.circular(99.rw),
            ),
            child: Assets.common.calendar.svg(
              width: 40.rw,
              height: 40.rh,
              colorFilter: const ColorFilter.mode(
                Color(0xFF10B981),
                BlendMode.srcIn,
              ),
            ),
          ),

          SizedBox(height: 16.rh),

          // Amount
          Text(
            '\$${totalAmount.toStringAsFixed(2)}',
            style: TextStyle(
              fontFamily: DonationFonts.interDisplay,
              fontSize: isTab ? 8.sp : 24.rfs,
              fontWeight: FontWeight.w600,
              color: DonationConstants.offBlack,
              height: 28 / 24,
            ),
          ),

          SizedBox(height: 8.rh),

          // Description
          Text(
            '\$${weeklyAmount.toInt()} per week ($organizationCount organizations)',
            style: TextStyle(
              fontFamily: DonationFonts.interDisplay,
              fontSize: isTab ? 8.sp : 14.rfs,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF818F8D),
              height: 18 / 14,
            ),
          ),
        ],
      ),
    );
  }
}

/// Recurring Organization Card Widget
///
/// Displays an organization with recurring donation details
class RecurringOrganizationCard extends StatelessWidget {
  final RecurringDonation donation;
  final VoidCallback onTap;

  const RecurringOrganizationCard({
    super.key,
    required this.donation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.rw),
        decoration: BoxDecoration(
          color: DonationConstants.cardWhite,
          borderRadius: BorderRadius.circular(12.rw),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Organization details
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.rh),
              child: Row(
                children: [
                  // Organization image
                  Container(
                    width: 44.rw,
                    height: 44.rh,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.rw),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22.rw),
                      child: Image.network(
                        donation.organizationDetails.logoImage,
                        width: 44.rw,
                        height: 44.rh,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 44.rw,
                          height: 44.rh,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22.rw),
                          ),
                          child: Icon(
                            Icons.business,
                            color: Colors.grey[600],
                            size: 20.rw,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 9.rw),

                  // Organization info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          donation.organizationDetails.name,
                          style: TextStyle(
                            fontFamily: DonationFonts.interDisplay,
                            fontSize: 12.rfs,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            height: 16 / 12,
                          ),
                        ),
                        SizedBox(height: 8.rh),
                        Text(
                          '\$${donation.amount.toInt()} per ${donation.frequency}',
                          style: TextStyle(
                            fontFamily: DonationFonts.interDisplay,
                            fontSize: 14.rfs,
                            fontWeight: FontWeight.w500,
                            color: DonationConstants.offBlack,
                            height: 18 / 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.rh),

            // Divider
            Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xFFEDEDED),
            ),

            SizedBox(height: 12.rh),

            // Schedule info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  donation.label,
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: 14.rfs,
                    fontWeight: FontWeight.w500,
                    color: DonationConstants.offBlack,
                    height: 18 / 14,
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey, size: 16.rw),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
