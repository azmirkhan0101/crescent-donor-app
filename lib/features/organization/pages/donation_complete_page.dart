import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/donate_now_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/donation_complete_controller.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

// Define colors from Figma design
const Color _offBlack = Color(0xFF000C0B);
const Color _white = Color(0xFFFFFFFF);
const Color _grayText = Color(0xFF6E6E6E);
const Color _borderColor = Color(0xFFEDEDED);

class DonationCompletePage extends StatelessWidget {
  const DonationCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DonationCompleteController());
    final donateNowCtrl = Get.find<DonateNowController>();

    return Scaffold(
      backgroundColor: AppColors.lightPageBackground,
      appBar: _buildAppBar(controller, context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.rw),
        child: Column(
          children: [
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
            _buildSummaryCard(controller, donateNowCtrl),

            24.rh.heightWidth,

            // Save Receipt Button
            _buildSaveReceiptButton(controller),

            60.rh.heightWidth,

            // Done Button
            _buildDoneButton(context),
          ],
        ),
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

  Widget _buildSummaryCard(
    DonationCompleteController controller,
    DonateNowController donateNowCtrl,
  ) {
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
          _buildSummaryItem(
            'Amount donated:',
            "\$${donateNowCtrl.amount.value.toStringAsFixed(2).toString()}",
          ),
          _buildSummaryItem(
            'Organization:',
            donateNowCtrl
                    .orgDetailsController
                    .organizationDetails
                    .value
                    ?.name ??
                '',
          ),
          _buildSummaryItem(
            'Donation Type:',
            donateNowCtrl.selectedDonationType.value.name,
          ),

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
                  donateNowCtrl.specialMsgController.text.isNotEmpty
                      ? '"${donateNowCtrl.specialMsgController.text}"'
                      : "No special message provided.",
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
            'Timestamp:',
            donateNowCtrl.formatDate(
              donateNowCtrl.donationResponse.value?.donation?.donationDate ??
                  DateTime.now(),
            ),
          ),
          _buildSummaryItem(
            'Transaction ID:',
            donateNowCtrl.donationResponse.value?.donation?.id ?? '',
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

  Widget _buildSaveReceiptButton(DonationCompleteController controller) {
    return GestureDetector(
      onTap: () => controller.onSaveReceipt(),
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
