import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.backgroundColor});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Text(
        title,
        style: TextStyle(
          color: const Color(0xFF000C0B),
          fontSize: 20.rfs,
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: SvgPicture.asset(
          Assets.common.arrowLeft.path,
          width: 24.rw,
          height: 24.rh,
          colorFilter: const ColorFilter.mode(
            Color(0xFF000C0B),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
