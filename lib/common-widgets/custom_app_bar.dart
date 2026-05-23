import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../core/helper/extension/context_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.actions,
    this.onBackButtonPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String title;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final void Function()? onBackButtonPressed;

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Text(
        title,
        style: TextStyle(
          color: const Color(0xFF000C0B),
          fontSize: isTab ? 9.sp :  20.rfs,
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: onBackButtonPressed ?? () => GoRouter.of(context).pop(),
        icon: SvgPicture.asset(
          Assets.common.arrowLeft.path,
          width:isTab ? 40 :   24.rw,
          height: isTab ? 40 :  24.rh,
          colorFilter: const ColorFilter.mode(
            Color(0xFF000C0B),
            BlendMode.srcIn,
          ),
        ),
      ),
      actions: actions,
    );
  }
}
