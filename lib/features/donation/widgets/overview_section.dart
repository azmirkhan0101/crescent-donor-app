import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/donation_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/donation_cards.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/section_header.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Overview Section Widget
///
/// Contains round-up card and two small cards (Recurring & One Time)
class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<DonationController>(
      initState: (state){
        state.controller?.fetchOrgs();
        //state.controller?.fetchClientStats(roundupId: state.controller!.organisationIds.first);
      },
      builder: (donationController) {
        final clientStats = donationController.clientStats.value;
        return Skeletonizer(
          enabled: donationController.isLoadingClientStats.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(title: 'Overview'),
              SizedBox(height: DonationConstants.sectionSpacing.rh),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: DonationConstants.paddingHorizontal.rw,
                ),
                child: Column(
                  children: [
                    // Round Up Card (full width)
                    Obx((){
                      return RoundUpCard(
                        roundUpAmount:
                        clientStats?.roundUpAmount.toStringAsFixed(0) ?? '0',
                        donationOrganization: clientStats != null
                            ? clientStats.roundUpStatusData.organizationName
                            : 'N/A',
                        daysUntilDonation: clientStats != null
                            ? clientStats.roundUpStatusData.daysRemaining
                            .toString()
                            : '0',
                        onTap: () {
                          context.pushNamed(RoutePath.roundUp);
                        },
                        selectedTitle: donationController.selectedTitle.value,
                        onItemSelected: (String? value) {
                          if( value == null ){
                            return;
                          }
                          donationController.selectedTitle.value = value;
                          String id = donationController.roundUpIds.value[donationController.organisationNames.value.indexOf(value)];
                          donationController.fetchClientStats(roundupId: id);
                        },
                        items: donationController.organisationNames.value,
                      );
                    }),
                    SizedBox(height: DonationConstants.cardSpacing.rh),
                    // Two small cards in a row
                    Row(
                      children: [
                        SmallDonationCard(
                          title: 'Recurring',
                          amount: clientStats != null
                              ? clientStats.recurringAmount.toStringAsFixed(0)
                              : '0',
                          backgroundColor: DonationConstants.recurringCardBg,
                          borderColor: DonationConstants.recurringBorder,
                          amountColor: DonationConstants.recurringAmountColor,
                          icon: Assets.common.calendar.path,
                          onTap: () {
                            context.pushNamed(RoutePath.recurringDonations);
                          },
                        ),
                        SizedBox(width: DonationConstants.cardSpacing.rw),
                        SmallDonationCard(
                          title: 'One Time',
                          amount:
                              clientStats?.oneTimeAmount.toStringAsFixed(0) ??
                              '0',
                          backgroundColor: DonationConstants.oneTimeCardBg,
                          borderColor: DonationConstants.oneTimeBorder,
                          amountColor: DonationConstants.oneTimeAmountColor,
                          icon: Assets.common.gift.path,
                          onTap: () {
                            context.pushNamed(RoutePath.oneTime);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
