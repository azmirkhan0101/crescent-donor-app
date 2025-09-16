import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Assets.icons.arrowLeftCircleButton
            .svg(width: 24.rw, height: 24.rw)
            .onTap(() {
              context.pop();
            }),
        Assets.icons.moonStar.svg(width: 24.rw, height: 24.rw),
      ],
    );
  }
}
