import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/main-layout/controllers/main_layout_controller.dart';
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
      height: 80.rh,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          40.rw,
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              context: context,
              controller: controller,
              icon: Assets.bottomNav.home.svg(
                colorFilter: ColorFilter.mode(
                  controller.isTabSelected(0)
                      ? Colors.white
                      : const Color(0xFF94A3B8),
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
                      ? Colors.white
                      : const Color(0xFF94A3B8),
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
                      ? Colors.white
                      : const Color(0xFF94A3B8),
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
                      ? Colors.white
                      : const Color(0xFF94A3B8),
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
      onTap: () {
        // Get the route for this tab index
        String routePath = controller.getRouteForIndex(index);
        // Navigate to the route
        context.goNamed(routePath);
      },
      child: Container(
        width: 56.rw,
        height: 56.rh,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFBEF264) : Colors.transparent,
          borderRadius: BorderRadius.circular(28.rw), // Fully rounded
        ),
        child: Center(
          child: Container(
            width: 48.rw,
            height: 48.rh,
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SizedBox(width: 24.rw, height: 24.rh, child: icon),
            ),
          ),
        ),
      ),
    );
  }
}
