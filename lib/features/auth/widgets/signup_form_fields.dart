import 'package:cresent_charge_user_app/common-widgets/form-fields/custom_password_field.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/signup_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/custom_input_field.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helper/extension/context_extension.dart';

class SignupFormFields extends StatelessWidget {
  const SignupFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    final c = Get.isRegistered<SignupController>()
        ? Get.find<SignupController>()
        : Get.put(SignupController());
    return Column(
      spacing: 16.rh,
      children: [
        // Email
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Email".text(AppTextStyles.baseStyle().copyWith(fontSize: isTab ? 8.sp : null)).color("#000C0B".hexColor),
            8.rh.heightWidth,
            CustomInputField(
              controller: c.emailController,
              hintText: "Enter Email Address",
              prefixIcon: Assets.onboarding.mail.svg(),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              onChanged: c.updateEmail,
            ),
            Obx(
              () => c.emailError.value.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: 4.rh),
                      child: Text(
                        c.emailError.value,
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        // Password
        CustomPasswordField(
          controller: c.passwordController,
          validator: (_) => null,
          onChanged: c.updatePassword,
        ),
        Obx(
          () => c.passwordError.value.isNotEmpty
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.rh),
                    child: Text(
                      c.passwordError.value,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        // Strength bar
        Obx(
          () => Row(
            spacing: 4.rw,
            children: List.generate(4, (index) {
              return Expanded(
                child: Container(
                  height: 4.rh,
                  decoration: BoxDecoration(
                    color: c.passwordStrength.value > index
                        ? AppColors.primaryColor
                        : "#EBE9EC".hexColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              );
            }),
          ),
        ),
        // Confirm Password
        CustomPasswordField(
          controller: c.confirmPasswordController,
          label: "Confirm Password",
          validator: (_) => null,
          onChanged: c.updateConfirmPassword,
        ),
        Obx(
          () => c.confirmPasswordError.value.isNotEmpty
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.rh),
                    child: Text(
                      c.confirmPasswordError.value,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        // Password strength notice
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 4.rw,
          children: [
            Assets.onboarding.circleIButton.svg(width: 14.rw, height: 14.rh),
            Expanded(
              child: Text(
                AppStrings.strongPasswordRequirements,
                style: AppTextStyles.baseStyle().copyWith(
                  fontSize: 12.sp,
                  color: "#808080".hexColor,
                  fontFamily: 'Inter Display',
                  fontWeight: FontWeight.w400,
                  height: 16 / 12,
                ),
              ),
            ),
          ],
        ).paddingOnly(top: 8.rh),
      ],
    );
  }
}
