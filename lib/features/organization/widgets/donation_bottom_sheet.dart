import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/theme/theme.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/organization_details_controller.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/capsule_button_widget.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/date_time_selection_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/donation_type_card.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Donation bottom sheet with donation types and options
class DonationBottomSheet extends StatefulWidget {
  final String organizationName;

  const DonationBottomSheet({super.key, required this.organizationName});

  @override
  State<DonationBottomSheet> createState() => _DonationBottomSheetState();
}

class _DonationBottomSheetState extends State<DonationBottomSheet> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messageController.text =
        '"Sending love & hope to everyone you\'re helping 💛."';
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrganizationDetailsController>();
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border.all(color: const Color(0xFFEBE9EC)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar and header
          _buildHeader(),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.rw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Donation Type Section
                  _buildDonationTypeSection(controller: controller),

                  16.rh.heightWidth,

                  // Causes Section
                  _buildCausesSection(controller),

                  SizedBox(height: 24.rh),

                  Obx(() {
                    return controller.selectedDonationType.value !=
                            DonationType.recurring
                        ? Column(
                            children: [
                              _selectAmountSection(controller),
                              24.rh.heightWidth,
                            ],
                          )
                        : SizedBox.shrink();
                  }),

                  // Message Section
                  _buildMessageSection(),

                  SizedBox(height: 24.rh),
                ],
              ),
            ),
          ),

          // Continue Button
          ElevatedButton(
            onPressed: () {
              context.pop();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const DateTimeSelectionBottomSheet(),
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(double.maxFinite, 56.rh),
              backgroundColor: const Color(0xFF000C0B),
              foregroundColor: Colors.white,
            ),
            child: Text('Continue'),
          ).paddingXY(X: 56.rw),
          8.rh.heightWidth,
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

  Widget _buildDonationTypeSection({
    required OrganizationDetailsController controller,
  }) {
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
                child: DonationTypeCard(
                  icon: Assets.home.coins.path,
                  title: 'Round Up',
                  type: DonationType.roundUp,
                  isSelected:
                      controller.selectedDonationType.value ==
                      DonationType.roundUp,
                ),
              ),

              SizedBox(width: 8.rw),

              Expanded(
                child: DonationTypeCard(
                  icon: Assets.home.calendar.path,
                  title: 'Recurring',
                  type: DonationType.recurring,
                  isSelected:
                      controller.selectedDonationType.value ==
                      DonationType.recurring,
                  isHighlighted: true,
                ),
              ),

              SizedBox(width: 8.rw),

              Expanded(
                child: DonationTypeCard(
                  icon: Assets.home.gift.path,
                  title: 'One Time',
                  type: DonationType.oneTime,
                  isSelected:
                      controller.selectedDonationType.value ==
                      DonationType.oneTime,
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

  Widget _buildCausesSection(OrganizationDetailsController controller) {
    final causes = ['Youth', 'Utilities', 'Emam'];

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
            children: causes.map((cause) {
              final isSelected = controller.selectedCause.value == cause;
              return CapsuleButton(
                title: cause,
                isSelected: isSelected,
                onTap: () {
                  controller.changeSelectedCause(cause);
                },
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget _selectAmountSection(OrganizationDetailsController controller) {
    return Obx(() {
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

          Wrap(
            spacing: 8.rw,
            children: controller.donationAmounts.map((e) {
              final isSelected = controller.selectedCause.value == e;
              return CapsuleButton(
                title: e,
                isSelected: isSelected,
                onTap: () {
                  controller.changeSelectedCause(e);
                },
              ).paddingB(8.rh);
            }).toList(),
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
          controller: _messageController,
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
}

enum DonationType { roundUp, recurring, oneTime }
