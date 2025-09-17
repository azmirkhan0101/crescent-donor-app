import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/signup_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/custom_input_field.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupFormFields extends StatefulWidget {
  const SignupFormFields({super.key});

  @override
  State<SignupFormFields> createState() => _SignupFormFieldsState();
}

class _SignupFormFieldsState extends State<SignupFormFields> {
  final signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        spacing: 16.rh,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Email".text(AppTextStyles.baseStyle()).color("#000C0B".hexColor),

              8.rh.heightWidth,
              CustomInputField(
                controller: signupController.emailController,
                hintText: "Enter Email Address",
                prefixIcon: Assets.icons.mail.svg(),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),

          // Password field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Password"
                  .text(AppTextStyles.baseStyle())
                  .color("#000C0B".hexColor),

              8.rh.heightWidth,

              CustomInputField(
                controller: signupController.passwordController,
                hintText: "***********",
                prefixIcon: Assets.icons.lock.svg(),
                obscureText: !signupController.isPasswordVisible.value,
                textInputAction: TextInputAction.next,
              ),
            ],
          ),

          // Strength indicator
          Obx(() {
            return Row(
              spacing: 4.rw,
              children: List.generate(4, (index) {
                return Expanded(
                  child: Container(
                    height: 4.rh,
                    decoration: BoxDecoration(
                      color: signupController.passwordStrength.value > index
                          ? AppColors.primaryColor
                          : "#EBE9EC".hexColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                );
              }),
            );
          }),

          // Confirm Password field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Confirm Password"
                  .text(AppTextStyles.baseStyle())
                  .color("#000C0B".hexColor),

              8.rh.heightWidth,

              CustomInputField(
                controller: signupController.confirmPasswordController,
                hintText: "***********",
                prefixIcon: Assets.icons.lock.svg(),
                obscureText: !signupController.isConfirmPasswordVisible.value,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),

          // Password Strength notice
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 4.rw,
            children: [
              Assets.icons.circleIButton.svg(width: 14.rw, height: 14.rh),
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
      ),
    );
  }
}
