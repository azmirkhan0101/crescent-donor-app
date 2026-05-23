import 'package:cresent_charge_user_app/core/helper/extension/context_extension.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'core/go-router/paths/route_path.dart';
import 'features/profile/controllers/get_profile_controller.dart';
import 'features/rewards/controllers/get_point_balance_controller.dart';


class SplashScreen extends StatefulWidget {


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  _callApis() {
    // Get.find<DonationController>().fetchClientStats();
    Get.find<GetProfileController>().fetchProfile();
    Get.find<GetPointBalanceController>().fetchUserPoints();
  }

  Future<void> _checkAuthAndNavigate() async {
    final String authToken = await AppStorageService.getAuthToken() ?? '';
    if (!mounted) return;

    if (authToken.isNotEmpty) {
      final getProfileController = Get.put(GetProfileController());
      await getProfileController.fetchProfile();

      // Make sure context is still valid after the async gap
      if (!mounted) return;

      if (getProfileController.profile.value?.id.isNotEmpty ?? false) {
        _callApis();
        context.replaceNamed(RoutePath.home);
      } else if (getProfileController.errorMessage.value ==
          'User not exists!') {
        return;
      } else {
        context.replaceNamed(RoutePath.fewDetails);
      }
    }else{
      context.replaceNamed(RoutePath.getStartPage);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/onboarding/splash_logo.png",
          height: isTab ? 250 : 212.h,
          width: isTab ? 250 : 212.w,
          fit: BoxFit.cover,
        ),
      )
    );
  }
}
