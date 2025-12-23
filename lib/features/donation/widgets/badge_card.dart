import 'package:cresent_charge_user_app/features/donation/models/badges_data_model.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/badge_details_bottom_sheet.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

// class Badge {
//   final String id;
//   final String name;
//   final String description;
//   final String iconPath;
//   final int currentProgress;
//   final int totalProgress;
//   final bool isCompleted;
//   final Color backgroundColor;

//   const Badge({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.iconPath,
//     required this.currentProgress,
//     required this.totalProgress,
//     required this.isCompleted,
//     required this.backgroundColor,
//   });
// }

class BadgeCard extends StatelessWidget {
  const BadgeCard({
    super.key,
    // required this.badge,
    required this.badgeDataModel,
  });

  // final Badge badge;
  final BadgeDataModel badgeDataModel;

  @override
  Widget build(BuildContext context) {
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
                      child: Image.network(
                        badgeDataModel.badge?.icon ?? '', // <== Badge Icon URL
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.image_not_supported_rounded,
                          size: 48.rw,
                          color: Colors.white,
                        ),
                      ),
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
                              badgeDataModel.badge?.name ??
                                  '', // <== Badge Name
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
                            '${badgeDataModel.progressCount}/${badgeDataModel.nextTier?.requiredCount ?? badgeDataModel.badge?.tiers?[0].requiredCount ?? 0}', // <== Progress Count
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
                          // border: Border.all(
                          //   color: const Color.fromARGB(255, 50, 31, 106),
                          //   width: 1,
                          // ),
                        ),
                        child: Stack(
                          children: [
                            FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 100 / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEBE9EC),
                                  borderRadius: BorderRadius.circular(24.rw),
                                ),
                              ),
                            ),
                            FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              // widthFactor: badge.isCompleted
                              //     ? 1.0
                              //     : (badgeDataModel.progressPercentage ?? 0) /
                              //           100, // <== Progress Percentage
                              widthFactor:
                                  (badgeDataModel.progressPercentage ?? 0) /
                                  100,
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
                          badgeDataModel.badge?.description ??
                              '', // <== Badge Description
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
