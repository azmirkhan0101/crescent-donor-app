import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/round_up_settings_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/round_up_settings_widgets.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/capsule_button_widget.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// Round Up Settings Page
///
/// Allows users to configure their round-up donation settings including
/// organization, bank account, threshold amounts, and custom messages
class RoundUpSettingsPage extends StatelessWidget {
  const RoundUpSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RoundUpSettingsController());
    print(Get.size.height);

    return Scaffold(
      backgroundColor: DonationConstants.backgroundColor,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrganizationField(controller),

            SizedBox(height: 16.rh),

            // Bank Account Link
            _buildBankAccountField(controller),

            SizedBox(height: 16.rh),

            // Frequency Selection
            Obx(() {
              if (controller
                  .organizations[controller.selectedOrganizationIndex.value]
                  .frequency) {
                return _buildFrequencySection(controller).paddingB(16.rh);
              }
              return SizedBox.shrink();
            }),

            // Threshold Amount Selection
            _buildThresholdAmountSection(controller),

            SizedBox(height: 16.rh),

            // Special Message
            _buildSpecialMessageSection(controller),

            SizedBox(height: 24.rh),

            // Cancel Donation Button
            _buildCancelDonationButton(controller),

            Get.size.height > 850 ? 80.rh.heightWidth : 16.rh.heightWidth,

            Obx(() {
              if (!controller
                  .organizations[controller.selectedOrganizationIndex.value]
                  .frequency) {
                return 60.rh.heightWidth;
              }
              return SizedBox.shrink();
            }),

            _buildBottomButtons(controller, context),
          ],
        ),
      ),
    );
  }

  /// Build app bar with back button and title
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: DonationConstants.backgroundColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: Container(
          padding: EdgeInsets.all(12.rw),
          child: SvgPicture.asset(
            Assets.common.arrowLeft.path,
            width: 20.rw,
            height: 20.rh,
          ),
        ),
      ),
      title: Text(
        'Round Up Settings',
        style: TextStyle(
          fontFamily: DonationFonts.familjenGrotesk,
          fontSize: 20.rfs,
          fontWeight: FontWeight.bold,
          color: DonationConstants.offBlack,
          letterSpacing: -0.2,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build organization selection field
  Widget _buildOrganizationField(RoundUpSettingsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Organization',
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: 14.rfs,
            fontWeight: FontWeight.w500,
            color: DonationConstants.offBlack,
          ),
        ),

        SizedBox(height: 8.rh),

        DropdownButtonHideUnderline(
          child: DropdownButton2(
            items: controller.organizations
                .map(
                  (e) => DropdownMenuItem(value: e.name, child: Text(e.name)),
                )
                .toList(),
            onChanged: (value) {
              int index = controller.organizations.indexWhere(
                (e) => e.name == value,
              );
              controller.changeOrganization(index);
            },
            customButton: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.rw),
                border: Border.all(color: const Color(0xFFE4E4E4), width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      return Text(
                        controller
                            .organizations[controller
                                .selectedOrganizationIndex
                                .value]
                            .name,
                        style: TextStyle(
                          fontFamily: DonationFonts.interDisplay,
                          fontSize: 14.rfs,
                          fontWeight: FontWeight.w500,
                          color: DonationConstants.offBlack,
                        ),
                      );
                    }),
                  ),

                  Text(
                    'Change',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: const Color(
                        0xFFC08FFF,
                      ) /* Colors-Primary-Purple */,
                      fontSize: 14,
                      fontFamily: 'Inter Display',
                      fontWeight: FontWeight.w500,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build bank account field
  Widget _buildBankAccountField(RoundUpSettingsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bank Account Link',
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: 14.rfs,
            fontWeight: FontWeight.w500,
            color: DonationConstants.offBlack,
          ),
        ),

        SizedBox(height: 8.rh),

        DropdownButtonHideUnderline(
          child: DropdownButton2(
            items: controller.organizations
                .map(
                  (e) => DropdownMenuItem(
                    value: e.bankAccount,
                    child: Text(e.bankAccount),
                  ),
                )
                .toList(),

            onChanged: (value) {
              int index = controller.organizations.indexWhere(
                (e) => e.bankAccount == value,
              );
              controller.changeBankAccount(index);
            },
            customButton: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.rw),
                border: Border.all(color: const Color(0xFFE4E4E4), width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() {
                      return Text(
                        controller
                            .organizations[controller
                                .selectedBankAccountIndex
                                .value]
                            .bankAccount,
                        style: TextStyle(
                          fontFamily: DonationFonts.interDisplay,
                          fontSize: 14.rfs,
                          fontWeight: FontWeight.w500,
                          color: DonationConstants.offBlack,
                        ),
                      );
                    }),
                  ),

                  Text(
                    'Change',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: const Color(
                        0xFFC08FFF,
                      ) /* Colors-Primary-Purple */,
                      fontSize: 14,
                      fontFamily: 'Inter Display',
                      fontWeight: FontWeight.w500,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build frequency selection section
  Widget _buildFrequencySection(RoundUpSettingsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Frequency',
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: 14.rfs,
            fontWeight: FontWeight.w500,
            color: DonationConstants.offBlack,
          ),
        ),

        SizedBox(height: 8.rh),

        Obx(() {
          return Wrap(
            spacing: 8.rw,
            runSpacing: 8.rh,
            children: controller.frequency.map((frequency) {
              final isSelected =
                  controller.selectedFrequencyIndex.value == frequency;

              return CapsuleButton(
                title: frequency,
                isSelected: isSelected,
                onTap: () {
                  controller.changeFrequency(frequency);
                },
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  /// Build threshold amount selection section
  Widget _buildThresholdAmountSection(RoundUpSettingsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Threshold Amount (Per Month)',
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: 14.rfs,
            fontWeight: FontWeight.w500,
            color: DonationConstants.offBlack,
          ),
        ),

        SizedBox(height: 8.rh),

        Obx(() {
          return Wrap(
            spacing: 8.rw,
            runSpacing: 8.rh,
            children: controller.amounts.map((amount) {
              final isSelected = controller.selectedAmountIndex.value == amount;

              return CapsuleButton(
                title: amount,
                isSelected: isSelected,
                onTap: () {
                  controller.changeAmount(amount);
                },
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  /// Build special message section
  Widget _buildSpecialMessageSection(RoundUpSettingsController controller) {
    return SpecialMessageField(message: "", onMessageChanged: (message) {});
  }

  /// Build cancel donation button
  Widget _buildCancelDonationButton(RoundUpSettingsController controller) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          'Cancel this donation',
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: 14.rfs,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFF0323C),
          ),
        ),
      ),
    );
  }

  /// Build bottom action buttons
  Widget _buildBottomButtons(
    RoundUpSettingsController controller,
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 56.rw, vertical: 16.rh),
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Save Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.maxFinite, 52),
              backgroundColor: DonationConstants.secondaryLime,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.rw),
              ),
              elevation: 0,
            ),
            child: Text(
              'Save',
              style: TextStyle(
                fontFamily: DonationFonts.familjenGrotesk,
                fontSize: 18.rfs,
                fontWeight: FontWeight.bold,
                color: DonationConstants.offBlack,
                letterSpacing: -0.36,
              ),
            ),
          ),

          SizedBox(height: 16.rh),

          // Cancel Button
          GestureDetector(
            onTap: () => context.pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: DonationFonts.interDisplay,
                fontSize: 14.rfs,
                fontWeight: FontWeight.w600,
                color: DonationConstants.offBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
