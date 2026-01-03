import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, this.onTap, this.isBackButton = true});
  final bool isBackButton;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isBackButton
            ? Assets.onboarding.arrowLeftCircleButton
                  .svg(width: 28.rw, height: 28.rw)
                  .onTap(
                    onTap ??
                        () {
                          context.pop();
                        },
                  )
            : const SizedBox(),
        Assets.onboarding.moonStar.svg(width: 24.rw, height: 24.rw),
      ],
    );
  }
}
