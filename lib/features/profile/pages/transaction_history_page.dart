import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/round_up_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/round_up_widgets.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/transaction_history_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/custom_assets/assets.gen.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  late final TransactionHistoryController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(TransactionHistoryController());
    controller.fetchTransactionHistory();
  }

  @override
  Widget build(BuildContext context) {
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
                      ...historyGroup.transactions.map(
                            (tx) => ActivityItem2(
                          activity: RecentActivity(
                            brandName: tx.organizationName,
                            brandLogo: tx.image ?? '',
                            purchaseAmount: tx.originalAmount.toDouble(),
                            roundUpAmount:
                            (tx.originalAmount - tx.amount).toDouble(),
                            timeAgo: tx.timeAgo,
                            donatedTo: tx.organizationName,
                            timestamp: tx.fullDate,
                            brandColor: Colors.black,
                            hasDetails: true,
                          ),
                        ),
                      ),
                      // Activities list for this date group
                      // ...historyGroup.transactions.asMap().entries.map(
                      //   (entry) => ActivityItem(
                      //     activity: RecentActivity(
                      //       brandName: entry.value.organizationName,
                      //       brandLogo: entry.value.image ?? '',
                      //       purchaseAmount: entry.value.originalAmount
                      //           .toDouble(),
                      //       roundUpAmount:
                      //           (entry.value.originalAmount -
                      //                   entry.value.amount)
                      //               .toDouble(),
                      //       timeAgo: entry.value.timeAgo,
                      //       donatedTo: entry.value.organizationName,
                      //       timestamp: entry.value.fullDate,
                      //       brandColor: Colors.black,
                      //       hasDetails: true,
                      //     ),
                      //     index: entry.key,
                      //     controller: controller,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ActivityItem2 extends StatefulWidget {
  final RecentActivity activity;

  const ActivityItem2({
    super.key,
    required this.activity,
  });

  @override
  State<ActivityItem2> createState() => _ActivityItemState();
}

class _ActivityItemState extends State<ActivityItem2> {
  bool isExpanded = false;

  void toggle() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  String formatTimestamp(String isoString) {
    try {
      // Parse ISO string to UTC DateTime
      final dateTimeUtc = DateTime.parse(isoString);

      // Convert to local time
      final localTime = dateTimeUtc.toLocal();

      // Format: Feb 15, 2026 08:30 AM
      final formatter = DateFormat('MMM dd, yyyy hh:mm a');
      return formatter.format(localTime);
    } catch (e) {
      // fallback if parsing fails
      return isoString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activity = widget.activity;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: toggle,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          margin: EdgeInsets.only(bottom: 8.rh),
          padding: EdgeInsets.all(8.rw),
          decoration: BoxDecoration(
            color: isExpanded
                ? const Color(0xFFF9F7F9)
                : DonationConstants.cardWhite,
            borderRadius: BorderRadius.circular(12.rw),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  /// Logo
                  Container(
                    width: 44.rw,
                    height: 44.rh,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(22.rw),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22.rw),
                      child: activity.brandLogo.isNotEmpty
                          ? Image.network(
                        activity.brandLogo,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _fallbackLogo(),
                      )
                          : _fallbackLogo(),
                    ),
                  ),

                  SizedBox(width: 8.rw),

                  /// Text Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(activity.brandName),
                            Text(
                              '\$${activity.purchaseAmount.toStringAsFixed(2)}',
                            ),
                          ],
                        ),
                        SizedBox(height: 6.rh),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(activity.timeAgo),
                            Text(
                              '+\$${activity.roundUpAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Color(0xFF1AC461),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// Arrow
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Assets.common.arrowDown.svg(
                      width: 16.rw,
                      height: 16.rh,
                    ),
                  ),
                ],
              ),

              if (isExpanded && activity.hasDetails) ...[
                SizedBox(height: 8.rh),
                Container(
                  height: 1,
                  color: const Color(0xFFEDEDED),
                ),
                SizedBox(height: 8.rh),

                if (activity.donatedTo != null)
                  _detailRow('Donated to:', activity.donatedTo!),

                if (activity.timestamp != null)
                  _detailRow('Timestamp:', formatTimestamp(activity.timestamp ?? "")),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _fallbackLogo() {
    final name = widget.activity.brandName;
    return Container(
      color: Colors.grey.withValues(alpha: 0.3),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '',
          style: TextStyle(
            fontSize: 18.rfs,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.rh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value),
        ],
      ),
    );
  }
}
