import 'package:cresent_charge_user_app/features/organization/models/organization_details_model.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

class CauseItemWidget extends StatelessWidget {
  final Cause cause;

  const CauseItemWidget({super.key, required this.cause});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.rw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Text(cause.emoji, style: TextStyle(fontSize: 14.rfs)),
              SizedBox(width: 8.rw),
              Text(
                cause.name,
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 14.rfs,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF000C0B),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.rh),
          Padding(
            padding: EdgeInsets.only(left: 22.rw),
            child: Text(
              cause.description,
              style: TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 12.rfs,
                color: const Color(0xFF000C0B),
                height: 1.33,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
