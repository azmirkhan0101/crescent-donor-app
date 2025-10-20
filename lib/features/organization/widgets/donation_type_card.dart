import 'package:cresent_charge_user_app/features/organization/controllers/organization_details_controller.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/donation_bottom_sheet.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DonationTypeCard extends StatelessWidget {
  const DonationTypeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.type,
    required this.isSelected,
    this.isHighlighted = false,
  });

  final String icon;
  final String title;
  final DonationType type;
  final bool isSelected;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrganizationDetailsController>();
    return GestureDetector(
      onTap: () => controller.changeDonationType(type),
      child: Stack(
        children: [
          AnimatedContainer(
            height: 110.rh,
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(16.rh),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFAF6FF) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFFC08FFF)
                    : const Color(0xFFE4E4E4),
                width: 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color:
                            (isHighlighted
                                    ? const Color(0xFFC08FFF)
                                    : const Color(0xFFE4E4E4))
                                .withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              children: [
                // Icon container
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(10.rw),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFF1E7FF)
                        : const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: SvgPicture.asset(
                    icon,
                    width: 20.rw,
                    height: 20.rh,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(height: 16.rh),

                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 14.rfs,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF000C0B),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Radio button
          Positioned(
            top: 8.rh,
            right: 8.rw,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 12.rh,
              height: 12.rh,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFC08FFF)
                      : const Color(0xFFEBE9EC),
                  width: 1,
                ),
              ),
              child: isSelected
                  ? AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.all(2.rw),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? const Color(0xFFC08FFF)
                            : const Color(0xFFEBE9EC),
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
