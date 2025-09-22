import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/confirm_donation_controller.dart';
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

class ConfirmDonationPage extends StatelessWidget {
  const ConfirmDonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConfirmDonationController());

    return Scaffold(
      backgroundColor: AppColors.lightPageBackground,
      appBar: CustomAppBar(
        title: 'Confirm & Donate',
        backgroundColor: AppColors.lightPageBackground,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.rw),
        child: Column(
          children: [
            // Organization Card
            _buildOrganizationCard(),
            
            16.rh.heightWidth,
            
            // Details Card
            _buildDetailsCard(controller),
            
            16.rh.heightWidth,
            
            // Transaction Details Card
            _buildTransactionDetailsCard(controller),
            
            24.rh.heightWidth,
            
            // Confirm & Donate Button
            _buildConfirmButton(controller, context),
          ],
        ),
      ),
    );
  }

  Widget _buildOrganizationCard() {
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
      child: Row(
        children: [
          // Organization Image
          Container(
            width: 104.rw,
            height: 104.rh,
            decoration: BoxDecoration(
              color: const Color(0xFFF4EAE2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Assets.home.varifiedCharitiesBlog1.image(
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          12.rw.heightWidth,
          
          // Organization Details
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(4.rw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bringing education to rural villages.',
                    style: AppTextStyles.f16W500().copyWith(
                      color: _offBlack,
                    ),
                  ),
                  
                  8.rh.heightWidth,
                  
                  Text(
                    'Healing Hands International',
                    style: AppTextStyles.f14W400().copyWith(
                      color: _grayText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(ConfirmDonationController controller) {
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
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(4.rw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Details',
                  style: AppTextStyles.f16W500().copyWith(
                    color: _offBlack,
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.onEditDetails(),
                  child: Text(
                    'Edit',
                    style: AppTextStyles.f14W400().copyWith(
                      color: _grayText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Detail Items
          _buildDetailItem('Donation type:', controller.donationType),
          _buildDetailItem('Donation cause:', controller.donationCause),
          _buildDetailItem('Threshold amount (per month):', controller.thresholdAmount),
          
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
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.all(4.rw),
      child: Row(
        children: [
          Text(
            label,
            style: AppTextStyles.f14W400().copyWith(
              color: _grayText,
            ),
          ),
          
          8.rw.heightWidth,
          
          Text(
            value,
            style: AppTextStyles.f14W400().copyWith(
              color: _offBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetailsCard(ConfirmDonationController controller) {
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
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(4.rw),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Transaction Details',
                style: AppTextStyles.f16W500().copyWith(
                  color: _offBlack,
                ),
              ),
            ),
          ),
          
          // Transaction Items
          _buildTransactionItem('To:', controller.organizationName),
          _buildTransactionItem('From:', controller.fromUser),
          _buildTransactionItem('By Debit Card:', controller.cardNumber),
          _buildTransactionItem('Taxes & Fees:', controller.taxesAndFees),
          
          // Divider
          Container(
            height: 1,
            width: double.infinity,
            color: _borderColor,
            margin: EdgeInsets.symmetric(vertical: 8.rh),
          ),
          
          // Admin Fees Checkbox
          Obx(() => Row(
            children: [
              GestureDetector(
                onTap: () => controller.toggleAdminFeesContribution(),
                child: Container(
                  width: 20.rw,
                  height: 20.rh,
                  decoration: BoxDecoration(
                    color: controller.contributeToAdminFees 
                        ? AppColors.primaryColor 
                        : Colors.transparent,
                    border: Border.all(
                      color: controller.contributeToAdminFees 
                          ? AppColors.primaryColor 
                          : _grayText,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: controller.contributeToAdminFees
                      ? const Icon(
                          Icons.check,
                          color: _white,
                          size: 14,
                        )
                      : null,
                ),
              ),
              
              8.rw.heightWidth,
              
              Text(
                'Contribute to admin fees.',
                style: AppTextStyles.f14W400().copyWith(
                  color: _offBlack,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.all(4.rw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

  Widget _buildConfirmButton(ConfirmDonationController controller, BuildContext context) {
    return ElevatedButton(
      onPressed: () => controller.onConfirmDonation(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: _offBlack,
        fixedSize: Size(double.maxFinite, 56.rh),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'Confirm & Donate',
        style: AppTextStyles.f16W500().copyWith(
          color: _white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    ).paddingXY(X: 56.rw);
  }
}
