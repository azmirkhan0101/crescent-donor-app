import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/have_account_widget.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/get_profile_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_point_balance_controller.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class GetStartPage extends StatefulWidget {
  const GetStartPage({super.key});

  @override
  State<GetStartPage> createState() => _GetStartPageState();
}

class _GetStartPageState extends State<GetStartPage> {
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
    }
  }

  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            24.rh.heightWidth,

            // app logo
            Assets.onboarding.appLogoName.svg(width: 150.rw, height: 40.rh),
            38.rh.heightWidth,

            // saving coins illustration image
            Assets.onboarding.onboardingSavingCoins.svg(
              width: 177.rw,
              height: 304.rh,
            ),
            38.rh.heightWidth,

            // Turn your small change into real change
            Text(
              AppStrings.turnYourSmallChangeIntoRealChange,
              style: AppTextStyles.f28W700().copyWith(fontSize: 26.rw),
              textAlign: TextAlign.center,
            ),
            12.rh.heightWidth,

            // Discover rewards and cash back offers
            AppStrings.discoverRewards.centerText(AppTextStyles.baseStyle()),
            Spacer(),

            // Get Started button
            CustomFilledButton(
              title: "Get Started",
              onTap: () {
                context.pushNamed(RoutePath.howToWorkPage);
              },
            ),
            15.rh.heightWidth,

            // Already have an account? Sign In
            HaveAccountWidget(haveAccount: true),
            24.rh.heightWidth,
          ],
        ).paddingXY(X: 40.rw),
      ),
    );
  }
}
