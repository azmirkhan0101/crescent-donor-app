import 'package:cresent_charge_user_app/features/donation/controllers/get_badges_progress_controller.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/badge_card.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BadgesPage extends StatelessWidget {
  const BadgesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final controllerTemp = Get.put(BadgesController());
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.rw),
        child: GetX<GetBadgesProgressController>(
          // initState: (state) {
          //   state.controller!.fetchBadgesProgress();
          // },
          builder: (controller) {
            // if (controller.isLoading.value) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   ).paddingT(32.rh);
            // }
            // print("Total ====>. ${controller.badgesProgressData.length}");
            return RefreshIndicator(
              onRefresh: () => controller.fetchBadgesProgress(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.rh),

                  // Header text
                  Text(
                    'Earn your badges!',
                    style: TextStyle(
                      color: const Color(0xFF515A59),
                      fontSize: 14.rfs,
                      fontFamily: 'Inter',
                    ),
                  ),

                  SizedBox(height: 8.rh),

                  // Badges Grid
                  Expanded(
                    child: Skeletonizer(
                      enabled: controller.isLoading.value,
                      child: controller.badgesProgressData.isEmpty
                          ? Center(
                              child: Text(
                                'No badges available yet.\nKeep donating to unlock badges!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.rfs,
                                  color: const Color(0xFF515A59),
                                  fontFamily: 'Inter',
                                ),
                              ),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.rw,
                                    mainAxisSpacing: 8.rh,
                                    childAspectRatio:
                                        167.5 /
                                        214, // Width / Height from Figma
                                  ),
                              itemCount: controller.badgesProgressData.length,
                              itemBuilder: (context, index) {
                                final badgeData =
                                    controller.badgesProgressData[index];
                                // Find matching badge from local badges list
                                // final badge = controllerTemp.badges
                                //     .firstWhereOrNull(
                                //       (b) => b.name == badgeData.badge?.name,
                                //     );

                                // if (badge == null) {
                                //   return const SizedBox.shrink();
                                // }

                                return BadgeCard(
                                  // badge: badge,
                                  badgeDataModel: badgeData,
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.chevron_left, color: Colors.black, size: 24),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: const Text(
        'Badges',
        style: TextStyle(
          color: Color(0xFF000C0B),
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Familjen Grotesk',
          letterSpacing: -0.2,
        ),
      ),
    );
  }
}
