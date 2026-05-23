import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/extension/context_extension.dart';

/// Special message field widget
class SpecialMessageField extends StatelessWidget {
  const SpecialMessageField({super.key, this.label, this.controller});

  final String? label;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label ?? 'Add a Special Message',
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: isTab ? 8.sp : 16.rfs,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000C0B),
            ),
            children: [
              TextSpan(
                text: '(Optional)',
                style: TextStyle(
                  color: const Color(0xFFE4E4E4),
                  fontSize: isTab ? 7.sp : 12.rfs,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.rh),

        TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter your special message here...',
            hintStyle: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: isTab ? 6.sp : 14.rfs,
              color: const Color(0xFF9E9E9E),
            ),
          ),
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: isTab ? 6.sp : 14.rfs,
            color: const Color(0xFF000C0B),
          ),
        ),
      ],
    );
  }
}

/// Amount selection chip widget
class AmountSelectionChip extends StatelessWidget {
  final String amount;
  final bool isSelected;
  final VoidCallback onTap;

  const AmountSelectionChip({
    super.key,
    required this.amount,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 12.rh),
        decoration: BoxDecoration(
          color: isSelected ? DonationConstants.secondaryLime : Colors.white,
          borderRadius: BorderRadius.circular(25.rw),
          border: Border.all(
            color: isSelected
                ? DonationConstants.secondaryLime
                : const Color(0xFFE4E4E4),
            width: 1.5,
          ),
        ),
        child: Text(
          amount,
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: 14.rfs,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? DonationConstants.offBlack
                : const Color(0xFF666666),
          ),
        ),
      ),
    );
  }
}

/// Custom text field widget for forms
class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final int maxLines;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.onChanged,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: 14.rfs,
            fontWeight: FontWeight.w500,
            color: DonationConstants.offBlack,
          ),
        ),

        SizedBox(height: 8.rh),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.rw),
            border: Border.all(color: const Color(0xFFE4E4E4), width: 1),
          ),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            maxLines: maxLines,
            enabled: enabled,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontFamily: DonationFonts.interDisplay,
                fontSize: 14.rfs,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFB0B0B0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.rw),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.rw,
                vertical: 16.rh,
              ),
            ),
            style: TextStyle(
              fontFamily: DonationFonts.interDisplay,
              fontSize: 14.rfs,
              fontWeight: FontWeight.w500,
              color: DonationConstants.offBlack,
            ),
          ),
        ),
      ],
    );
  }
}
