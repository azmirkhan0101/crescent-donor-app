import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/rewards/models/business_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetAllBusinessController extends GetxController {
  var businessList = <BusinessModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchBusinessList() async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      "${ApiUrl.baseUrl}/admin/businesses",
      withAuth: true,
    );

    isLoading.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error fetching business list: ${error.message}');
        ToastMsg.error(errorMessage.value);
      },
      (data) {
        this.businessList.clear();
        final businessList = (data['data'] as List)
            .map((item) => BusinessModel.fromJson(item))
            .toList();
        this.businessList.value = businessList;
        debugPrint(
          'Business fetched successfully: ${businessList.length} items',
        );
      },
    );
  }
}
