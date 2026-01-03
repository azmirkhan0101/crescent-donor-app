import 'package:cresent_charge_user_app/features/donation/models/badges_data_model.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/badge_details_bottom_sheet.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class BadgeCard extends StatelessWidget {
  const BadgeCard({
    super.key,
    // required this.badge,
    required this.badgeDataModel,
  });

  // final Badge badge;
  final BadgeDataModel badgeDataModel;

  final String? badgeName = "Current Badge Name";
  final String? glbUrl = "assets/3d/001_silver.glb";
  final String? gifUrl = "assets/3d/002_silver.gif";
  final String? pngUrl = "assets/3d/002_silver.png";

  final String? currentTierName = "silver";
  final String? nextTierName = "gold";
  final double? progressPercent = 50;
  final String? description = "description";

  TierModel? get currentTier => badgeDataModel.tiers?.firstWhere(
    (tier) => tier.name == badgeDataModel.currentTier,
    orElse: () => TierModel(),
  );

  @override
  Widget build(BuildContext context) {
    // Get badge data directly from the model
    String badgeIcon = currentTier?.icon ?? '';
    print("=====================> $badgeIcon");
    bool hasValidIcon =
        badgeIcon.isNotEmpty &&
        (badgeIcon.startsWith('http://') || badgeIcon.startsWith('https://'));

    // Calculate progress safely from rawProgress
    int progressCount = badgeDataModel.rawProgress?.count ?? 0;
    int requiredCount = badgeDataModel.rawProgress?.requiredCount ?? 0;
    int progressPercent = badgeDataModel.progress?.percentage ?? 0;

    // Get display values
    String displayName = badgeDataModel.name ?? 'Badge';
    String description =
        badgeDataModel.description ?? 'No description available';

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) =>
              /// todo: remove badge
              BadgeDetailsBottomSheet(badgeDataModel: badgeDataModel),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.rw),
          border: Border.all(color: const Color(0xFFEDEDED), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(6.rw),
          child: Column(
            children: [
              /// Badge Icon Container
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF9F7F9),
                    borderRadius: BorderRadius.circular(8.rw),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 72.rw,
                      height: 72.rh,

                      /// ===> Badge Icon <===
                      child: hasValidIcon
                          // ? Image.network(
                          //     badgeIcon,
                          //     fit: BoxFit.contain,
                          //     errorBuilder: (context, error, stackTrace) =>
                          //         Icon(
                          //           Icons.star,
                          //           size: 48.rw,
                          //           color: Colors.grey,
                          //         ),
                          //   )
                          ? Flutter3DViewer(
                              // src: 'assets/3d/001_gold.glb',
                              src: glbUrl ?? '',
                              progressBarColor: const Color(0xFFC08FFF),
                            )
                          : Icon(Icons.star, size: 48.rw, color: Colors.grey),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8.rh),

              // Badge Info Container
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.rw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge name and progress
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              displayName, // <== Badge Name with fallback
                              style: TextStyle(
                                color: const Color(0xFF000C0B),
                                fontSize: 14.rfs,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // if (!badge.isCompleted)
                          Text(
                            '$progressCount/$requiredCount', // <== Progress Count with safe values
                            style: TextStyle(
                              color: const Color(0xFF818F8D),
                              fontSize: 12.rfs,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8.rh),

                      // Progress bar
                      Container(
                        height: 6.rh,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBE9EC),
                          borderRadius: BorderRadius.circular(24.rw),
                        ),
                        child: Stack(
                          children: [
                            FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE7E7E7),
                                  borderRadius: BorderRadius.circular(24.rw),
                                ),
                              ),
                            ),
                            FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor:
                                  progressPercent /
                                  100, // Use calculated safe percentage
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF000C0B),
                                  // color: Colors.red,
                                  borderRadius: BorderRadius.circular(24.rw),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 8.rh),

                      // <== Description ==>
                      Expanded(
                        child: Text(
                          description, // <== Badge Description with fallback
                          style: TextStyle(
                            color: const Color(0xFF818F8D),
                            fontSize: 12.rfs,
                            fontFamily: 'Inter',
                            height: 1.33,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
