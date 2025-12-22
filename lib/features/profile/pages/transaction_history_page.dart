import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/round_up_controller.dart';
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
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: CustomAppBar(
            title: 'Transaction History',
            backgroundColor: const Color(0xFFF7F7F7),
          ),
          body: Obx(() {
            // Show loading indicator
            if (controller.isLoading.value &&
                controller.transactionHistory.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            // Show error if any
            if (controller.errorMessage.value.isNotEmpty &&
                controller.transactionHistory.isEmpty) {
              return Center(
                child: Text(
                  controller.errorMessage.value,
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: 14.rfs,
                    color: Colors.red,
                  ),
                ),
              );
            }

            // Show empty state
            if (controller.transactionHistory.isEmpty) {
              return Center(
                child: Text(
                  'No transactions found',
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: 14.rfs,
                    color: Colors.grey,
                  ),
                ),
              );
            }

            return SafeArea(
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
                      // Loop through all transaction history groups
                      ...controller.transactionHistory.expand(
                        (historyGroup) => [
                          // Date section header
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8.rw,
                              bottom: 8.rh,
                              top: 8.rh,
                            ),
                            child: Text(
                              historyGroup.title,
                              style: TextStyle(
                                fontFamily: DonationFonts.interDisplay,
                                fontSize: 11.rfs,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.withValues(alpha: 0.6),
                                height: 16 / 11,
                              ),
                            ),
                          ),

                          // Activities list for this date group
                          ...historyGroup.transactions.asMap().entries.map(
                            (entry) => ActivityItem(
                              activity: RecentActivity(
                                brandName: entry.value.organizationName,
                                brandLogo: entry.value.image ?? '',
                                purchaseAmount: entry.value.originalAmount
                                    .toDouble(),
                                roundUpAmount:
                                    (entry.value.originalAmount -
                                            entry.value.amount)
                                        .toDouble(),
                                timeAgo: entry.value.timeAgo,
                                donatedTo: entry.value.organizationName,
                                timestamp: entry.value.fullDate,
                                brandColor: Colors.black,
                                hasDetails: true,
                              ),
                              index: entry.key,
                              controller: controller,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
