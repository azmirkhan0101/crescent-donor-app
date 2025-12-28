import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/main-layout/controllers/main_layout_controller.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Bottom Navigation Widget
///
/// This widget creates a custom bottom navigation bar that matches the design
/// with proper styling, active/inactive states, and navigation logic.
class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final MainLayoutController controller = Get.put(MainLayoutController());

    // Update selected tab based on current route
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentLocation = GoRouterState.of(context).uri.path;
      controller.updateTabFromRoute(currentLocation);
    });

    return Container(
      height: 60.rh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          24.rw,
        ), // Fully rounded for floating effect
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(
              context: context,
              controller: controller,
              icon: Assets.bottomNav.home.svg(
                colorFilter: ColorFilter.mode(
                  controller.isTabSelected(0)
                      ? const Color(0xFF40520A)
                      : const Color(0xFF8D8F88),
                  BlendMode.srcIn,
                ),
              ),
              index: 0,
            ),
            _buildNavItem(
              context: context,
              controller: controller,
              icon: Assets.bottomNav.starEmphasis.svg(
                colorFilter: ColorFilter.mode(
                  controller.isTabSelected(1)
                      ? const Color(0xFF40520A)
                      : const Color(0xFF8D8F88),
                  BlendMode.srcIn,
                ),
              ),
              index: 1,
            ),
            _buildNavItem(
              context: context,
              controller: controller,
              icon: Assets.bottomNav.donation.svg(
                colorFilter: ColorFilter.mode(
                  controller.isTabSelected(2)
                      ? const Color(0xFF40520A)
                      : const Color(0xFF8D8F88),
                  BlendMode.srcIn,
                ),
              ),
              index: 2,
            ),
            _buildNavItem(
              context: context,
              controller: controller,
              icon: Assets.bottomNav.user.svg(
                colorFilter: ColorFilter.mode(
                  controller.isTabSelected(3)
                      ? const Color(0xFF40520A)
                      : const Color(0xFF8D8F88),
                  BlendMode.srcIn,
                ),
              ),
              index: 3,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required MainLayoutController controller,
    required Widget icon,
    required int index,
  }) {
    bool isSelected = controller.isTabSelected(index);

    return GestureDetector(
      onTap: () async {
        bool isGuest = await AppStorageService.getIsGuestUser();
        if (isGuest && (index == 1 || index == 2)) {
          // If user is a guest and tries to access restricted tabs, do nothing
          ToastMsg.info(
            'Guest users cannot access this section. Please log in.',
          );
          return;
        }
        // Get the route for this tab index
        String routePath = controller.getRouteForIndex(index);
        // Navigate to the route
        context.goNamed(routePath);
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: 64.rw,
          height: 56.rh,
          decoration: BoxDecoration(
            color: isSelected ? "#D1FF43".hexColor : Colors.transparent,
            borderRadius: BorderRadius.circular(24.rw),
          ),
          child: Center(child: Center(child: icon)),
        ),
      ),
    );
  }
}
