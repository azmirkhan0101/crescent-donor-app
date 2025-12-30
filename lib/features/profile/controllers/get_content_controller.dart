import 'package:cresent_charge_user_app/features/profile/models/content_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetContentController extends GetxController {
  var content = Rx<ContentModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchContent() async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      "${ApiUrl.baseUrl}/content",
      withAuth: false,
    );

    isLoading.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'An error occurred';
        debugPrint('Error fetching content: ${error.message}');
      },
      (data) {
        content.value = ContentModel.fromJson(data['data']);
        debugPrint('Content fetched successfully');
      },
    );
  }
}
