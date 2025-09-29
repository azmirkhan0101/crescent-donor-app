import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/features/home/controllers/charities_controller.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharitiesPage extends StatelessWidget {
  const CharitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final charitiesController = Get.find<CharitiesController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Explore Causes"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            charitiesController.charities[0],
            16.rh.heightWidth,
            charitiesController.charities[1],
          ],
        ).paddingAll(16.rw),
      ),
    );
  }
}
