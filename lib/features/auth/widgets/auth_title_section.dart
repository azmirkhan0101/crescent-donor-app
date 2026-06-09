import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/extension/context_extension.dart';

class AuthTitleSection extends StatelessWidget {
  const AuthTitleSection({super.key, required this.title, this.subtitle});
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.text(
          AppTextStyles.f28W700().copyWith(
            color: "#171717".hexColor,
            fontSize: isTab ? 16.sp : 32.rfs,
          ),
        ),
        8.heightWidth,
        // Subtitle
        subtitle != null
            ? subtitle!.text(AppTextStyles.baseStyle().copyWith(fontSize:  isTab ? 12.sp : null))
            : SizedBox.shrink(),
      ],
    );
  }
}
