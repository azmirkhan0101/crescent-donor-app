import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_tile_section.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/custom_input_field.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/have_account_widget.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberPassword = false;
  final bool _isPasswordVisible = false;

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

              // Back button and theme toggle
              AuthHeader(),

              32.heightWidth,

              AuthTileSection(
                title: AppStrings.welcomeBack,
                subtitle: AppStrings.weMissedYourBusinessGrowth,
              ),

              32.rh.heightWidth,

              // Email field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Email"
                      .text(AppTextStyles.baseStyle())
                      .color("#000C0B".hexColor),

                  8.rh.heightWidth,
                  CustomInputField(
                    controller: _emailController,
                    hintText: "Enter Email Address",
                    prefixIcon: Assets.icons.mail.svg(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),

              24.heightWidth,

              // Password field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Password"
                      .text(AppTextStyles.baseStyle())
                      .color("#000C0B".hexColor),

                  8.rh.heightWidth,

                  CustomInputField(
                    controller: _passwordController,
                    hintText: "***********",
                    prefixIcon: Assets.icons.lock.svg(),
                    obscureText: !_isPasswordVisible,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),

              16.heightWidth,

              // Remember password and forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _rememberPassword = !_rememberPassword;
                          });
                        },
                        child: Container(
                          width: 20.rh,
                          height: 20.rh,
                          decoration: BoxDecoration(
                            color: _rememberPassword
                                ? AppColors.primaryColor
                                : Colors.transparent,
                            border: Border.all(
                              color: _rememberPassword
                                  ? AppColors.primaryColor
                                  : AppColors.black.withValues(alpha: 0.3),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(4.rw),
                          ),
                          child: _rememberPassword
                              ? Icon(
                                  Icons.check,
                                  color: AppColors.white,
                                  size: 14.rw,
                                )
                              : null,
                        ),
                      ),
                      8.heightWidth,

                      Text(
                        "Remember Password",
                        style: AppTextStyles.baseStyle().copyWith(
                          color: "#000C0B".hexColor,
                          height: 20.rw / 14.rw,
                          fontFamily: GoogleFonts.inter().fontFamily,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle forgot password
                    },
                    child: Text(
                      "Forgot Password?",
                      style: AppTextStyles.baseStyle().copyWith(
                        color: AppColors.black,
                        decoration: TextDecoration.underline,
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Column(
                children: [
                  CustomPrimaryButton(title: "Login"),
                  16.heightWidth,

                  HaveAccountWidget(),

                  16.rh.heightWidth,

                  "OR"
                      .centerText(AppTextStyles.baseStyle().copyWith())
                      .fontFamily(GoogleFonts.inter().fontFamily),
                  16.rh.heightWidth,

                  // Login as guest button
                  CustomPrimaryButton(
                    title: "Login as a Guest",
                    fillColor: Colors.transparent,
                    onTap: () {
                      // Handle guest login
                    },
                  ),

                  24.heightWidth,
                ],
              ).paddingSymmetric(horizontal: 56.rw),
            ],
          ),
        ),
      ),
    );
  }
}
