import 'dart:convert';

import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/network_image/network_image.dart';
import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/home/controllers/cause_categories_controller.dart';
import 'package:cresent_charge_user_app/features/home/controllers/causes_controller.dart';
import 'package:cresent_charge_user_app/features/home/widgets/donation_cause_card.dart';
import 'package:cresent_charge_user_app/features/home/widgets/verified_charity_card.dart';
import 'package:cresent_charge_user_app/features/main-layout/controllers/main_layout_controller.dart';
import 'package:cresent_charge_user_app/features/notification/controllers/fcm_token_controller.dart';
import 'package:cresent_charge_user_app/features/notification/controllers/unseen_notification_count_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/organization_controller.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/get_profile_controller.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {

  final causesController = Get.put(CausesController());

  @override
  Widget build(BuildContext context) {
    final getProfileController = Get.find<GetProfileController>();
    final getOrgsController = Get.put(OrganizationController());

    // Initialize FCM token controller
    Get.put(FcmTokenController());

    Get.put(UnseenNotificationCountController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: RefreshIndicator(
        onRefresh: () async {
          await getProfileController.fetchProfile();
          await causesController.fetchAllCauses(category: "");
          await getOrgsController.fetchAllOrganizations();
        },
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                8.rh.heightWidth, // Top spacing
                _buildHeader(context, getProfileController).paddingR(16.rw),
                20.rh.heightWidth,
                _buildImpactSection().paddingR(16.rw),
                20.rh.heightWidth,
                _buildCauseCategories(),
                20.rh.heightWidth,
                // _buildCauseCategories2(),
                // 20.rh.heightWidth,
                _buildVerifiedCharities(context),
                20.rh.heightWidth,
                _buildDonateForCause(context, causesController).paddingR(16.rw),
                100.rh.heightWidth, // Bottom spacing for navigation
              ],
            ).paddingL(16.rw);
          }),
        ),
      ),
    );
  }

  GetX<CauseCategoriesController> _buildCauseCategories2() {
    return GetX<CauseCategoriesController>(
      init: CauseCategoriesController(),
      initState: (state) {
        state.controller!.fetchCategories();
      },
      builder: (controller) {
        return SizedBox(
          height: 48.rh,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              return Container(
                padding: EdgeInsets.all(12.rw),
                decoration: BoxDecoration(
                  color: controller.colors[index % controller.colors.length],
                  // Cycle colors
                  borderRadius: BorderRadius.circular(20.rw),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      category.label,
                      style: AppTextStyles.f14W400().copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => 8.rw.heightWidth,
            itemCount: controller.categories.length,
          ),
        );
      },
    );
  }

  /// Build the header with welcome message, profile, and notification
  Widget _buildHeader(
    BuildContext context,
    GetProfileController getProfileController,
  ) {
    final profile = getProfileController.profile;
    return SizedBox(
      // height: 44.rh,
      child: Row(
        children: [
          // Profile image
          GestureDetector(
            onTap: () => _goToProfilePage(context),
            child: Center(
              child: CustomNetworkImage(
                imageUrl: profile.value?.image ?? '',
                height: 44.rw,
                width: 44.rw,
                borderRadius: BorderRadius.circular(22.rw),
              ),
            ),
          ),

          16.rw.heightWidth,

          // Welcome text
          Expanded(
            child: GestureDetector(
              onTap: () => _goToProfilePage(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome back!", style: AppTextStyles.f14W400()),
                  Text(
                    profile.value?.name ?? 'N/A',
                    style: AppTextStyles.f20w600(),
                  ),
                ],
              ),
            ),
          ),
          // Search and notification icons
          Row(
            children: [
              Container(
                width: 44.rw,
                height: 44.rw,
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

              // Notification icon with conditional red dot
              GetBuilder<UnseenNotificationCountController>(
                builder: (unseenCtrl) {
                  return Container(
                    width: 40.rw,
                    height: 40.rw,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.rw),
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          Assets.home.notification.svg(
                            width: 20.rw,
                            height: 20.rw,
                          ),
                          if (unseenCtrl.hasUnseenNotifications)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Assets.home.redDot.svg(
                                width: 8.rw,
                                height: 8.rw,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ).onTap(() async {
                    if (await AppStorageService.getIsGuestUser()) {
                      ToastMsg.info(
                        'Guest users cannot access this section. Please log in.',
                      );
                      return;
                    }

                    context.pushNamed(RoutePath.notifications);
                  });
                },
              ),
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
      {"icon": "🍽️", "label": "Food", "color": const Color(0xFFFFE8CB)},
      {"icon": "🧑‍🤝‍🧑", "label": "Youth", "color": const Color(0xFFC6FEFC)},
      {"icon": "🧸", "label": "Orphans", "color": const Color(0xFFF0D9FF)},
      {
        "icon": "📖",
        "label": "Quran Education",
        "color": const Color(0xFFD0E6A5),
      },
      {
        "icon": "🏥",
        "label": "Health/Medical",
        "color": const Color(0xFFFFDAEC),
      },
      {
        "icon": "🚨",
        "label": "Emergency Relief",
        "color": const Color(0xFFFFD8D8),
      },
      {
        "icon": "🏠",
        "label": "Shelter/Housing",
        "color": const Color(0xFFFFE9CC),
      },
      {
        "icon": "🕌",
        "label": "Mosque Utilities",
        "color": const Color(0xFFA5DEE5),
      },
      {"icon": "💰", "label": "Zakat", "color": const Color(0xFFB9FBC0)},
      {"icon": "🤲", "label": "Sadaqah", "color": const Color(0xFFF6E2FF)},
      {"icon": "🌙", "label": "Ramadan", "color": const Color(0xFFC3B1E1)},
      {"icon": "🐑", "label": "Qurban", "color": const Color(0xFFF6EAC2)},
      {"icon": "🥖", "label": "Fitrah", "color": const Color(0xFFFFF5BA)},
      {
        "icon": "🗂️",
        "label": "Admin/Operational",
        "color": const Color(0xFFD9D9D9),
      },
      {"icon": "🧳", "label": "Refugees", "color": const Color(0xFFC1E2EE)},
      {
        "icon": "💻",
        "label": "Digital Dawah",
        "color": const Color(0xFFB5EAD7),
      },
      {
        "icon": "👩",
        "label": "Women & Families",
        "color": const Color(0xFFF7C5CC),
      },
      // {
      //   "icon": "🧠",
      //   "label": "Mental Health",
      //   "color": const Color(0xFFFBDAFB),
      // },
    ];

    List<String> categoryFilters = [
      'water',
      'education',
      'food',
      'youth',
      'orphans',
      'quran_education',
      'health_medical',
      'emergency_relief',
      'shelter_housing',
      'mosque_utilities',
      'zakat',
      'sadaqah',
      'ramadan',
      'qurban',
      'fitrah',
      'admin_operational',
      'refugees',
      'digital_dawah',
      'women_families',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8.rw,
        children: categories.indexed.map((entry) {
          int index = entry.$1;
          Map category = entry.$2;
          return GestureDetector(
            onTap: (){
              causesController.fetchAllCauses(category: categoryFilters[index]);
            },
            child: Container(
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
            ),
          );
        }).toList(),
      ),
    );
  }

  /// Build the verified charities section
  Widget _buildVerifiedCharities(BuildContext context) {
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

        SizedBox(
          height: 226.rh,
          child: GetBuilder<OrganizationController>(
            builder: (orgController) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final org = orgController.organizationsList[index];
                  return VerifiedCharityCard(
                    id: org.id,
                    title: org.name,
                    location: org.address ?? '',
                    category: org.serviceType,
                    backgroundColor: Colors.green,
                    imagePath: org.logoImage,
                  );
                },
                separatorBuilder: (context, index) => 8.rw.heightWidth,
                itemCount: orgController.organizationsList.length,
              );
            },
          ),
        ),
      ],
    );
  }

  /// Build the donate for cause section
  Widget _buildDonateForCause(
    BuildContext context,
    CausesController getAllCausesController,
  ) {

    final List<Color> pastelColors = [
      Color(0xFFE3D7FF), // Light Violet
      Color(0xFFC7ECFF), // Soft Lavender
      Color(0xFFFFD6E7), // Pastel Pink
      Color(0xFFFFE3D6), // Blush Peach
      Color(0xFFD6F5E8), // Light Mint Green
      Color(0xFFE4F3D9), // Soft Sage
      Color(0xFFD9F2FF), // Pale Sky Blue
      Color(0xFFD6F0F5), // Powder Teal
      Color(0xFFFFF4CC), // Light Butter Yellow
      Color(0xFFFFD9CC), // Soft Coral
    ];

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
          children: getAllCausesController.causes
          .asMap()
          .entries
              .map(
                (entry){
                  final index = entry.key;
                  final cause = entry.value;
                  return GestureDetector(
                    onTap: (){
                      context.pushNamed(
                        RoutePath.organizationDetails,
                        extra: {"organizationId": cause.organization.id},
                      );
                    },
                    child: DonationCauseCard(
                      backgroundColor: pastelColors[index % pastelColors.length],
                      causeBanner: cause.organization.coverImage,
                      orgLogo: cause.organization.logoImage,
                      description: cause.description,
                      category: cause.category,
                      amount: cause.totalDonationAmount,
                      totalDonors: cause.totalDonors,
                      recentDonors: cause.recentDonors,
                    ),
                  );
                },
              )
              .toList(),
        ),
      ],
    );
  }

  void _goToProfilePage(BuildContext context) {
    // Get the route for this tab index
    String routePath = Get.find<MainLayoutController>().getRouteForIndex(3);
    // Navigate to the route
    context.goNamed(routePath);
  }
}
