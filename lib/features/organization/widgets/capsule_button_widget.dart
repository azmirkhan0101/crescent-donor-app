import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/extension/context_extension.dart';

class CapsuleButton extends StatelessWidget {
  const CapsuleButton({
    super.key,
    required this.title,
    required this.isSelected,
    this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 8.rh),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFAF6FF) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFC08FFF)
                : const Color(0xFFE4E4E4),
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: isTab ? 10.sp : 14.rfs,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            color: const Color(0xFF000C0B),
          ),
        ),
      ),
    );
  }
}
