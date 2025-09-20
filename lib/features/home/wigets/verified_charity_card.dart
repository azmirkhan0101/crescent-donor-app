import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';

class VerifiedCharityCard extends StatelessWidget {
  const VerifiedCharityCard({
    super.key,
    required this.title,
    required this.location,
    required this.category,
    required this.backgroundColor,
    required this.imagePath,
  });

  final String title;
  final String location;
  final String category;
  final Color backgroundColor;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
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
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8.rw),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Assets.home.premiumCheckmark.svg(
                    width: 20.rw,
                    height: 20.rh,
                  ),
                ).paddingXY(X: 10.rw, Y: 8.rh),
              ),

              8.rh.heightWidth,

              SizedBox(
                width: 154.rw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      category,
                      style: AppTextStyles.f14W400().copyWith(
                        color: const Color(0xFF10B981),
                        fontSize: 12.rfs,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    4.rh.heightWidth,
                    Text(
                      title,
                      style: AppTextStyles.baseStyle().copyWith(
                        fontSize: 16.rfs,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.rh.heightWidth,
                    Text(
                      location,
                      style: AppTextStyles.f14W400().copyWith(
                        color: const Color(0xFF64748B),
                        fontSize: 12.rfs,
                      ),
                    ),
                  ],
                ),
              ).paddingXY(X: 8.rw),
            ],
          ),
        ),
      ),
    ).onTap(() {
      context.pushNamed(RoutePath.organizationDetails);
    });
  }
}
