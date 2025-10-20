import 'package:cresent_charge_user_app/features/auth/widgets/custom_input_field.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';

class FewDetailFormFields extends StatelessWidget {
  const FewDetailFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
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
                hintText: AppStrings.enterName,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                isPrefixIcon: false,
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
                hintText: AppStrings.enterAddress,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                isPrefixIcon: false,
                minLines: 2,
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
                      hintText: AppStrings.state,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      isPrefixIcon: false,
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
                      hintText: AppStrings.postalCode,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      isPrefixIcon: false,
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
