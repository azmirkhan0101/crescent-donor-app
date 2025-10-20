import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

class ImpactCardWidget extends StatelessWidget {
  final String impactText;

  const ImpactCardWidget({super.key, required this.impactText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.rw),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF7EB),
        border: Border.all(color: const Color(0xFFEDEDED)),
        borderRadius: BorderRadius.circular(8.rw),
      ),
      child: Row(
        children: [
          Assets.home.lightbulb.svg(width: 20.rw, height: 20.rw),
          SizedBox(width: 8.rw),
          Expanded(
            child: Text(
              impactText,
              style: TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 14.rfs,
                color: const Color(0xFF000C0B),
                height: 1.29,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
