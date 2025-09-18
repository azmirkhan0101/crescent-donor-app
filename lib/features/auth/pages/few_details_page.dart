import 'package:cresent_charge_user_app/common-widgets/fill-button/custom_filled_button.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/few_details_form_fields.dart';

import 'package:cresent_charge_user_app/features/auth/widgets/auth_header.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/auth_title_section.dart';
import 'package:cresent_charge_user_app/features/auth/widgets/have_account_widget.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';

class FewDetailsPage extends StatelessWidget {
  const FewDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return [
      16.heightWidth,
      AuthHeader(),
      32.heightWidth,
      AuthTitleSection(
        title: AppStrings.fewDetails,
        subtitle: AppStrings.helpUsGetToKnowYouBetter,
      ),

      32.rh.heightWidth,

      FewDetailFormFields(),

      const Spacer(),
      // 100.rh.heightWidth,
      Column(
        children: [
          CustomPrimaryButton(
            title: AppStrings.continueText,
            onTap: () {
              context.pushNamed(RoutePath.uploadProfilePicture);
            },
          ),
          16.heightWidth,
          HaveAccountWidget(haveAccount: true),

          24.heightWidth,
        ],
      ).paddingXY(horizontal: 40.rw),
    ].scaffoldSafeAreaColumn(horizontalPadding: 16.rw);
  }
}
