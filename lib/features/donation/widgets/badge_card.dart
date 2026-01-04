import 'package:cresent_charge_user_app/features/donation/models/badges_data_model.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/badge_details_bottom_sheet.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:get/get_navigation/src/root/parse_route.dart';

class BadgeCard extends StatefulWidget {
  const BadgeCard({super.key, required this.badgeDataModel});

  final BadgeDataModel badgeDataModel;

  @override
  State<BadgeCard> createState() => _BadgeCardState();
}

class _BadgeCardState extends State<BadgeCard> {
  TierModel? currentTier;
  TierModel? unlockedTier;

  @override
  void initState() {
    super.initState();
    currentTier = widget.badgeDataModel.tiers?.firstWhere(
      (tier) => tier.tier == widget.badgeDataModel.currentTier,
      orElse: () => TierModel(),
    );
    unlockedTier = widget.badgeDataModel.tiers?.firstWhere(
      (tier) => tier.isUnlocked == true && tier.isPreviewed == false,
      orElse: () => TierModel(),
    );
    // print("unlockedTier=====================> ${unlockedTier?.animationUrl}");
  }

  @override
  Widget build(BuildContext context) {
    // print("${unlockedTier?.animationUrl}  <---> ${unlockedTier?.tier}");
    // print(
    //   "=====================> ${currentTier?.tier} <-> ${widget.badgeDataModel.currentTier}",
    // );
    // Get badge data directly from the model
    // print("=====================> $badgeIcon");
    // bool hasValidIcon =
    //     badgeIcon.isNotEmpty &&
    //     (badgeIcon.startsWith('http://') || badgeIcon.startsWith('https://'));

    return GestureDetector(
      onTap: () {
        // print("unlockedTier=====================> ${unlockedTier?.tier}");
        // return;
        if (unlockedTier?.tier == null) {
          showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            isScrollControlled: true,
            builder: (context) {
              return BadgeDetailsBottomSheet(
                badgeDataModel: widget.badgeDataModel,
              );
            },
          );
          return;
        }
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return _BadgeAnimationSheet(badgeDataModel: widget.badgeDataModel);
          },
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
                      child: Flutter3DViewer(
                        // src: widget.badgeDataModel.icon ?? '',
                        src: currentTier?.icon ?? '',
                        progressBarColor: const Color(0xFFF9F7F9),
                        onLoad: (modelAddress) {
                          // print("Model Address: $modelAddress");
                          // Show circle progress indicator
                          return CircularProgressIndicator();
                        },
                        onProgress: (progressValue) {
                          // print("Progress: $progressValue");
                          return CircularProgressIndicator(
                            value: progressValue,
                          );
                        },
                        onError: (error) {
                          // print("Error: $error");
                          return Icon(Icons.error, color: Colors.red);
                        },
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8.rh),

              /// Badge Info Container
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.rw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Badge name and progress
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.badgeDataModel.name ??
                                  '', // <== Badge Name with fallback
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
                            '${widget.badgeDataModel.rawProgress?.count}/${widget.badgeDataModel.rawProgress?.requiredCount}', // <== Progress Count with safe values
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
                                  (widget.badgeDataModel.progress?.percentage ??
                                      0) /
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
                          widget.badgeDataModel.description ?? 'N/A',
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

/// Animation sheet shown for 3 seconds before badge details
class _BadgeAnimationSheet extends StatefulWidget {
  const _BadgeAnimationSheet({required this.badgeDataModel});

  final BadgeDataModel badgeDataModel;

  @override
  State<_BadgeAnimationSheet> createState() => _BadgeAnimationSheetState();
}

class _BadgeAnimationSheetState extends State<_BadgeAnimationSheet> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pop();
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          isScrollControlled: true,
          builder: (context) {
            return BadgeDetailsBottomSheet(
              badgeDataModel: widget.badgeDataModel,
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      width: double.infinity,
      color: Colors.transparent,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.lighten),
        // child: Image.asset('assets/3d/022_silver.gif', fit: BoxFit.cover),
        child: Image.network(
          widget.badgeDataModel.tiers
                  ?.firstWhereOrNull(
                    (tier) =>
                        tier.isUnlocked == true && tier.isPreviewed == false,
                  )
                  ?.animationUrl ??
              '',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.error, color: Colors.red));
          },
        ),
      ),
    );
  }
}
