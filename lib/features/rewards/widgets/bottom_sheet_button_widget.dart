import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

class BottomSheetButtonWidget extends StatelessWidget {
  const BottomSheetButtonWidget({
    super.key, 
    this.backgroundColor, 
    this.text,
    this.onTap,
  });

  final Color? backgroundColor;
  final String? text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.rh,
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12.rw),
        ),
        child: Center(
          child: Text(
            text ?? 'Save',
            style: TextStyle(
              color: Color(0xFF000C0B),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
