import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HaveAccountWidget extends StatelessWidget {
  const HaveAccountWidget({super.key, this.haveAccount});

  final bool? haveAccount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (haveAccount != false
                ? AppStrings.dontHaveAccount
                : AppStrings.alreadyHaveAnAccount)
            .centerText(AppTextStyles.baseStyle())
            .fontFamily(GoogleFonts.inter().fontFamily),
        4.rw.heightWidth,

        (haveAccount != false ? AppStrings.signUp : AppStrings.login)
            .centerText(AppTextStyles.baseStyle())
            .fontWeight(FontWeight.w700)
            .color(Colors.black)
            .fontFamily(GoogleFonts.inter().fontFamily)
            .onTap(() {
              // Navigate to the respective page
              if (haveAccount != false) {
                // Navigate to Sign Up page
                // context.pushNamed(RoutePath.signUp);
              } else {
                // Navigate to Login page
                context.pushNamed(RoutePath.login);
              }
            }),
      ],
    );
  }
}
