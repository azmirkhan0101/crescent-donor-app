import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/signup_form_fields.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_title_section.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/have_account_widget.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.rw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.heightWidth,
              AuthHeader(),
              32.heightWidth,
              AuthTitleSection(
                title: AppStrings.letsGetYouStarted,
                subtitle: AppStrings.itOnlyTakesAFewSeconds,
              ),

              32.rh.heightWidth,

              SignupFormFields(),

              const Spacer(),
              // 100.rh.heightWidth,
              Column(
                children: [
                  CustomPrimaryButton(
                    title: "Sign Up",
                    onTap: () {
                      context.pushNamed(RoutePath.fewDetails);
                    },
                  ),
                  16.heightWidth,
                  HaveAccountWidget(haveAccount: true),

                  24.heightWidth,
                ],
              ).paddingXY(X: 56.rw),
            ],
          ),
        ),
      ),
    );
  }
}
