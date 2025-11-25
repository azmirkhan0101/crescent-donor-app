import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/url_parser/image_url_parser.dart';
import 'package:cresent_charge_user_app/features/home/controllers/causes_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/confirm_donation_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/donate_now_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/organization_details_controller.dart';
import 'package:cresent_charge_user_app/features/payment/controllers/payment_method_controller.dart';
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

class ConfirmDonationPage extends StatelessWidget {
  final String? paymentMethodId;

  const ConfirmDonationPage({super.key, this.paymentMethodId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ConfirmDonationController>()
        ? Get.find<ConfirmDonationController>()
        : Get.put(ConfirmDonationController());

    // Organization details controller
    final orgDetailsCtrl = Get.find<OrganizationDetailsController>();
    // donate now controller
    final donateNowCtrl = Get.find<DonateNowController>();
    // cause controller
    final causeCtrl = Get.find<CausesController>();
    // payment method controller
    final paymentMethodCtrl = Get.find<PaymentMethodController>();

    // Get payment method ID from GoRouter query parameters
    final state = GoRouterState.of(context);
    final paymentMethodId = state.uri.queryParameters['paymentMethodId'];

    // Initialize controller with payment method
    if (paymentMethodId != null) {
      controller.initializeWithPaymentMethod(paymentMethodId);
    }

    // final selectedCause = causeCtrl.causesByOrgId.firstWhere(
    //   (cause) => cause.id == donateNowCtrl.selectedCauseId.value,
    //   orElse: () => causeCtrl.causesByOrgId.isNotEmpty
    //       ? causeCtrl.causesByOrgId[0]
    //       : throw Exception('No causes available'),
    // );

    // print(
    //   '-----------> ${orgDetailsCtrl.organizationDetails.value?.logoImage}',
    // );

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
            _buildOrganizationCard(
              orgLogoUrl:
                  orgDetailsCtrl.organizationDetails.value?.logoImage ?? '',
              causeDetails: causeCtrl.causesByOrgId[0].description,
              orgName: orgDetailsCtrl.organizationDetails.value?.name ?? '',
            ),

            16.rh.heightWidth,

            // Details Card
            _buildDetailsCard(causeCtrl, donateNowCtrl),

            16.rh.heightWidth,

            // Transaction Details Card
            _buildTransactionDetailsCard(
              controller,
              paymentMethodCtrl,
              orgDetailsCtrl: orgDetailsCtrl,
            ),

            24.rh.heightWidth,

            // Confirm & Donate Button
            _buildConfirmButton(
              controller,
              context,
              amount: donateNowCtrl.amount.value,
              organizationId:
                  orgDetailsCtrl.organizationDetails.value?.id ?? '',
              causeId: donateNowCtrl.selectedCause.value?.id ?? '',
              specialMessage: donateNowCtrl.specialMsgController.text,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrganizationCard({
    required String causeDetails,
    required String orgName,
    required String orgLogoUrl,
  }) {
    // final OrganizationDetailsModel? org = controller.organizationDetails.value;
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
              child: Image.network(
                parseImageUrl(orgLogoUrl),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Assets.home.varifiedCharitiesBlog1.image(
                    fit: BoxFit.cover,
                  );
                },
              ),
              // child: Assets.home.varifiedCharitiesBlog1.image(
              //   fit: BoxFit.cover,
              // ),
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
                    causeDetails,
                    style: AppTextStyles.f16W500().copyWith(color: _offBlack),
                  ),

                  8.rh.heightWidth,

                  Text(
                    // 'Healing Hands International',
                    orgName,
                    style: AppTextStyles.f14W400().copyWith(color: _grayText),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(
    CausesController causeCtrl,
    DonateNowController donateNowCtrl,
  ) {
    // selected cause name
    // final selectedCauseName = causeCtrl.causesByOrgId
    //     .firstWhere(
    //       (cause) => cause.id == donateNowCtrl.selectedCause.value?.id,
    //       orElse: () => causeCtrl.causesByOrgId.isNotEmpty
    //           ? causeCtrl.causesByOrgId[0]
    //           : throw Exception('No causes available'),
    //     )
    //     .name;
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
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(4.rw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Details',
                  style: AppTextStyles.f16W500().copyWith(color: _offBlack),
                ),
                GestureDetector(
                  // onTap: () => controller.onEditDetails(),
                  child: Text(
                    'Edit',
                    style: AppTextStyles.f14W400().copyWith(color: _grayText),
                  ),
                ),
              ],
            ),
          ),

          // Detail Items
          _buildDetailItem(
            'Donation type:',
            donateNowCtrl.selectedDonationType.value.name,
          ),
          _buildDetailItem(
            'Donation cause:',
            donateNowCtrl.selectedCause.value?.name ?? '',
          ),
          _buildDetailItem(
            'Threshold amount (per month):',
            "\$${donateNowCtrl.amount.value.toString()}",
          ),

          // Special Message
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(4.rw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Special message:',
                    style: AppTextStyles.f14W400().copyWith(color: _grayText),
                  ),

                  8.rh.heightWidth,

                  Text(
                    donateNowCtrl.specialMsgController.text,
                    style: AppTextStyles.f14W400().copyWith(
                      color: _offBlack,
                      fontWeight: FontWeight.w500,
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

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.all(4.rw),
      child: Row(
        children: [
          Text(
            label,
            style: AppTextStyles.f14W400().copyWith(color: _grayText),
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

  Widget _buildTransactionDetailsCard(
    ConfirmDonationController controller,
    PaymentMethodController paymentMethodCtrl, {
    required OrganizationDetailsController orgDetailsCtrl,
  }) {
    final paymentMethod = paymentMethodCtrl.paymentMethods.firstWhere(
      (method) => method.id == paymentMethodId,
    );
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
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(4.rw),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Transaction Details',
                style: AppTextStyles.f16W500().copyWith(color: _offBlack),
              ),
            ),
          ),

          // Transaction Items
          // _buildTransactionItem('To:', controller.organizationName),
          _buildTransactionItem(
            'To:',
            orgDetailsCtrl.organizationDetails.value?.name ?? '',
          ),
          // _buildTransactionItem('From:', controller.fromUser),
          _buildTransactionItem('From:', paymentMethod.cardHolderName),
          // _buildTransactionItem('By Debit Card:', controller.cardDisplayName),
          _buildTransactionItem(
            'By ${paymentMethod.cardBrand.toUpperCase()} Card:',
            "**** **** **** ${paymentMethod.cardLast4}",
          ),
          // _buildTransactionItem('Taxes & Fees:', controller.taxesAndFees),
          _buildTransactionItem('Taxes & Fees:', '\$0.5'),

          // Divider
          Container(
            height: 1,
            width: double.infinity,
            color: _borderColor,
            margin: EdgeInsets.symmetric(vertical: 8.rh),
          ),

          // Admin Fees Checkbox
          Obx(
            () => Row(
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
                        ? const Icon(Icons.check, color: _white, size: 14)
                        : null,
                  ),
                ),

                8.rw.heightWidth,

                Text(
                  'Contribute to admin fees.',
                  style: AppTextStyles.f14W400().copyWith(color: _offBlack),
                ),
              ],
            ),
          ),
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

  Widget _buildConfirmButton(
    ConfirmDonationController controller,
    BuildContext context, {
    required int amount,
    required String organizationId,
    required String causeId,
    String? specialMessage,
  }) {
    // Get required data from controllers

    return Obx(
      () => ElevatedButton(
        onPressed: controller.isProcessing.value
            ? null
            : () {
                controller.onConfirmDonation(
                  context,
                  amount: amount,
                  organizationId: organizationId,
                  causeId: causeId,
                  specialMessage: specialMessage,
                );
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: _offBlack,
          fixedSize: Size(double.maxFinite, 56.rh),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBackgroundColor: _grayText,
        ),
        child: controller.isProcessing.value
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(_white),
                ),
              )
            : Text(
                'Confirm & Donate',
                style: AppTextStyles.f16W500().copyWith(
                  color: _white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ).paddingXY(X: 56.rw),
    );
  }
}
