import 'package:cresent_charge_user_app/features/home/models/cause_model.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/organization_details_controller.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/donation_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonateNowController extends GetxController {
  final orgDetailsController = Get.find<OrganizationDetailsController>();

  final TextEditingController specialMsgController = TextEditingController();

  Rx<DonationType> selectedDonationType = DonationType.recurring.obs;
  RxString organizationId = ''.obs;
  // RxString selectedCauseId = ''.obs;
  Rx<CauseData?> selectedCause = Rx<CauseData?>(null);
  RxInt selectedAmountIndex = 0.obs;
  RxInt amount = 0.obs;

  final donationAmountsList = [
    {'amount': 10, 'label': '\$10'},
    {'amount': 25, 'label': '\$25'},
    {'amount': 30, 'label': '\$30'},
    {'amount': 40, 'label': '\$40'},
    {'amount': 50, 'label': '\$50'},
    {'amount': -1, 'label': 'Custom'},
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize organizationId if needed
    organizationId.value =
        orgDetailsController.organizationDetails.value?.id ?? '';
  }

  @override
  void onClose() {
    specialMsgController.dispose();
    super.onClose();
  }
}
