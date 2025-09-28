import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/round_up_widgets.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/transaction_history_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionHistoryController>(
      init: TransactionHistoryController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Color(0xFFF7F7F7),
          appBar: CustomAppBar(
            title: 'Transaction History',
            backgroundColor: Color(0xFFF7F7F7),
          ),
          body: SafeArea(
            child: Container(
              margin: EdgeInsets.all(16.rh),
              width: double.infinity,
              padding: EdgeInsets.all(8.rw),
              decoration: BoxDecoration(
                color: DonationConstants.cardWhite,
                borderRadius: BorderRadius.circular(12.rw),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Today section
                    Padding(
                      padding: EdgeInsets.only(left: 8.rw, bottom: 8.rh),
                      child: Text(
                        'Today',
                        style: TextStyle(
                          fontFamily: DonationFonts.interDisplay,
                          fontSize: 11.rfs,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.withValues(alpha: 0.6),
                          height: 16 / 11,
                        ),
                      ),
                    ),

                    // Activities list
                    ...controller.todaysActivities.asMap().entries.map(
                      (entry) => ActivityItem(
                        activity: entry.value,
                        index: entry.key,
                        controller: controller,
                      ),
                    ),

                    SizedBox(height: 16.rh),

                    // Earlier section
                    Padding(
                      padding: EdgeInsets.only(left: 8.rw, bottom: 8.rh),
                      child: Text(
                        '28 July',
                        style: TextStyle(
                          fontFamily: DonationFonts.interDisplay,
                          fontSize: 11.rfs,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.withValues(alpha: 0.6),
                          height: 16 / 11,
                        ),
                      ),
                    ),

                    // Earlier activities from controller
                    ...controller.earlierActivities.asMap().entries.map(
                      (entry) => ActivityItem(
                        activity: entry.value,
                        index: controller.todaysActivities.length + entry.key,
                        controller: controller,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
