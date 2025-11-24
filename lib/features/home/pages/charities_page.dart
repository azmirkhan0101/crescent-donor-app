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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Explore Causes"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<CausesController>(
          builder: (controller) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final cause = controller.causes[index];
                return DonationCauseCard(
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
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       charitiesController.charities[0],
      //       16.rh.heightWidth,
      //       charitiesController.charities[1],
      //     ],
      //   ).paddingAll(16.rw),
      // ),
    );
  }
}
