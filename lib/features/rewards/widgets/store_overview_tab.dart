import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/business_website_count_update_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/models/store_profile_model.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/helper/extension/context_extension.dart';

class StoreOverviewTab extends StatelessWidget {
  const StoreOverviewTab({super.key, required this.storeProfile});

  final StoreProfileModel storeProfile;

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Container(
      padding: EdgeInsets.all(16.rw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact Information Cards
          Row(
            children: [
              // Website Card
              Expanded(
                child: _buildContactCard(
                  isTab: isTab,
                  icon: Assets.common.globe.path,
                  iconBg: const Color(0xFFE5D2FB),
                  backgroundColor: const Color(0xFFEBDFFA),
                  title: 'Website',
                  subtitle: storeProfile.businessWebsite ?? 'No website',
                  onTap: () async {
                    await Get.find<BusinessWebsiteCountUpdateController>()
                        .updateWebsiteVisitCount(storeProfile.id);
                    await _openWebsite(storeProfile.businessWebsite ?? '');
                  },
                ),
              ),

              12.rw.heightWidth,

              // Business Phone Card
              Expanded(
                child: _buildContactCard(
                  isTab: isTab,
                  icon: Assets.common.call.path,
                  iconBg: const Color(0xFFF5FDDE),
                  backgroundColor: const Color(0xFFEAFABA),
                  title: 'Business Phone',
                  subtitle: '(555) 123-4567',
                ),
              ),
            ],
          ),
          12.rh.heightWidth,
          // Email Card (Full Width)
          _buildContactCard(
            isTab: isTab,
            icon: Assets.common.mail.path,
            iconBg: const Color(0xFFFFF8CC),
            backgroundColor: const Color(0xFFF9F3CB),
            title: 'Email',
            subtitle: storeProfile.businessEmail ?? 'No email provided',
          ),
          24.rh.heightWidth,

          // Overview Section
          Text(
            'Overview',
            style: TextStyle(
              color: const Color(0xFF000C0B),
              fontSize: 18.rfs,
              fontFamily: 'Inter Display',
              fontWeight: FontWeight.w600,
            ),
          ),

          12.rh.heightWidth,

          Text(
            'Shop Online Today with ${storeProfile.name} — Browse & discover millions of products. Read customer reviews and find best sellers. Yes, we ship to you. Shop top brands in electronics, clothing, books & more.',
            style: TextStyle(
              color: const Color(0xFF515A59),
              fontSize: isTab ? 12.sp : 14.rfs,
              fontFamily: 'Inter Display',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),

          24.rh.heightWidth,

          // Locations Section
          Text(
            'Locations',
            style: TextStyle(
              color: const Color(0xFF000C0B),
              fontSize: 18.rfs,
              fontFamily: 'Inter Display',
              fontWeight: FontWeight.w600,
            ),
          ),

          16.rh.heightWidth,

          ...storeProfile.locations.map(
            (location) => Column(
              children: [_buildLocationItem(location), 12.rh.heightWidth],
            ),
          ),

          // Location Items
          // _buildLocationItem('Address of Store #1'),
          // 12.rh.heightWidth,
          // _buildLocationItem('Address of Store #2'),
          40.rh.heightWidth,
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required bool isTab,
    required String icon,
    required Color iconBg,
    required Color backgroundColor,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.rh),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.rw),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.rw,
              height: 40.rh,
              padding: EdgeInsets.all(8.rw),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(48.rw),
              ),
              child: SvgPicture.asset(icon),
            ),

            40.rh.heightWidth,

            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF000C0B),
                fontSize: 16.rfs,
                fontFamily: 'Inter Display',
                fontWeight: FontWeight.w600,
              ),
            ),

            4.rh.heightWidth,

            Text(
              subtitle,
              style: TextStyle(
                color: const Color(0xFF515A59),
                fontSize: isTab ? 12.sp : 12.rfs,
                fontFamily: 'Inter Display',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openWebsite(String url) async {
    var finalUrl = url.trim();
    if (finalUrl.isEmpty) {
      ToastMsg.error('No website provided');
      return;
    }
    if (!finalUrl.startsWith('http')) {
      finalUrl = 'https://$finalUrl';
    }
    final uri = Uri.parse(finalUrl);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        ToastMsg.error('Could not open website');
      }
    } catch (e) {
      ToastMsg.error('Failed to launch: $e');
    }
  }

  Widget _buildLocationItem(String address) {
    return Container(
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.rw),
        border: Border.all(color: const Color(0xFFEDEDED), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 40.rw,
            height: 40.rh,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8.rw),
            ),
            child: Icon(
              Icons.location_on_outlined,
              size: 20.rfs,
              color: const Color(0xFF6B7280),
            ),
          ),

          12.rw.heightWidth,

          Expanded(
            child: Text(
              address,
              style: TextStyle(
                color: const Color(0xFF000C0B),
                fontSize: 14.rfs,
                fontFamily: 'Inter Display',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Icon(
            Icons.arrow_forward_ios,
            size: 16.rfs,
            color: const Color(0xFF9CA3AF),
          ),
        ],
      ),
    );
  }
}
