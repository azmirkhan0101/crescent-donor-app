import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/url_parser/image_url_parser.dart';
import 'package:cresent_charge_user_app/features/organization/models/organization_details_model.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';

class OrganizationHeaderWidget extends StatelessWidget {
  final OrganizationDetailsModel organization;

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
                  color: const Color(0xFFF5F5F5), // Fallback background
                  image: organization.coverImage?.isNotEmpty ?? false
                      ? DecorationImage(
                          image: NetworkImage(
                            parseImageUrl(organization.coverImage!),
                          ),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {
                            // Silent error handling - background color will show
                          },
                        )
                      : null,
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
                    color: const Color(0xFFE5E5E5), // Fallback background
                    image: organization.logoImage?.isNotEmpty ?? false
                        ? DecorationImage(
                            image: NetworkImage(
                              parseImageUrl(organization.logoImage!),
                            ),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) {
                              // Silent error handling - background color will show
                            },
                          )
                        : null,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFEAE9EB),
                      ),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  child: organization.logoImage?.isEmpty ?? true
                      ? Icon(Icons.business, size: 40.rw, color: Colors.grey)
                      : null,
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
                    Assets.common.verified.svg(), // All organizations verified
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
                        '${organization.address}, ${organization.state}',
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
                  organization.aboutUs,
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
}
