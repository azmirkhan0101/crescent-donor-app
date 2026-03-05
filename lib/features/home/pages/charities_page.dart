import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/home/controllers/causes_controller.dart';
import 'package:cresent_charge_user_app/features/home/widgets/donation_cause_card.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharitiesPage extends StatelessWidget {
  const CharitiesPage({super.key});

  @override
  Widget build(BuildContext context) {

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Explore Causes"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<CausesController>(
          builder: (controller) {

            if (controller.causes.isEmpty) {
              return const Center(
                child: Text(
                  "No charities found.",
                  style: TextStyle(color: Colors.black54, fontSize: 16, fontStyle: FontStyle.italic),
                ),
              );
            }

            return ListView.separated(
              itemBuilder: (context, index) {
                final cause = controller.causes[index];
                return DonationCauseCard(
                  backgroundColor: pastelColors[index % pastelColors.length],
                  causeBanner: cause.organization.coverImage,
                  orgLogo: cause.organization.logoImage,
                  description: cause.description,
                  category: cause.category,
                  amount: cause.totalDonationAmount,
                  totalDonors: cause.totalDonors,
                  recentDonors: cause.recentDonors,
                );
              },
              separatorBuilder: (context, index) => 16.rh.heightWidth,
              itemCount: controller.causes.length,
            );
          },
        ),
      ),
    );
  }
}
