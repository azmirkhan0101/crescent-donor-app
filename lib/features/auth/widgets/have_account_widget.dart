import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
class HaveAccountWidget extends StatelessWidget {
  const HaveAccountWidget({super.key, this.haveAccount});

  final bool? haveAccount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppStrings.alreadyHaveAnAccount.centerText(AppTextStyles.baseStyle()),
        4.rw.heightWidth,

        "Sign In"
            .centerText(AppTextStyles.baseStyle())
            .fontWeight(FontWeight.w700)
            .color(Colors.black),
      ],
    );
  }
}
