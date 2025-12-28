import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/date_time_converter/date_time_converter.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/donate_now_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/donation_complete_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/get_donation_full_status_controller.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

// Define colors from Figma design
const Color _offBlack = Color(0xFF000C0B);
const Color _white = Color(0xFFFFFFFF);
const Color _grayText = Color(0xFF6E6E6E);
const Color _borderColor = Color(0xFFEDEDED);

class DonationCompletePage extends StatelessWidget {
  const DonationCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    final donationCompleteController = Get.put(DonationCompleteController());
    final donateNowCtrl = Get.find<DonateNowController>();
    print('Donation ID: ${donateNowCtrl.donationResponse.value?.donation?.id}');

    return Scaffold(
      backgroundColor: AppColors.lightPageBackground,
      appBar: _buildAppBar(donationCompleteController, context),
      body: GetX<GetDonationFullStatusController>(
        initState: (state) async {
          final donationId =
              donateNowCtrl.donationResponse.value?.donation?.id ?? '';
          if (donationId.isNotEmpty) {
            state.controller?.fetchDonationFullStatus(donationId);
          }
        },

        builder: (controller) {
          final donationDetails = controller.donationFullStatus.value?.donation;
          return RefreshIndicator(
            onRefresh: () async {
              final donationId =
                  donateNowCtrl.donationResponse.value?.donation?.id ?? '';
              if (donationId.isNotEmpty) {
                await controller.fetchDonationFullStatus(donationId);
              }
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.rw),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  if (controller.isLoading.value)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  else ...[
                    24.rh.heightWidth,

                    // Success Icon
                    // _buildSuccessIcon(),
                    Assets.home.starsTickMark.svg(),

                    24.rh.heightWidth,

                    // Thank You Message
                    Text(
                      'Thank you for your donation!',
                      style: AppTextStyles.f20w600().copyWith(
                        color: _offBlack,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.2,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    32.rh.heightWidth,

                    // Summary Card
                    _buildSummaryCard(
                      donatedAmount: donationDetails?.totalAmount
                          .toStringAsFixed(2),
                      organizationName:
                          donationDetails?.organization.name ?? 'N/A',
                      donationType: donationDetails?.donationType ?? 'N/A',
                      specialMessage: donationDetails?.specialMessage,
                      time: donationDetails?.createdAt,
                      receiptId: donationDetails?.receiptId?.id,
                    ),

                    24.rh.heightWidth,

                    // Save Receipt Button
                    _buildSaveReceiptButton(
                      donationId:
                          donateNowCtrl.donationResponse.value?.donation?.id,
                      pdfUrl: donationDetails?.receiptId?.pdfUrl,
                      controller: donationCompleteController,
                    ),

                    60.rh.heightWidth,

                    // Done Button
                    _buildDoneButton(context),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(
    DonationCompleteController controller,
    BuildContext context,
  ) {
    return AppBar(
      backgroundColor: AppColors.lightPageBackground,
      elevation: 0,
      centerTitle: true,
      leading: const SizedBox.shrink(),
      title: Text(
        'Donation Complete',
        style: AppTextStyles.f20w600().copyWith(
          color: _offBlack,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.2,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => context.goNamed(RoutePath.home),
          icon: Container(
            width: 24.rw,
            height: 24.rh,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
            child: const Icon(Icons.close, color: _offBlack, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    String? donatedAmount,
    String? organizationName,
    String? donationType,
    String? specialMessage,
    String? time,
    String? receiptId,
  }) {
    // print(receiptId);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.rw),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(4.rw),
            child: Text(
              'Summary',
              style: AppTextStyles.f16W500().copyWith(color: _offBlack),
            ),
          ),

          // Summary Items
          _buildSummaryItem('Amount donated:', "\$$donatedAmount"),
          _buildSummaryItem('Organization:', organizationName ?? "N/A"),
          _buildSummaryItem('Donation Type:', donationType ?? "N/A"),

          // Special Message
          Padding(
            padding: EdgeInsets.all(4.rw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Special message:',
                  style: AppTextStyles.f14W400().copyWith(color: _grayText),
                ),

                8.rh.heightWidth,

                Text(
                  specialMessage ?? "No special message provided.",
                  style: AppTextStyles.f14W400().copyWith(
                    color: _offBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Container(
            height: 1,
            width: double.infinity,
            color: _borderColor,
            margin: EdgeInsets.symmetric(vertical: 8.rh),
          ),

          // Timestamp and Transaction ID
          _buildSummaryItem(
            'Time:',
            DateConverter.isoStringToFormattedDateTime(time ?? '') ?? 'N/A',
          ),
          Skeletonizer(
            enabled: receiptId == null,
            child: _buildSummaryItem('Transaction ID:', receiptId ?? "N/A"),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.all(4.rw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.f14W400().copyWith(color: _grayText),
          ),

          Flexible(
            child: Text(
              value,
              style: AppTextStyles.f14W400().copyWith(
                color: _offBlack,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveReceiptButton({
    required String? donationId,
    required String? pdfUrl,
    required DonationCompleteController controller,
  }) {
    return GestureDetector(
      onTap: () async {
        if (pdfUrl != null && pdfUrl.isNotEmpty) {
          // Download the receipt
          await controller.downloadReceipt(
            pdfUrl,
            'CrescentCharge_Receipt_${DateTime.now().millisecondsSinceEpoch}',
          );

          // Also open in browser for viewing
          await controller.openReceiptInBrowser(pdfUrl);
        } else {
          if (donationId != null && donationId.isNotEmpty) {
            final getDonateCtrl = Get.find<GetDonationFullStatusController>();
            await getDonateCtrl.fetchDonationFullStatus(donationId);
            final updatedPdfUrl = getDonateCtrl
                .donationFullStatus
                .value
                ?.donation
                .receiptId
                ?.pdfUrl;
            if (updatedPdfUrl != null && updatedPdfUrl.isNotEmpty) {
              // Download the receipt
              await controller.downloadReceipt(
                updatedPdfUrl,
                'CrescentCharge_Receipt_${DateTime.now().millisecondsSinceEpoch}',
              );
              // Also open in browser for viewing
              await controller.openReceiptInBrowser(updatedPdfUrl);
            } else {
              ToastMsg.error('Receipt not available.');
            }
          } else {
            ToastMsg.error('Receipt not available.');
          }
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.common.downloadArrow.svg(),

          8.rw.heightWidth,

          Text(
            'Save receipt',
            style: AppTextStyles.f14W400().copyWith(
              color: _offBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.goNamed(RoutePath.home),
      style: ElevatedButton.styleFrom(
        backgroundColor: _offBlack,
        fixedSize: Size(double.maxFinite, 56.rh),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        'Done',
        style: AppTextStyles.f16W500().copyWith(
          color: _white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    ).paddingXY(X: 56.rw);
  }
}
