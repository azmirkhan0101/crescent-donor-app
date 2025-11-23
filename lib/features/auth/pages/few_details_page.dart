import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/profile_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_title_section.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/few_details_form_fields.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class FewDetailsPage extends StatefulWidget {
  const FewDetailsPage({super.key});

  @override
  State<FewDetailsPage> createState() => _FewDetailsPageState();
}

class _FewDetailsPageState extends State<FewDetailsPage> {
  late final ProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<ProfileController>()
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              16.heightWidth,
              AuthHeader(),
              32.heightWidth,
              AuthTitleSection(
                title: AppStrings.fewDetails,
                subtitle: AppStrings.helpUsGetToKnowYouBetter,
              ),

              32.rh.heightWidth,

              FewDetailFormFields(),

              // const Spacer(),
              150.rh.heightWidth,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomFilledButton(
                    title: AppStrings.continueText,
                    onTap: () {
                      // if (controller.fewDetailsFormKey.currentState!
                      // .validate()) {
                      context.pushNamed(RoutePath.uploadProfilePicture);
                      // }
                    },
                  ),

                  // 16.heightWidth,
                  // HaveAccountWidget(haveAccount: true),
                  // 24.heightWidth,
                ],
              ).paddingXY(X: 40.rw),
            ],
          ).paddingAll(16.rw),
        ),
      ),
    );
  }
}
