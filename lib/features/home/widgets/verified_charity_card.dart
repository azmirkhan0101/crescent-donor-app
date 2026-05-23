import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/helper/extension/context_extension.dart';

class VerifiedCharityCard extends StatelessWidget {
  const VerifiedCharityCard({
    super.key,
    required this.id,
    required this.title,
    required this.location,
    required this.category,
    required this.backgroundColor,
    required this.imagePath,
    this.onTap,
  });

  final String id;
  final String title;
  final String location;
  final String category;
  final Color backgroundColor;
  final String imagePath;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.rw),
        side: BorderSide(color: "#EDEDED".hexColor, width: 1),
      ),

      child: SizedBox(
        width: 154.rw,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
          child: Column(
            children: [
              Container(
                width: 154.rw,
                height: 120.rh,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100, // Background for empty or loading states
                  borderRadius: BorderRadius.circular(8.rw),
                ),
                child: Stack(
                  children: [
                    // 1. The Image Layer
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.rw),
                        child: imagePath.isNotEmpty
                            ? Image.network(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.image_outlined,
                                size: 40.rh, // Adjusted size to fit better
                                color: Colors.black.withValues(alpha: 0.5),
                              ),
                            );
                          },
                        )
                            : Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: 40.rh, // Adjusted size to fit better
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                    ),

                    // 2. The Verified Badge Layer
                    Align(
                      alignment: Alignment.topRight,
                      child: Assets.common.verified.svg(
                        width: 20.rw,
                        height: 20.rh,
                      ),
                    ).paddingXY(X: 10.rw, Y: 8.rh),
                  ],
                ),
              ),

              8.rh.heightWidth,

              SizedBox(
                width: 154.rw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Text(
                    //   category,
                    //   style: AppTextStyles.f14W400().copyWith(
                    //     color: const Color(0xFF10B981),
                    //     fontSize: 12.rfs,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    // 4.rh.heightWidth,
                    Text(
                      title,
                      style: AppTextStyles.baseStyle().copyWith(
                        fontSize: isTab ? 8.sp : 16.rfs,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.rh.heightWidth,
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      location,
                      style: AppTextStyles.f14W400().copyWith(
                        color: const Color(0xFF64748B),
                        fontSize: isTab ? 8.sp : 12.rfs,
                      ),
                    ),
                  ],
                ),
              ).paddingXY(X: 8.rw),
            ],
          ),
        ),
      ),
    ).onTap(
      onTap ??
          () {
            context.pushNamed(
              RoutePath.organizationDetails,
              extra: {"organizationId": id},
            );
          },
    );
  }
}
