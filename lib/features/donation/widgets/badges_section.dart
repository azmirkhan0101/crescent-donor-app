import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/features/common/widgets/no_data_found.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_badges_progress_controller.dart';
import 'package:cresent_charge_user_app/features/donation/models/badges_data_model.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/badge_card.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/section_header.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/helper/extension/context_extension.dart';

/// Horizontal scrolling badges with progress indicators
class BadgesSection extends StatelessWidget {
  const BadgesSection({super.key});

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return GetX<GetBadgesProgressController>(
      initState: (state) {
        state.controller!.fetchBadgesProgress();
      },
      builder: (getBadgeController) {
        final RxList<BadgeDataModel> badgeDataList =
            getBadgeController.badgesProgressData;
        return Skeletonizer(
          enabled: getBadgeController.isLoading.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: 'Badges',
                actionText: 'View all',
                onActionTap: () {
                  context.pushNamed(RoutePath.badges);
                },
              ),
              SizedBox(height: DonationConstants.sectionSpacing.rh),

              /// Show empty state
              if (badgeDataList.isEmpty && !getBadgeController.isLoading.value)
                NoDataFound(
                  title: 'No badges yet',
                  description:
                      'Keep donating to unlock amazing badges\nand track your progress!',
                  icon: Icons.emoji_events_outlined,
                ),

              /// Show badges list
              SizedBox(
                height: 230.rh, // Fixed height for horizontal scroll
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: DonationConstants.paddingHorizontal.rw,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: getBadgeController.badgesProgressData.length,
                  separatorBuilder: (context, index) =>
                      SizedBox(width: DonationConstants.cardSpacing.rw),
                  itemBuilder: (context, index) {
                    final badgeData = badgeDataList[index];

                    return SizedBox(
                      width: 180.rw, // Fixed width for each badge card
                      child: BadgeCard(
                        badgeDataModel: badgeData,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
