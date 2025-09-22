import 'package:cresent_charge_user_app/features/organization/controllers/donation_complete_controller.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Define colors from Figma design
const Color _offBlack = Color(0xFF000C0B);
const Color _white = Color(0xFFFFFFFF);
const Color _grayText = Color(0xFF6E6E6E);
const Color _borderColor = Color(0xFFEDEDED);
const Color _successGreen = Color(0xFF22C55E);

class DonationCompletePage extends StatelessWidget {
  const DonationCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DonationCompleteController());

    return Scaffold(
      backgroundColor: AppColors.lightPageBackground,
      appBar: AppBar(
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
            onPressed: () => controller.onClosePressed(),
            icon: Container(
              width: 24.rw,
              height: 24.rh,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.close,
                color: _offBlack,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.rw),
        child: Column(
          children: [
            32.rh.heightWidth,
            
            // Success Icon
            _buildSuccessIcon(),
            
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
            _buildSummaryCard(controller),
            
            24.rh.heightWidth,
            
            // Save Receipt Button
            _buildSaveReceiptButton(controller),
            
            32.rh.heightWidth,
            
            // Done Button
            _buildDoneButton(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 120.rw,
      height: 120.rh,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _successGreen,
        boxShadow: [
          BoxShadow(
            color: _successGreen.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Main checkmark
          Center(
            child: Icon(
              Icons.check,
              color: _white,
              size: 48.rw,
              weight: 3,
            ),
          ),
          
          // Decorative sparkles around the circle
          Positioned(
            top: 10.rh,
            left: 20.rw,
            child: _buildSparkle(8.rw),
          ),
          Positioned(
            top: 20.rh,
            right: 15.rw,
            child: _buildSparkle(12.rw),
          ),
          Positioned(
            bottom: 15.rh,
            left: 15.rw,
            child: _buildSparkle(6.rw),
          ),
          Positioned(
            bottom: 25.rh,
            right: 20.rw,
            child: _buildSparkle(10.rw),
          ),
          Positioned(
            top: 40.rh,
            left: -5.rw,
            child: _buildSparkle(14.rw),
          ),
          Positioned(
            bottom: 40.rh,
            right: -5.rw,
            child: _buildSparkle(16.rw),
          ),
        ],
      ),
    );
  }

  Widget _buildSparkle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _successGreen,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.add,
        color: _white,
        size: size * 0.6,
      ),
    );
  }

  Widget _buildSummaryCard(DonationCompleteController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.rw),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
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
              style: AppTextStyles.f16W500().copyWith(
                color: _offBlack,
              ),
            ),
          ),
          
          // Summary Items
          _buildSummaryItem('Amount donated:', controller.amountDonated),
          _buildSummaryItem('Organization:', controller.organization),
          _buildSummaryItem('Donation Type:', controller.donationType),
          
          // Special Message
          Padding(
            padding: EdgeInsets.all(4.rw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Special message:',
                  style: AppTextStyles.f14W400().copyWith(
                    color: _grayText,
                  ),
                ),
                
                8.rh.heightWidth,
                
                Text(
                  controller.specialMessage,
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
          _buildSummaryItem('Timestamp:', controller.timestamp),
          _buildSummaryItem('Transaction ID:', controller.transactionId),
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
            style: AppTextStyles.f14W400().copyWith(
              color: _grayText,
            ),
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
          Icon(
            Icons.download_outlined,
            color: _offBlack,
            size: 16.rw,
          ),
          
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

  Widget _buildDoneButton(DonationCompleteController controller) {
    return ElevatedButton(
      onPressed: () => controller.onDonePressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: _offBlack,
        fixedSize: Size(double.maxFinite, 56.rh),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
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
