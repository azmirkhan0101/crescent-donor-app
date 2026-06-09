import 'dart:io';

import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/extension/context_extension.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/login_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/have_account_widget.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/get_profile_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_point_balance_controller.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class GetStartPage extends StatefulWidget {
  const GetStartPage({super.key});

  @override
  State<GetStartPage> createState() => _GetStartPageState();
}

class _GetStartPageState extends State<GetStartPage> {

  final LoginController controller = Get.isRegistered<LoginController>()
  ? Get.find<LoginController>() : Get.put(LoginController());

  @override
  Widget build(BuildContext context) {

    bool isTab = context.isTab;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                style: AppTextStyles.f28W700().copyWith(fontSize: context.isTab ? 36 : 26),
                textAlign: TextAlign.center,
              ),
              12.rh.heightWidth,
              // Discover rewards and cash back offers
              AppStrings.discoverRewards.centerText(AppTextStyles.baseStyle().copyWith(fontSize: isTab ? 10.sp : null)),
              //Spacer(),
              const SizedBox(height: 20,),
              // Get Started button
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: CustomFilledButton(
                  title: "Get Started",
                  onTap: () {
                    context.pushNamed(RoutePath.howToWorkPage);
                  },
                ),
              ),
              15.rh.heightWidth,
              //===================GOOGLE APPLE LOGIN========================
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 30,
                children: [
                  GestureDetector(
                    onTap: () {
                      //controller.activateSocialLogin();
                      controller.loginWithGoogle(
                          onLoginSuccess: (){
                            context.replaceNamed(RoutePath.home);
                          },
                          onSocialSignup: (){
                            //context.replaceNamed(RoutePath.fewDetails);
                            //SKIPPED UPDATE PROFILE ON SOCIAL SIGNUP
                            context.replaceNamed(RoutePath.home);
                          }
                      );
                    },
                    child: Container(
                      width: isTab ? 60 : 45,
                      height: isTab ? 60 : 45,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: SvgPicture.asset("assets/icons/google.svg"),
                    ),
                  ),
                  //=================APPLE LOGIN IF IPHONE==================
                  if( Platform.isIOS )
                  GestureDetector(
                    onTap: () {
                      controller.loginWithApple(
                          onLoginSuccess: (){
                            context.replaceNamed(RoutePath.home);
                          },
                          onSocialSignup: (){
                            //context.replaceNamed(RoutePath.fewDetails);
                            //SKIPPED UPDATE PROFILE ON SOCIAL SIGNUP
                            context.replaceNamed(RoutePath.home);
                          }
                      );
                    },
                    child: Container(
                      width: isTab ? 60 : 45,
                      height: isTab ? 60 : 45,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: SvgPicture.asset("assets/icons/apple.svg"),
                    ),
                  ),
                ],
              ),
              15.rh.heightWidth,
              // Already have an account? Sign In
              HaveAccountWidget(haveAccount: true),
              24.rh.heightWidth,
            ],
          ).paddingXY(X: 40.rw),
        ),
      ),
    );
  }
}
