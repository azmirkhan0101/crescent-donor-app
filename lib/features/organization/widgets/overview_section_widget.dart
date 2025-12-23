import 'package:cresent_charge_user_app/features/organization/models/organization_details_model.dart';
import 'package:cresent_charge_user_app/features/organization/models/organization_model.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/cause_item_widget.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

class OverviewSectionWidget extends StatelessWidget {
  final String mission;
  final List<Cause> causes;

  const OverviewSectionWidget({
    super.key,
    required this.mission,
    required this.causes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.rw),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.rw),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 12.rh),
          Text(
            mission,
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 14.rfs,
              color: const Color(0xFF000C0B),
              height: 1.43,
            ),
          ),
          SizedBox(height: 12.rh),
          Text(
            'Causes We Support',
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 16.rfs,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF000C0B),
            ),
          ),
          SizedBox(height: 12.rh),
          ...causes.map(
            (cause) => Padding(
              padding: EdgeInsets.only(bottom: 12.rh),
              child: CauseItemWidget(cause: cause),
            ),
          ),
        ],
      ),
    );
  }
}
