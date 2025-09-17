import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_tile_section.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';

class UploadProfilePicturePage extends StatelessWidget {
  const UploadProfilePicturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return [
      AuthHeader(),
      32.heightWidth,
      AuthTileSection(title: AppStrings.uploadProfilePicture),
      Spacer(),
      Assets.images.uploadProfilePicture.svg(),
      16.heightWidth,
      Text(
        AppStrings.tapToAddProfilePicture.tr,
        style: TextStyle(
          fontSize: 14.rfs,
          fontWeight: FontWeight.w400,
          color: AppColors.grayColor,
        ),
      ),
      Spacer(),
      CustomPrimaryButton(
        title: AppStrings.continueText,
        onTap: () {
          context.pushNamed(RoutePath.addCard);
        },
      ).paddingSymmetric(horizontal: 40.rw),
      60.rh.heightWidth,
    ].scaffoldSafeAreaColumn(horizontalPadding: 16.rw);
  }
}
