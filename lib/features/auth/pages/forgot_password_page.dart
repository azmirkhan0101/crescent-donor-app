import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/custom_input_field.dart';

import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_title_section.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/have_account_widget.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthHeader(),
        32.heightWidth,
        AuthTitleSection(
          title: "Forgot Password?",
          subtitle: "Enter your email to reset password",
        ),

        32.rh.heightWidth,

        // Email field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStrings.email
                .text(AppTextStyles.baseStyle())
                .color("#000C0B".hexColor),

            8.rh.heightWidth,
            CustomInputField(
              hintText: AppStrings.enterEmailAddress,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),

        const Spacer(),
        // 100.rh.heightWidth,
        Column(
          children: [
            CustomPrimaryButton(
              title: AppStrings.continueText,
              onTap: () {
                context.pushNamed(RoutePath.verifyOtp);
              },
            ),
            16.heightWidth,
            HaveAccountWidget(),
          ],
        ).paddingXY(horizontal: 40.rw),
      ],
    ).paddingAll(16.rw).scaffoldSafeArea();
  }
}
