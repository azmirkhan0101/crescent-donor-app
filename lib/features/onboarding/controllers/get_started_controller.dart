import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/get_profile_controller.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class GetStartedController extends GetxController {
  // Token management
  RxString authToken = ''.obs;

  @override
  void onInit() async {
    authToken.value = await AppStorageService.getAuthToken() ?? '';
    super.onInit();
  }

  Future<void> navigateToHome(BuildContext context) async {
    // await Future.delayed(const Duration(milliseconds: 1000));
    if (context.mounted) {
      if (authToken.value.isNotEmpty) {
        final getProfileController = Get.put(GetProfileController());
        await getProfileController.fetchProfile();

        // Make sure context is still valid after the async gap
        if (!context.mounted) return;

        if (getProfileController.profile.value?.id.isNotEmpty ?? false) {
          // GoRouter.of(context).goNamed(RoutePath.home);
          context.replaceNamed(RoutePath.home);
        } else {
          context.replaceNamed(RoutePath.fewDetails);
        }
      }
    }
  }
}
