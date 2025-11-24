import 'package:cresent_charge_user_app/features/organization/widgets/donation_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonateNowController extends GetxController {
  Rx<DonationType> selectedDonationType = DonationType.recurring.obs;
  RxString organizationId = ''.obs;
  RxString selectedCauseId = ''.obs;
  RxInt amount = 0.obs;
  final TextEditingController specialMsgController = TextEditingController();
  

  final donationAmounts = [
    {'amount': 10, 'label': '\$10'},
    {'amount': 25, 'label': '\$25'},
    {'amount': 30, 'label': '\$30'},
    {'amount': 40, 'label': '\$40'},
    {'amount': 50, 'label': '\$50'},
    {'amount': -1, 'label': 'Custom'},
    {'amount': 0, 'label': 'None'},
  ];
}
