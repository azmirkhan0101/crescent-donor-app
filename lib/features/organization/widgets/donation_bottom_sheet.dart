import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/core/theme/theme.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/donate_now_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/get_org_causes_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/organization_controller.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/capsule_button_widget.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/date_time_selection_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/donation_type_card.dart';
import 'package:cresent_charge_user_app/features/profile/controllers/get_profile_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Donation bottom sheet with donation types and options
class DonationBottomSheet extends StatefulWidget {
  final String organizationName;

  const DonationBottomSheet({super.key, required this.organizationName});

  @override
  State<DonationBottomSheet> createState() => _DonationBottomSheetState();
}

class _DonationBottomSheetState extends State<DonationBottomSheet> {
  final donateNowController = Get.put(DonateNowController());

  final orgDetailsController = Get.find<OrganizationController>();
  final getOrgcausesController = Get.find<GetOrgCausesController>();

  @override
  void initState() {
    super.initState();
    // Fetch causes for the current organization
    final orgId = donateNowController.organizationId.value;
    if (orgId.isNotEmpty) {
      getOrgcausesController.fetchCausesByOrgId(orgId);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //   'isRecurringAvailable: ${donateNowController.isRecurringAvailable.value}, is Recurring: ${donateNowController.isRecurring.value}',
    // );
    // print(
    //   'isRoundUpAvailable: ${donateNowController.isRoundUpAvailable.value}, is RoundUp: ${donateNowController.isRoundUp.value}',
    // );
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border.all(color: const Color(0xFFEBE9EC)),
      ),
      child: Obx(() {
        bool isDonateTypeAvailable =
            (donateNowController.isOneTime.value ||
            (donateNowController.isRecurring.value &&
                donateNowController.isRecurringAvailable.value) ||
            (donateNowController.isRoundUp.value &&
                donateNowController.isRoundUpAvailable.value));
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar and header
            _buildHeader(),

            // --- Donation type, causes, amount, message ---
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.rw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Donation Type Section
                    _buildDonationTypeSection(controller: donateNowController),

                    16.rh.heightWidth,
                    if ((donateNowController.isRecurring.value &&
                            !donateNowController.isRecurringAvailable.value) ||
                        (donateNowController.isRoundUp.value &&
                            !donateNowController.isRoundUpAvailable.value))
                      _buildUnAvailableMessage(),

                    /// ============ Options Section ============
                    if (isDonateTypeAvailable)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Causes Section
                          _buildCausesSection(
                            donateNowController,
                            getOrgcausesController,
                          ),

                          SizedBox(height: 24.rh),

                          // Obx(() {
                          //   return donateNowController.selectedDonationType.value !=
                          //           DonationType.recurring
                          //       ? Column(
                          //           children: [
                          //             _selectAmountSection(donateNowController),
                          //             24.rh.heightWidth,
                          //           ],
                          //         )
                          //       : SizedBox.shrink();
                          // }),
                          _selectAmountSection(donateNowController),
                          24.rh.heightWidth,

                          // Message Section
                          _buildMessageSection(),

                          SizedBox(height: 200.rh),
                        ],
                      ),
                  ],
                ),
              ),
            ),

            if (isDonateTypeAvailable)
              /// Continue Button
              ElevatedButton(
                onPressed: () => _onClickContinueButton(),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(double.maxFinite, 56.rh),
                  backgroundColor: const Color(0xFF000C0B),
                  foregroundColor: Colors.white,
                ),
                child: Text('Continue'),
              ).paddingXY(X: 56.rw),
            24.rh.heightWidth,
          ],
        );
      }),
    );
  }

  Widget _buildUnAvailableMessage() {
    return Container(
      padding: EdgeInsets.all(20.rw),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E6),
        borderRadius: BorderRadius.circular(12.rw),
        border: Border.all(color: const Color(0xFFFFE8A3), width: 1),
      ),
      child: Column(
        children: [
          Icon(Icons.info_outline, size: 48.rw, color: const Color(0xFFD97706)),
          12.rh.heightWidth,
          Text(
            donateNowController.isRecurring.value
                ? 'Recurring Donations Not Available'
                : 'Round Up Donations Not Available',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 16.rfs,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF000C0B),
            ),
          ),
          8.rh.heightWidth,
          Text(
            '${widget.organizationName} not eligible for ${donateNowController.isRecurring.value ? 'recurring' : 'round up'} donations yet. Please try another donation type.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 14.rfs,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6E6E6E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.rw, vertical: 16.rh),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 32.rw,
            height: 4.rh,
            decoration: BoxDecoration(
              color: const Color(0xFF000C0B),
              borderRadius: BorderRadius.circular(100),
            ),
          ),

          SizedBox(height: 16.rh),

          // Title and close button
          Row(
            children: [
              Expanded(
                child: Text(
                  'Donation Details',
                  style: TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 20.rfs,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF000C0B),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SizedBox(
                  width: 20.rw,
                  height: 20.rh,
                  child: Icon(
                    Icons.close,
                    size: 20.rfs,
                    color: const Color(0xFF000C0B),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDonationTypeSection({required DonateNowController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Donation Type',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 16.rfs,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000C0B),
          ),
        ),

        SizedBox(height: 8.rh),

        Obx(() {
          return Row(
            children: [
              Expanded(
                child: FittedBox(
                  child: DonationTypeCard(
                    icon: Assets.home.coins.path,
                    title: 'Round Up',
                    type: DonationType.roundUp,
                    isSelected: controller.isRoundUp.value,
                  ),
                ),
              ),

              SizedBox(width: 8.rw),

              Expanded(
                child: FittedBox(
                  child: DonationTypeCard(
                    icon: Assets.home.calendar.path,
                    title: 'Recurring',
                    type: DonationType.recurring,
                    isSelected: controller.isRecurring.value,
                    isHighlighted: true,
                  ),
                ),
              ),

              SizedBox(width: 8.rw),

              Expanded(
                child: FittedBox(
                  child: DonationTypeCard(
                    icon: Assets.home.gift.path,
                    title: 'One Time',
                    type: DonationType.oneTime,
                    isSelected: controller.isOneTime.value,
                  ),
                ),
              ),
            ],
          );
        }),

        SizedBox(height: 8.rh),
        Text(
          'Set it and forget it!',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 14.rfs,
            fontStyle: FontStyle.italic,
            color: const Color(0xFF6E6E6E),
          ),
        ),
      ],
    );
  }

  Widget _buildCausesSection(
    DonateNowController controller,
    GetOrgCausesController causesController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Causes',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 16.rfs,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000C0B),
          ),
        ),

        SizedBox(height: 16.rh),

        Obx(() {
          return Wrap(
            spacing: 8.rw,
            children: causesController.causesByOrgId.map((cause) {
              final isSelected = controller.selectedCause.value?.id == cause.id;
              return CapsuleButton(
                title: cause.category,
                isSelected: isSelected,
                onTap: () {
                  controller.selectedCause.value = cause;
                },
              ).paddingB(8.rh);
            }).toList(),
            // children: causes.map((cause) {
            //   final isSelected = controller.selectedCause.value == cause;
            //   return CapsuleButton(
            //     title: cause,
            //     isSelected: isSelected,
            //     onTap: () {
            //       controller.changeSelectedCause(cause);
            //     },
            //   );
            // }).toList(),
          );
        }),
      ],
    );
  }

  Widget _selectAmountSection(DonateNowController donateNowController) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            donateNowController.selectedDonationType.value !=
                    DonationType.roundUp
                ? 'Amount'
                : 'Threshold amount',
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 16.rfs,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000C0B),
            ),
          ),

          SizedBox(height: 16.rh),

          Wrap(
            spacing: 8.rw,
            children: donateNowController.donationAmountsList.map((e) {
              final isSelected =
                  donateNowController.selectedAmountIndex.value ==
                  donateNowController.donationAmountsList.indexOf(e);
              return CapsuleButton(
                title: e['label'] as String,
                isSelected: isSelected,
                onTap: () {
                  donateNowController.selectedAmountIndex.value =
                      donateNowController.donationAmountsList.indexOf(e);
                  if (donateNowController.selectedAmountIndex.value !=
                      donateNowController.donationAmountsList.length - 1) {
                    donateNowController.amount.value = e['amount'] as num;
                  }
                },
              ).paddingB(8.rh);
            }).toList(),
          ),

          // Custom Amount Input
          SizedBox(height: 12.rh),
          if (donateNowController.selectedAmountIndex.value ==
              donateNowController.donationAmountsList.length - 1)
            GestureDetector(
              onTap: () {
                donateNowController.amount.value = 0;
              },
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixText: '\$',
                  prefixStyle: TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 14.rfs,
                    color: const Color(0xFF000C0B),
                  ),
                  border: InputBorder.none,
                  hintText: 'Custom Amount',
                  hintStyle: TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 14.rfs,
                    color: const Color(0xFF9E9E9E),
                  ),
                ),
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 14.rfs,
                  color: const Color(0xFF000C0B),
                ),
                onChanged: (value) {
                  final parsedValue = double.tryParse(value) ?? 0;
                  donateNowController.amount.value = parsedValue;
                },
              ),
            ),
        ],
      );
    });
  }

  Widget _buildMessageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Add a Special Message ',
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 16.rfs,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000C0B),
            ),
            children: [
              TextSpan(
                text: '(Optional)',

                style: TextStyle(
                  color: const Color(0xFFE4E4E4),
                  fontSize: 12.rfs,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.rh),

        TextField(
          controller: donateNowController.specialMsgController,
          maxLines: 4,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Add your message here...',
            hintStyle: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 14.rfs,
              color: const Color(0xFF9E9E9E),
            ),
          ),
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 14.rfs,
            color: const Color(0xFF000C0B),
          ),
        ),
      ],
    );
  }

  void _onClickContinueButton() {
    // If guest user, show error
    bool isGuestUser = Get.find<GetProfileController>().isGuestUser.value;
    if (isGuestUser) {
      ToastMsg.error('Guest users cannot proceed with donations.');
      return;
    }
    // If no cause selected, show Error
    if (donateNowController.selectedCause.value == null) {
      ToastMsg.error('Please select a cause to proceed.');
      return;
    }
    // If no amount selected, show Error
    if (donateNowController.amount.value <= 0) {
      ToastMsg.error('Please select a valid donation amount to proceed.');
      return;
    }

    // Close bottom sheet first
    // GoRouter.of(context).pop();
    if (donateNowController.isOneTime.value) {
      GoRouter.of(context).pop();
      Future.delayed(const Duration(milliseconds: 500));
      GoRouter.of(context).pushNamed(RoutePath.linkedPaymentAccount);
    }
    if (donateNowController.isRoundUp.value) {
      GoRouter.of(context).pop();
      Future.delayed(const Duration(milliseconds: 500));
      GoRouter.of(context).pushNamed(RoutePath.connectedBankAccount);
    }
    if (donateNowController.isRecurring.value) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const DateTimeSelectionBottomSheet(),
      );
    }
  }
}

enum DonationType { roundUp, recurring, oneTime }
