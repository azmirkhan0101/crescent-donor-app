import 'package:cresent_charge_user_app/features/home/models/cause_category_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller to fetch cause categories from the API.
class CauseCategoriesController extends GetxController {
  final List<Color> colors = [
    Color(0xFFCCEEFF),
    Color(0xFFDAFFDB),
    Color(0xFFFFE8CB),
    Color(0xFFC6FEFC),
    Color(0xFFF0D9FF),
    Color(0xFFD0E6A5),
    Color(0xFFFFDAEC),
    Color(0xFFFFD8D8),
    Color(0xFFFFE9CC),
    Color(0xFFA5DEE5),
    Color(0xFFB9FBC0),
    Color(0xFFF6E2FF),
    Color(0xFFC3B1E1),
    Color(0xFFF6EAC2),
    Color(0xFFFFF5BA),
    Color(0xFFD9D9D9),
    Color(0xFFC1E2EE),
    Color(0xFFB5EAD7),
    Color(0xFFF7C5CC),
    Color(0xFFFBDAFB),
  ];

  var categories = <CauseCategoryModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  /// Fetch categories from API
  Future<void> fetchCategories() async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      ApiUrl.getCauseCategories,
      withAuth: true,
    );

    isLoading.value = false;

    response.fold(
      (error) {
        errorMessage.value = error.message ?? 'Failed to fetch categories';
        debugPrint('❌ Error fetching cause categories: ${error.message}');
      },
      (data) {
        debugPrint('✅ Cause categories API response: $data');
        final res = CauseCategoriesResponse.fromJson(data);
        categories.value = res.data;
        debugPrint('📋 Loaded ${res.data.length} categories');
      },
    );
  }
}
