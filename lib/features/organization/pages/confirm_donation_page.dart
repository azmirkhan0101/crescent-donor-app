import 'package:cresent_charge_user_app/common-widgets/custom_app_bar.dart';
import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/core/helper/url_parser/image_url_parser.dart';
import 'package:cresent_charge_user_app/features/common/controllers/roundup-management/save_roundup_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/create_recurring_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/donate_now_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/organization_controller.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/donation_bottom_sheet.dart';
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
  const ConfirmDonationPage({super.key, this.paymentMethodId});
  final String? paymentMethodId;

  @override
  Widget build(BuildContext context) {
    // final confirmDonationController = Get.put(ConfirmDonationController());

    // Organization details controller
    final orgController = Get.find<OrganizationController>();
    // donate now controller
    final donateNowCtrl = Get.find<DonateNowController>();
    // cause controller
    // payment method controller
    final paymentMethodCtrl = Get.find<PaymentMethodController>();

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
                  orgController.organizationDetails.value?.logoImage ?? '',
              causeDetails:
                  donateNowCtrl.selectedCause.value?.description ?? '',
              orgName: orgController.organizationDetails.value?.name ?? '',
            ),

            16.rh.heightWidth,

            // Details Card
            _buildDetailsCard(donateNowCtrl, context),

            16.rh.heightWidth,

            // Transaction Details Card
            _buildTransactionDetailsCard(),

            24.rh.heightWidth,

            // Confirm & Donate Button
            _buildConfirmButton(
              donateNowCtrl,
              context,
              paymentMethodId: paymentMethodId,
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
    DonateNowController donateNowCtrl,
    BuildContext context,
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
                  onTap: () => _onEditTap(context),
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
            'Threshold amount:',
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

  Widget _buildTransactionDetailsCard() {
    final orgDetailsCtrl = Get.find<OrganizationController>();
    final paymentMethodCtrl = Get.find<PaymentMethodController>();
    final donateNowCtrl = Get.find<DonateNowController>();

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
      child: Obx(() {
        // Calculate fees reactively based on checkbox state
        final calculatedAmounts = calculateAustralianFees(
          baseAmount: donateNowCtrl.amount.value.toDouble(),
          coverFees: donateNowCtrl.contributeToAdminFees,
        );

        return Column(
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
            _buildTransactionItem(
              'From:',
              paymentMethod.cardHolderName ?? 'Card Holder',
            ),
            // _buildTransactionItem('By Debit Card:', controller.cardDisplayName),
            _buildTransactionItem(
              'By ${paymentMethod.cardBrand.toUpperCase()} Card:',
              "**** **** **** ${paymentMethod.cardLast4}",
            ),
            // Stripe fees : 4.75%
            // _buildTransactionItem('Stripe fees:', "\$$stripeFees"),
            _buildTransactionItem(
              'Stripe fees:',
              "\$${calculatedAmounts['stripeFee'].toStringAsFixed(2)}",
            ),

            // _buildTransactionItem('Taxes & Fees:', controller.taxesAndFees),
            _buildTransactionItem(
              'Taxes & Admin Fees:',
              donateNowCtrl.contributeToAdminFees
                  ? "\$${calculatedAmounts['platformFee'].toStringAsFixed(2)}"
                  : "\$0.00",
            ),

            // Divider
            Container(
              height: 1,
              width: double.infinity,
              color: _borderColor,
              margin: EdgeInsets.symmetric(vertical: 8.rh),
            ),

            _buildTransactionItem(
              "Total",
              "\$${(donateNowCtrl.amount.value + calculatedAmounts['stripeFee'] + (donateNowCtrl.contributeToAdminFees ? calculatedAmounts['platformFee'] : 0.0)).toStringAsFixed(2)}",
            ),

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
                    onTap: () => donateNowCtrl.toggleAdminFeesContribution(),
                    child: Container(
                      width: 20.rw,
                      height: 20.rh,
                      decoration: BoxDecoration(
                        color: donateNowCtrl.contributeToAdminFees
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        border: Border.all(
                          color: donateNowCtrl.contributeToAdminFees
                              ? AppColors.primaryColor
                              : _grayText,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: donateNowCtrl.contributeToAdminFees
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
        );
      }),
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
    DonateNowController donateNowController,
    BuildContext context, {
    required paymentMethodId,
  }) {
    return Obx(() {
      final isOneTime =
          donateNowController.selectedDonationType.value ==
          DonationType.oneTime;
      final isRecurring =
          donateNowController.selectedDonationType.value ==
          DonationType.recurring;
      final isRoundUp =
          donateNowController.selectedDonationType.value ==
          DonationType.roundUp;
      return ElevatedButton(
        onPressed: () async {
          if (donateNowController.isPaymentProcessing.value) return;
          if (isOneTime) {
            donateNowController.onConfirmDonation(
              context,
              paymentMethodId: paymentMethodId,
            );
          }
          if (isRoundUp) {
            // print('Round Up Donation Confirmed');
            bool isSuccess = await Get.find<SaveRoundupController>()
                .saveRoundupConsent(
                  bankConnectionId:
                      donateNowController.selectedBankAccountId.value,
                  organizationId: donateNowController.organizationId.value,
                  causeId: donateNowController.selectedCause.value?.id ?? '',
                  monthlyThreshold: donateNowController.amount.value.toDouble(),
                  paymentMethodId: paymentMethodId,
                );

            if (isSuccess) {
              ToastMsg.success('Round Up donation saved successfully');
              GoRouter.of(context).goNamed(RoutePath.home);
            } else {
              ToastMsg.error(
                Get.find<SaveRoundupController>().errorMessage.value,
              );
            }
          }
          if (isRecurring) {
            // print('Recurring Donation Confirmed');
            bool isSuccess = await Get.find<CreateRecurringController>()
                .createScheduledDonation(paymentMethodId: paymentMethodId);
            if (isSuccess) {
              ToastMsg.success('Recurring donation saved successfully');
              GoRouter.of(context).goNamed(RoutePath.home);
            } else {
              ToastMsg.error(
                Get.find<CreateRecurringController>().errorMessage.value,
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _offBlack,
          fixedSize: Size(double.maxFinite, 56.rh),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBackgroundColor: _grayText,
        ),
        child: donateNowController.isPaymentProcessing.value
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(_white),
                ),
              )
            : Text(
                isOneTime
                    ? 'Confirm & Donate'
                    : isRoundUp
                    ? 'Save Round Up'
                    : 'Save Recurring Donation',
                style: AppTextStyles.f16W500().copyWith(
                  color: _white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ).paddingXY(X: 56.rw);
    });
  }

  void _onEditTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => DonationBottomSheet(
          organizationName:
              Get.find<OrganizationController>()
                  .organizationDetails
                  .value
                  ?.name ??
              'N/A',
        ),
      ),
    );
  }

  /// calculate
  Map<String, dynamic> calculateAustralianFees({
    required double baseAmount,
    required bool coverFees,
    double platformFeePercent = 0.05,
    double gstRate = 0.10,
    double stripeFeePercent = 0.029, // AU default
    double stripeFixedFee = 0.30,
  }) {
    double round2(double value) => (value * 100).roundToDouble() / 100;

    // Calculate stripe fee always based on base amount (fixed)
    final double stripeFee = round2(
      baseAmount * stripeFeePercent + stripeFixedFee,
    );

    // Platform Revenue + GST
    final double platformFee = round2(baseAmount * platformFeePercent);
    final double gstOnFee = round2(platformFee * gstRate);
    final double applicationFee = platformFee + gstOnFee;

    double totalCharge = 0;
    double netToOrg = 0;

    if (coverFees) {
      // Scenario A: Donor pays everything
      totalCharge = round2(baseAmount + stripeFee + applicationFee);
      netToOrg = baseAmount;
    } else {
      // Scenario B: Donor pays base only, org absorbs fees
      totalCharge = baseAmount;
      netToOrg = round2(baseAmount - stripeFee - applicationFee);
    }

    final double platformFeeWithStripe = stripeFee + applicationFee;
    return {
      'baseAmount': baseAmount, // Tax deductible
      'platformFee': platformFee, // Platform revenue
      'gstOnFee': gstOnFee, // GST liability
      'stripeFee': stripeFee, // Stripe cost (fixed)
      'totalCharge': totalCharge, // Charge to card
      'applicationFee': applicationFee, // Stripe application_fee_amount
      'netToOrg': netToOrg, // Credited to org
      'coverFees': coverFees,
      'platformFeeWithStripe': platformFeeWithStripe,
    };
  }
}
