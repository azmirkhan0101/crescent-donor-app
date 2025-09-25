import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/features/home/controllers/charities_controller.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Home Page
///
/// The main dashboard of the app displaying welcome message, impact tracking,
/// cause categories, verified charities, and donation opportunities.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final charitiesController = Get.find<CharitiesController>();
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.rh.heightWidth, // Top spacing
            _buildHeader(context).paddingR(16.rw),
            20.rh.heightWidth,
            _buildImpactSection().paddingR(16.rw),
            20.rh.heightWidth,
            _buildCauseCategories(),
            20.rh.heightWidth,
            _buildVerifiedCharities(context, charitiesController),
            20.rh.heightWidth,
            _buildDonateForCause(context, charitiesController).paddingR(16.rw),
            100.rh.heightWidth, // Bottom spacing for navigation
          ],
        ).paddingL(16.rw),
      ),
    );
  }

  /// Build the header with welcome message, profile, and notification
  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      // height: 44.rh,
      child: Row(
        children: [
          // Profile image
          Container(
            width: 46.rw,
            height: 46.rh,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Center(
              child: Assets.home.profileImage.svg(fit: BoxFit.cover),
            ),
          ),

          16.rw.heightWidth,

          // Welcome text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome back!", style: AppTextStyles.f14W400()),
                Text("Talha S.", style: AppTextStyles.f20w600()),
              ],
            ),
          ),
          // Search and notification icons
          Row(
            children: [
              Container(
                width: 44.rw,
                height: 44.rh,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.rw),
                ),
                child: Center(
                  child: Assets.common.search.svg(width: 20.rw, height: 20.rh),
                ),
              ).onTap(() {
                context.pushNamed(RoutePath.search);
              }),
              12.rw.heightWidth,

              // Notification icon with red dot
              Container(
                width: 40.rw,
                height: 40.rh,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.rw),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      Assets.home.notification.svg(width: 20.rw, height: 20.rh),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Assets.home.redDot.svg(
                          width: 8.rw,
                          height: 8.rh,
                        ),
                      ),
                    ],
                  ),
                ),
              ).onTap(() {
                context.pushNamed(RoutePath.notifications);
              }),
            ],
          ),
        ],
      ),
    );
  }

  /// Build the impact tracking section
  Widget _buildImpactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("You're making real change!", style: AppTextStyles.f20w600()),
        2.rh.heightWidth,
        Text(
          "Track your impact, explore causes, and donate on your terms.",
          style: AppTextStyles.f14W400(),
        ),
      ],
    );
  }

  /// Build the cause categories chips
  Widget _buildCauseCategories() {
    final categories = [
      {"icon": "💧", "label": "Water", "color": const Color(0xFFCCEEFF)},
      {"icon": "📚", "label": "Education", "color": const Color(0xFFDAFFDB)},
      {"icon": "🍯", "label": "Food", "color": const Color(0xFFFFE8CB)},
      {"icon": "👫", "label": "Youth", "color": const Color(0xFFC6FEFC)},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8.rw,
        children: categories.map((category) {
          return Container(
            padding: EdgeInsets.all(12.rw),
            decoration: BoxDecoration(
              color: category["color"] as Color,
              borderRadius: BorderRadius.circular(24.rw),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  category["icon"] as String,
                  style: AppTextStyles.f14W400(),
                ),
                4.rw.heightWidth,
                Text(
                  category["label"] as String,
                  style: AppTextStyles.f14W400().copyWith(color: Colors.black),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Build the verified charities section
  Widget _buildVerifiedCharities(
    BuildContext context,
    CharitiesController charitiesController,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Verified Charities", style: AppTextStyles.f20w600()),
            Text(
              "View all",
              style: AppTextStyles.f14W400().copyWith(
                color: const Color(0xFF8B5CF6),
                fontSize: 14.rfs,
                fontWeight: FontWeight.w500,
              ),
            ).onTap(() {
              context.pushNamed(RoutePath.verifiedCharities);
            }),
          ],
        ).paddingR(16.rw),
        12.rh.heightWidth,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: charitiesController.verifiedCharities),
        ),
      ],
    );
  }

  /// Build the donate for cause section
  Widget _buildDonateForCause(
    BuildContext context,
    CharitiesController charitiesController,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Donate for Cause",
              style: AppTextStyles.baseStyle().copyWith(
                fontSize: 20.rfs,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              "View all",
              style: AppTextStyles.f14W400().copyWith(
                color: const Color(0xFF8B5CF6),
                fontSize: 14.rfs,
                fontWeight: FontWeight.w500,
              ),
            ).onTap(() {
              context.pushNamed(RoutePath.charities);
            }),
          ],
        ),
        16.rh.heightWidth,
        Column(
          children: [
            charitiesController.charities[0],
            16.rh.heightWidth,
            charitiesController.charities[1],
          ],
        ),
      ],
    );
  }
}
