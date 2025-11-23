import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/features/home/controllers/get_orgs_controller.dart';
import 'package:cresent_charge_user_app/features/home/widgets/verified_charity_card.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifiedCharitiesPage extends StatelessWidget {
  const VerifiedCharitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final charitiesController = Get.find<CharitiesController>();
    return Scaffold(
      appBar: CustomAppBar(title: 'Verified Charities'),
      body: GetBuilder<GetOrgsController>(
        builder: (controller) {
          return GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(16.0.rw),
            crossAxisSpacing: 8.0.rw,
            mainAxisSpacing: 8.0.rh,
            childAspectRatio: 2 / 3,
            // children: charitiesController.verifiedCharities
            //     .map((charity) => charity)
            //     .toList(),
            children: controller.organizations.map((org) {
              return VerifiedCharityCard(
                id: org.id,
                title: org.name,
                location: org.address ?? '',
                category: org.serviceType,
                backgroundColor: Colors.green,
                imagePath: org.logoImage,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
