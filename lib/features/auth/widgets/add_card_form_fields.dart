import 'package:cresent_charge_user_app/features/auth/widgets/custom_input_field.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';

class AddCardFormFields extends StatelessWidget {
  const AddCardFormFields({super.key});

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

          // Card number field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStrings.cardNumber
                  .text(AppTextStyles.baseStyle())
                  .color("#000C0B".hexColor),

              8.rh.heightWidth,

              CustomInputField(
                hintText: "**** **** **** ****",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                isPrefixIcon: false,
              ),
            ],
          ),

          // Expiry date and CVC fields
          Row(
            children: [
              // Expiry date field
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppStrings.expiryDate
                        .text(AppTextStyles.baseStyle())
                        .color("#000C0B".hexColor),

                    8.rh.heightWidth,
                    CustomInputField(
                      hintText: "MM/YY",
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      isPrefixIcon: false,
                    ),
                  ],
                ),
              ),

              16.rw.heightWidth,

              // CVC field
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppStrings.cvc
                        .text(AppTextStyles.baseStyle())
                        .color("#000C0B".hexColor),

                    8.rh.heightWidth,
                    CustomInputField(
                      hintText: "***",
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
