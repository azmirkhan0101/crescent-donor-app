import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/organization/models/organization_model.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrganizationHeaderWidget extends StatelessWidget {
  final OrganizationModel organization;

  const OrganizationHeaderWidget({super.key, required this.organization});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFEDEDED)),
        borderRadius: BorderRadius.circular(12.rw),
      ),
      child: Column(
        children: [
          // Header Image with Profile Overlay
          Stack(
            children: [
              SizedBox(height: 184.rh, width: double.infinity),
              Container(
                width: double.infinity,
                height: 144.rh,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.rw)),
                  image: DecorationImage(
                    image: AssetImage(organization.bannerUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// Profile image
              Positioned(
                bottom: 0.rh,
                left: 8.rw,
                child: Container(
                  width: 80,
                  height: 80,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage(organization.logoUrl),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFEAE9EB),
                      ),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),
              ),

              /// Category Badges
              // Positioned(
              //   bottom: 4.rh,
              //   right: 8.rw,
              //   child: Row(
              //     children: [
              //       _buildBadge(Assets.home.starBadg.path),
              //       SizedBox(width: 8.rw),
              //       _buildBadge(Assets.home.zakat.path),
              //       SizedBox(width: 8.rw),
              //       _buildBadge(Assets.home.cresentLight.path),
              //       SizedBox(width: 8.rw),
              //       _buildEducationTag(),
              //     ],
              //   ),
              // ),
            ],
          ),

          SizedBox(height: 8.rh),
          // Content Section
          Padding(
            padding: EdgeInsets.all(16.rw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with Verification
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        organization.name,
                        style: AppTextStyles.f18W600(),
                      ),
                    ),
                    if (organization.verified) Assets.common.verified.svg(),
                  ],
                ),

                SizedBox(height: 8.rh),

                // Location
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.rw,
                    vertical: 4.rh,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9F7F9),
                    border: Border.all(color: const Color(0xFFEDEDED)),
                    borderRadius: BorderRadius.circular(24.rw),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('🌍', style: TextStyle(fontSize: 10.rfs)),
                      SizedBox(width: 4.rw),
                      Text(
                        organization.location,
                        style: TextStyle(
                          fontFamily: 'Inter Display',
                          fontSize: 12.rfs,
                          color: const Color(0xFF000C0B),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8.rh),

                // Description
                Text(
                  organization.description,
                  style: TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 12.rfs,
                    color: const Color(0xFF000C0B),
                    height: 1.33,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String iconPath) {
    return SvgPicture.asset(iconPath, width: 12.rw, height: 12.rh);
  }

  Widget _buildEducationTag() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 4.rh),
      decoration: BoxDecoration(
        color: const Color(0xFFDAFFDB),
        border: Border.all(color: const Color(0xFFEDEDED)),
        borderRadius: BorderRadius.circular(24.rw),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('📚', style: TextStyle(fontSize: 10.rfs)),
          SizedBox(width: 4.rw),
          Text(
            'Education',
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 10.rfs,
              color: const Color(0xFF000C0B),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildVerificationBadge() {
  //   return Container(
  //     width: 20.rw,
  //     height: 20.rh,
  //     decoration: BoxDecoration(
  //       color: const Color(0xFFC08FFF),
  //       borderRadius: BorderRadius.circular(10.rw),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withValues(alpha: 0.1),
  //           offset: const Offset(0, 1),
  //           blurRadius: 0,
  //         ),
  //       ],
  //     ),
  //     child: Icon(Icons.check, color: Colors.white, size: 12.rfs),
  //   );
  // }
}
