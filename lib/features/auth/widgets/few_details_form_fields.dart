import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/profile_controller.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/custom_input_field.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FewDetailFormFields extends StatefulWidget {
  const FewDetailFormFields({super.key});

  @override
  State<FewDetailFormFields> createState() => _FewDetailFormFieldsState();
}

class _FewDetailFormFieldsState extends State<FewDetailFormFields> {
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
    return Form(
      key: controller.fewDetailsFormKey,
      child: Column(
        spacing: 16.rh,
        children: [
          // Full Name field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStrings.fullName
                  .text(AppTextStyles.baseStyle())
                  .color("#000C0B".hexColor),

              8.rh.heightWidth,
              CustomInputField(
                controller: controller.nameController,
                hintText: AppStrings.enterName,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                isPrefixIcon: false,
                validator: controller.validateName,
              ),
            ],
          ),

          // Address field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStrings.address
                  .text(AppTextStyles.baseStyle())
                  .color("#000C0B".hexColor),

              8.rh.heightWidth,

              CustomInputField(
                controller: controller.addressController,
                hintText: AppStrings.enterAddress,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                isPrefixIcon: false,
                minLines: 2,
                validator: controller.validateAddress,
              ),
            ],
          ),

          // State and Postal code fields
          Row(
            children: [
              // State field
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppStrings.state
                        .text(AppTextStyles.baseStyle())
                        .color("#000C0B".hexColor),

                    8.rh.heightWidth,
                    CustomInputField(
                      controller: controller.stateController,
                      hintText: AppStrings.state,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      isPrefixIcon: false,
                      validator: controller.validateState,
                    ),
                  ],
                ),
              ),

              16.rw.heightWidth,

              // Postal Code field
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppStrings.postalCode
                        .text(AppTextStyles.baseStyle())
                        .color("#000C0B".hexColor),

                    8.rh.heightWidth,
                    CustomInputField(
                      controller: controller.postalCodeController,
                      hintText: AppStrings.postalCode,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      isPrefixIcon: false,
                      validator: controller.validatePostalCode,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
