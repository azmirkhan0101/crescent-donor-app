import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/get_content_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: const CustomAppBar(
        title: "Terms & Conditions",
        backgroundColor: Color(0xFFF7F7F7),
      ),
      body: GetX<GetContentController>(
        init: Get.put(GetContentController()),
        initState: (state) {
          state.controller!.fetchContent();
        },
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60.rw,
                    color: const Color(0xFFD1D5D4),
                  ),
                  16.rh.heightWidth,
                  Text(
                    'Failed to load content',
                    style: TextStyle(
                      fontFamily: DonationFonts.interDisplay,
                      fontSize: 16.rfs,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF000C0B),
                    ),
                  ),
                  8.rh.heightWidth,
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: DonationFonts.interDisplay,
                      fontSize: 14.rfs,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF818F8D),
                    ),
                  ),
                ],
              ).paddingX(32.rw),
            );
          }

          if (controller.content.value == null) {
            return Center(
              child: Text(
                'No content available',
                style: TextStyle(
                  fontFamily: DonationFonts.interDisplay,
                  fontSize: 16.rfs,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF818F8D),
                ),
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.rw),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.rw),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.rw),
              ),
              child: Html(
                data: controller.content.value!.terms,
                style: {
                  "body": Style(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: FontSize(14.rfs),
                    color: const Color(0xFF000C0B),
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                  ),
                  "h1": Style(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: FontSize(20.rfs),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF000C0B),
                  ),
                  "h2": Style(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: FontSize(18.rfs),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF000C0B),
                  ),
                  "h3": Style(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: FontSize(16.rfs),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF000C0B),
                  ),
                  "p": Style(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: FontSize(14.rfs),
                    color: const Color(0xFF000C0B),
                    lineHeight: const LineHeight(1.6),
                  ),
                  "strong": Style(fontWeight: FontWeight.w600),
                  "em": Style(fontStyle: FontStyle.italic),
                  "ul": Style(margin: Margins.only(left: 16)),
                  "ol": Style(margin: Margins.only(left: 16)),
                  "li": Style(
                    fontSize: FontSize(14.rfs),
                    color: const Color(0xFF000C0B),
                  ),
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
