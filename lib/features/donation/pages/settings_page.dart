import 'dart:async';

import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/extension/context_extension.dart';
import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/cancel_recurring_donation_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/cancel_roundup_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_recurring_connection_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_roundup_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/plaid_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/settings_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/update_recurring_donation_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/update_roundup_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/round_up_settings_widgets.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/organization_controller.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/capsule_button_widget.dart';
import 'package:cresent_charge_user_app/features/payment/controllers/payment_method_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

/// Round Up Settings Page
///
/// Allows users to configure their round-up donation settings including
/// organization, bank account, threshold amounts, and custom messages
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.isRecurring, this.roundUpId});

  final bool isRecurring;
  final String? roundUpId;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final settingsCtrl = Get.put(SettingsController());
  //final getBankConnectionController = Get.put(GetRoundUpBankConnection());
  final PlaidController plaidCtrl = Get.isRegistered<PlaidController>()
      ? Get.find<PlaidController>()
      : Get.put(PlaidController());

  final OrganizationController organizationController =
      Get.find<OrganizationController>();

  final TextEditingController _orgSearchController = TextEditingController();
  Timer? _debounce;
  // One-time initialization flag to set UI from server response
  bool _initializedFromResponse = false;

  ///==========================
  /// New
  ///==========================
  /// Round-Up controllers
  // final getRoundUpConnectionController = Get.put(GetRoundUpBankConnection());
  final getRoundupController = Get.put(GetRoundupController());
  final cancelRoundupController = Get.put(CancelRoundupController());
  final updateRoundupController = Get.put(UpdateRoundupController());

  /// Recurring controllers
  final getRecurringConnectionController = Get.put(
    GetRecurringConnectionController(),
  );
  final UpdateRecurringDonationController updateRecurringDonationController =
      Get.put(UpdateRecurringDonationController());
  final CancelRecurringDonationController cancelRecurringDonationController =
      Get.put(CancelRecurringDonationController());
  final PaymentMethodController paymentMethodController =
      Get.isRegistered<PaymentMethodController>()
      ? Get.find<PaymentMethodController>()
      : Get.put(PaymentMethodController());

  // Custom frequency state
  final TextEditingController customIntervalController = TextEditingController(
    text: '1',
  );
  String customUnit = 'days';
  final List<String> unitOptions = ['days', 'weeks', 'months'];

  @override
  void initState() {
    super.initState();
    if (widget.isRecurring) {
      // Fetch recurring connections if on recurring settings page
      getRecurringConnectionController.fetchRecurringConnection();
      paymentMethodController.fetchPaymentMethods();
    }
    if (!widget.isRecurring) {
      getRoundupController.fetchRoundupConfig(widget.roundUpId);
      // getRoundUpConnectionController.fetchRoundUpBankConnection();
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _orgSearchController.dispose();
    customIntervalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    // print('Building SettingsPage, isRecurring: ${widget.isRecurring}');
    return Scaffold(
      backgroundColor: DonationConstants.backgroundColor,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
        child: Obx(() {
          if (getRoundupController.isLoading.value ||
              getRecurringConnectionController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: DonationConstants.primaryPurple,
              ),
            );
          }

          if (widget.isRecurring) {
            int recurringIndex =
                settingsCtrl.selectedRecurringConnectionIndex.value;

            if (!getRecurringConnectionController.isLoading.value &&
                getRecurringConnectionController
                    .recurringConnectionList
                    .isNotEmpty) {
              final connection = getRecurringConnectionController
                  .recurringConnectionList[recurringIndex];

              if (!_initializedFromResponse) {
                // Special message
                settingsCtrl.specialMessageController.text =
                    connection.specialMessage;

                // Threshold amount mapping
                final thresholds = settingsCtrl.thresholdAmounts;
                final customIndex = thresholds.length - 1;
                int matchIndex = thresholds.indexWhere(
                  (item) => item.values.first == connection.amount,
                );
                if (matchIndex == -1) {
                  matchIndex = customIndex;
                  settingsCtrl.customAmountController.text = connection.amount
                      .toString();
                }
                settingsCtrl.selectedAmountIndex.value = matchIndex;

                // Frequency and custom interval
                final freq = connection.frequency.toLowerCase();
                settingsCtrl.changeFrequency(freq);
                if (freq == 'custom' && connection.customInterval != null) {
                  final ci = connection.customInterval!;
                  customUnit = ci.unit;
                  customIntervalController.text = ci.value.toString();
                  settingsCtrl.changeCustomInterval(ci.unit, ci.value);
                }

                _initializedFromResponse = true;
              }
            }
          }

          /// =========If Round Up Settings===========
          if (!widget.isRecurring &&
              !getRoundupController.isLoading.value &&
              getRoundupController.roundupConfig.value != null) {
            final roundupConfig = getRoundupController.roundupConfig.value!;
            if (!_initializedFromResponse) {
              // Special message
              settingsCtrl.specialMessageController.text =
                  roundupConfig.specialMessage ?? '';

              // Threshold amount mapping
              final thresholds = settingsCtrl.thresholdAmounts;
              final customIndex = thresholds.length - 1;
              int matchIndex = thresholds.indexWhere(
                (item) => item.values.first == roundupConfig.monthlyThreshold,
              );
              if (matchIndex == -1) {
                matchIndex = customIndex;
                settingsCtrl.customAmountController.text = roundupConfig
                    .monthlyThreshold
                    .toString();
              }
              settingsCtrl.selectedAmountIndex.value = matchIndex;

              _initializedFromResponse = true;
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// If recurring, show organization field
              if (widget.isRecurring)
                _buildDropDownField(
                  label: 'Organization',
                  isTab: isTab,
                  items: getRecurringConnectionController
                      .recurringConnectionList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(e.organization.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    int index = getRecurringConnectionController
                        .recurringConnectionList
                        .indexWhere((e) => e.id == value);
                    if (index >= 0) {
                      setState(() {
                        settingsCtrl.selectedRecurringConnectionIndex.value =
                            index;
                        _initializedFromResponse =
                            false; // Reset to trigger re-initialization
                      });
                    }
                  },
                  selectedItemName:
                      getRecurringConnectionController
                          .recurringConnectionList
                          .isNotEmpty
                      ? getRecurringConnectionController
                            .recurringConnectionList[(settingsCtrl
                                            .selectedRecurringConnectionIndex
                                            .value >=
                                        0 &&
                                    settingsCtrl
                                            .selectedRecurringConnectionIndex
                                            .value <
                                        getRecurringConnectionController
                                            .recurringConnectionList
                                            .length)
                                ? settingsCtrl
                                      .selectedRecurringConnectionIndex
                                      .value
                                : 0]
                            .organization
                            .name
                      : null,
                ),

              /// If not recurring, show bank connected organization field
              if (!widget.isRecurring)
                _buildDropDownField(
                  label: "Organization",
                  isTab: isTab,
                  items: [
                    DropdownMenuItem(
                      value: getRoundupController.organizationName,
                      child: Text(getRoundupController.organizationName),
                    ),
                  ],

                  // getRoundupController
                  //     .roundupConfig.value
                  //     .map(
                  //       (e) => DropdownMenuItem(
                  //         value: e.id,
                  //         child: Text(e.roundUpDetails?.organizationName ?? ""),
                  //       ),
                  //     )
                  //     .toList(),
                  onChanged: (value) {
                    // int index = getRoundUpConnectionController
                    //     .roundUpBankConnectionModel
                    //     .indexWhere((e) => e.id == value);
                    // if (index >= 0) {
                    //   setState(() {
                    //     settingsCtrl.selectedOrganizationIndex.value = index;
                    //   });
                    // }
                  },
                  selectedItemName: getRoundupController.organizationName,
                  // getRoundUpConnectionController
                  //     .roundUpBankConnectionModel
                  //     .isNotEmpty
                  // ? getRoundUpConnectionController
                  //       .roundUpBankConnectionModel[(settingsCtrl
                  //                       .selectedOrganizationIndex
                  //                       .value >=
                  //                   0 &&
                  //               settingsCtrl
                  //                       .selectedOrganizationIndex
                  //                       .value <
                  //                   getRoundUpConnectionController
                  //                       .roundUpBankConnectionModel
                  //                       .length)
                  //           ? settingsCtrl.selectedOrganizationIndex.value
                  //           : 0]
                  //       .roundUpDetails
                  //       ?.organizationName
                  // : null,
                ),
              SizedBox(height: 16.rh),

              /// ========> Round Up Bank Account Field <========
              if (!widget.isRecurring)
                _buildDropDownField(
                  label: 'Bank Account',
                  isTab: isTab,
                  items: [
                    DropdownMenuItem(
                      value: getRoundupController.formattedCardNumber,
                      child: Text(getRoundupController.formattedCardNumber),
                    ),
                  ],
                  // getRoundUpConnectionController
                  //     .roundUpBankConnectionModel
                  //     .map(
                  //       (e) => DropdownMenuItem(
                  //         value: e.id,
                  //         child: Text(e.institutionName),
                  //       ),
                  //     )
                  //     .toList(),
                  onChanged: (value) {
                    // int index = getRoundUpConnectionController
                    //     .roundUpBankConnectionModel
                    //     .indexWhere((e) => e.id == value);
                    // if (index >= 0) {
                    //   setState(() {
                    //     settingsCtrl.selectedOrganizationIndex.value = index;
                    //   });
                    // }
                  },
                  selectedItemName: getRoundupController.formattedCardNumber,
                  // getRoundUpConnectionController
                  //     .roundUpBankConnectionModel
                  //     .isNotEmpty
                  // ? getRoundUpConnectionController
                  //       .roundUpBankConnectionModel[0]
                  //       .institutionName
                  // : null,
                ),
              if (!widget.isRecurring) SizedBox(height: 16.rh),

              /// ========> Recurring Payment Method <========
              if (widget.isRecurring)
                _buildDropDownField(
                  label: 'Payment Method',
                  isTab: isTab,
                  items: paymentMethodController.paymentMethods
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text("**** **** **** ${e.cardLast4}"),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    // Find the recurring connection that uses this payment method
                    int index = getRecurringConnectionController
                        .recurringConnectionList
                        .indexWhere((e) => e.paymentMethodId == value);
                    if (index >= 0) {
                      setState(() {
                        settingsCtrl.selectedRecurringConnectionIndex.value =
                            index;
                        _initializedFromResponse =
                            false; // Reset to trigger re-initialization
                      });
                    }
                  },
                  selectedItemName:
                      (paymentMethodController.paymentMethods.isNotEmpty &&
                          getRecurringConnectionController
                              .recurringConnectionList
                              .isNotEmpty)
                      ? () {
                          final safeIdx =
                              (settingsCtrl
                                          .selectedRecurringConnectionIndex
                                          .value >=
                                      0 &&
                                  settingsCtrl
                                          .selectedRecurringConnectionIndex
                                          .value <
                                      getRecurringConnectionController
                                          .recurringConnectionList
                                          .length)
                              ? settingsCtrl
                                    .selectedRecurringConnectionIndex
                                    .value
                              : 0;
                          final targetId = getRecurringConnectionController
                              .recurringConnectionList[safeIdx]
                              .paymentMethodId;
                          final pmList = paymentMethodController.paymentMethods;
                          final pmIndex = pmList.indexWhere(
                            (pm) => pm.id == targetId,
                          );
                          final last4 =
                              (pmIndex >= 0 ? pmList[pmIndex] : pmList.first)
                                  .cardLast4;
                          return "*** **** **** $last4";
                        }()
                      : null,
                ),

              SizedBox(height: 16.rh),

              if (widget.isRecurring) _buildFrequencySection().paddingB(16.rh),

              // Threshold Amount Selection
              _buildThresholdAmountSection(isTab),

              SizedBox(height: 16.rh),

              // Special Message
              _buildSpecialMessageSection(),

              SizedBox(height: 24.rh),

              // Cancel Donation Button
              _buildCancelDonationButton(settingsCtrl, isTab),

              SizedBox(height: 24.rh),

              // Get.size.height > 850 ? 80.rh.heightWidth : 16.rh.heightWidth,
              // Obx(() {
              //   final orgs = organizationController.organizationsList;
              //   final selIdx = settingsCtrl.selectedOrganizationIndex.value;

              //   if (orgs.isNotEmpty &&
              //       selIdx >= 0 &&
              //       selIdx < orgs.length &&
              //       orgs[selIdx].serviceType != 'recurring') {
              //     return 60.rh.heightWidth;
              //   }
              //   return SizedBox.shrink();
              // }),
              _buildBottomButtons(context, isTab),
            ],
          );
        }),
      ),
    );
  }

  /// Build app bar with back button and title
  AppBar _buildAppBar(BuildContext context) {
    bool isTab = context.isTab;
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
        widget.isRecurring ? 'Recurring Settings' : 'Round Up Settings',
        style: TextStyle(
          fontFamily: DonationFonts.familjenGrotesk,
          fontSize: isTab ? 9.sp : 20.rfs,
          fontWeight: FontWeight.bold,
          color: DonationConstants.offBlack,
          letterSpacing: -0.2,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build organization and bank account field
  Widget _buildDropDownField({
    required String label,
    required List<DropdownMenuItem<String>>? items,
    required void Function(String?)? onChanged,
    required String? selectedItemName,
    required bool isTab
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: isTab ? 8.sp : 14.rfs,
            fontWeight: FontWeight.w500,
            color: DonationConstants.offBlack,
          ),
        ),

        SizedBox(height: 8.rh),

        DropdownButtonHideUnderline(
          child: DropdownButton2(
            items: items,
            onChanged: onChanged,
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
                    child: Text(
                      selectedItemName ?? 'Select organization',
                      style: TextStyle(
                        fontFamily: DonationFonts.interDisplay,
                        fontSize: isTab ? 6.sp : 14.rfs,
                        fontWeight: FontWeight.w500,
                        color: DonationConstants.offBlack,
                      ),
                    ),
                  ),

                  Text(
                    'Change',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: const Color(
                        0xFFC08FFF,
                      ) /* Colors-Primary-Purple */,
                      fontSize: isTab ? 6.sp : 14,
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
  Widget _buildFrequencySection() {
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8.rw,
                runSpacing: 8.rh,
                children: settingsCtrl.frequency.map((freq) {
                  final isSelected =
                      settingsCtrl.selectedFrequency.value.toLowerCase() ==
                      freq.toLowerCase();

                  return CapsuleButton(
                    title: freq,
                    isSelected: isSelected,
                    onTap: () {
                      // Save lowercase in controller
                      settingsCtrl.changeFrequency(freq.toLowerCase());
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 12.rh),

              // Show custom frequency input when 'custom' selected
              if (settingsCtrl.selectedFrequency.value.toLowerCase() ==
                  'custom')
                _buildCustomFrequency(),
            ],
          );
        }),
      ],
    );
  }

  /// Build custom frequency UI with dropdown and text field
  Widget _buildCustomFrequency() {
    return Container(
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF6FF),
        borderRadius: BorderRadius.circular(12.rw),
        border: Border.all(color: const Color(0xFFE4E4E4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Frequency',
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 14.rfs,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000C0B),
            ),
          ),
          SizedBox(height: 12.rh),
          Row(
            children: [
              // Interval value text field
              Expanded(
                flex: 2,
                child: TextField(
                  controller: customIntervalController,
                  onChanged: (value) => settingsCtrl.changeCustomInterval(
                    customUnit,
                    int.tryParse(value) ?? 1,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter number',
                    hintStyle: TextStyle(
                      fontSize: 14.rfs,
                      color: const Color(0xFFB3B3B3),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.rw),
                      borderSide: const BorderSide(color: Color(0xFFE4E4E4)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.rw,
                      vertical: 12.rh,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.rw),
              // Unit dropdown
              Expanded(
                flex: 2,
                child: DropdownButton2<String>(
                  value: customUnit,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        customUnit = value;
                      });
                      // Keep controller in sync when unit changes
                      settingsCtrl.changeCustomInterval(
                        customUnit,
                        int.tryParse(customIntervalController.text.trim()) ?? 1,
                      );
                    }
                  },
                  items: unitOptions
                      .map(
                        (unit) => DropdownMenuItem<String>(
                          value: unit,
                          child: Text(
                            unit,
                            style: TextStyle(
                              fontSize: 14.rfs,
                              color: const Color(0xFF000C0B),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  buttonStyleData: ButtonStyleData(
                    height: 48.rh,
                    padding: EdgeInsets.symmetric(horizontal: 12.rw),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.rw),
                      border: Border.all(color: const Color(0xFFE4E4E4)),
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200.rh,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.rw),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build threshold amount selection section
  Widget _buildThresholdAmountSection(bool isTab) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Threshold Amount (Per Month)',
          style: TextStyle(
            fontFamily: DonationFonts.interDisplay,
            fontSize: isTab ? 8.sp : 14.rfs,
            fontWeight: FontWeight.w500,
            color: DonationConstants.offBlack,
          ),
        ),

        SizedBox(height: 8.rh),

        Obx(() {
          final thresholds = settingsCtrl.thresholdAmounts;
          return Wrap(
            spacing: 8.rw,
            runSpacing: 8.rh,
            children: thresholds.asMap().entries.map((entry) {
              final idx = entry.key;
              final label = entry.value.keys.first;
              final isSelected = settingsCtrl.selectedAmountIndex.value == idx;

              return CapsuleButton(
                title: label,
                isSelected: isSelected,
                onTap: () {
                  settingsCtrl.selectedAmountIndex.value = idx;
                },
              );
            }).toList(),
          );
        }),

        Obx(() {
          final thresholds = settingsCtrl.thresholdAmounts;
          if (thresholds.isEmpty) return SizedBox.shrink();

          final customIndex = thresholds.length - 1;
          final isCustomSelected =
              settingsCtrl.selectedAmountIndex.value == customIndex;
          if (!isCustomSelected) return SizedBox.shrink();

          return Padding(
            padding: EdgeInsets.only(top: 12.rh),
            child: TextField(
              controller: settingsCtrl.customAmountController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: isTab ? 6.sp : null),
              decoration: InputDecoration(
                labelText: 'Enter custom amount',
                labelStyle: TextStyle(fontSize: isTab ? 8.sp : null),
                hintText: 'e.g., 75',
                hintStyle: TextStyle(fontSize: isTab ? 6.sp : null),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.rw,
                  vertical: 12.rh,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.rw),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  /// Build special message section
  Widget _buildSpecialMessageSection() {
    return SpecialMessageField(
      controller: settingsCtrl.specialMessageController,
    );
  }

  /// Build cancel donation button
  Widget _buildCancelDonationButton(SettingsController controller, bool isTab) {
    return Obx(() {
      final isLoading =
          cancelRecurringDonationController.isLoading.value ||
          cancelRoundupController.isLoading.value;

      return GestureDetector(
        onTap: isLoading ? null : () => _handleCancelDonation(),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: isLoading
              ? SizedBox(
                  width: 16.rw,
                  height: 16.rh,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color(0xFFF0323C),
                    ),
                  ),
                )
              : Text(
                  'Cancel this donation',
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: isTab ? 6.sp : 14.rfs,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFF0323C),
                  ),
                ),
        ),
      );
    });
  }

  /// Build bottom action buttons
  Widget _buildBottomButtons(BuildContext context, bool isTab) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 56.rw, vertical: 16.rh),
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Save Button
          ElevatedButton(
            onPressed: () => widget.isRecurring
                ? _handleRecurringUpdateSettings()
                : _handleRoundupUpdateSettings(),
            style: ElevatedButton.styleFrom(
              fixedSize:  Size(double.maxFinite, isTab ? 70 : 52),
              backgroundColor: DonationConstants.secondaryLime,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.rw),
              ),
              elevation: 0,
            ),
            child: Text(
              'Update Settings',
              style: TextStyle(
                fontFamily: DonationFonts.familjenGrotesk,
                fontSize: isTab ? 7.sp : 18.rfs,
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
                fontSize: isTab ? 6.sp : 14.rfs,
                fontWeight: FontWeight.w600,
                color: DonationConstants.offBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleCancelDonation() async {
    if (widget.isRecurring &&
        getRecurringConnectionController.recurringConnectionList.isEmpty) {
      ToastMsg.error('No recurring donation found');
      return;
    }

    if (!widget.isRecurring &&
        getRoundupController.roundupConfig.value == null) {
      ToastMsg.error('No round-up donation found');
      return;
    }

    // Get the appropriate donation ID based on type
    String? donationId;
    if (widget.isRecurring) {
      final recurringIndex =
          settingsCtrl.selectedRecurringConnectionIndex.value;
      if (recurringIndex >= 0 &&
          recurringIndex <
              getRecurringConnectionController.recurringConnectionList.length) {
        donationId = getRecurringConnectionController
            .recurringConnectionList[recurringIndex]
            .id;
      }
    } else {
      donationId = getRoundupController.roundupConfig.value?.id;
    }

    if (donationId == null) {
      ToastMsg.error('Unable to find donation ID');
      return;
    }

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Cancel ${widget.isRecurring ? "Recurring" : "Round-up"} Donation',
            style: TextStyle(
              fontFamily: DonationFonts.familjenGrotesk,
              fontSize: 18.rfs,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to cancel this ${widget.isRecurring ? "recurring" : "round-up"} donation? This action cannot be undone.',
            style: TextStyle(
              fontFamily: DonationFonts.interDisplay,
              fontSize: 14.rfs,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'No, Keep It',
                style: TextStyle(
                  fontFamily: DonationFonts.interDisplay,
                  fontSize: 14.rfs,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'Yes, Cancel',
                style: TextStyle(
                  fontFamily: DonationFonts.interDisplay,
                  fontSize: 14.rfs,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFF0323C),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    // Call the cancel method
    final success = widget.isRecurring
        ? await cancelRecurringDonationController.cancelRecurringDonation(
            donationId,
          )
        : await cancelRoundupController.cancelRoundupConfig(
            roundupId: donationId,
            reason: "Cancelled by user",
          );

    if (success && mounted) {
      ToastMsg.success(
        '${widget.isRecurring ? "Recurring" : "Round-up"} donation cancelled successfully',
      );
      // Refresh the list
      if (widget.isRecurring) {
        await getRecurringConnectionController.fetchRecurringConnection();
      } else {
        await getRoundupController.fetchRoundupConfig(widget.roundUpId);
      }
      // Go back
      context.pop();
    }
  }

  Future<void> _handleRecurringUpdateSettings() async {
    final thresholds = settingsCtrl.thresholdAmounts;
    if (thresholds.isEmpty) {
      ToastMsg.error('Please select a threshold amount');
      return;
    }

    final customIndex = thresholds.length - 1;
    final selectedIdx = settingsCtrl.selectedAmountIndex.value;
    final bool isCustomSelected = selectedIdx == customIndex;

    double? amount;
    if (isCustomSelected) {
      final custom = settingsCtrl.customAmountController.text.trim();
      amount = double.tryParse(custom);
    } else if (selectedIdx >= 0 && selectedIdx < thresholds.length) {
      amount = thresholds[selectedIdx].values.first;
    }

    if (amount == null || amount <= 0) {
      ToastMsg.error('Please enter a valid amount');
      return;
    }

    final freq = settingsCtrl.selectedFrequency.value.isNotEmpty
        ? settingsCtrl.selectedFrequency.value.toLowerCase()
        : 'daily';
    final specialMessage = settingsCtrl.specialMessageController.text.trim();

    Map<String, dynamic>? customInterval;
    if (freq == 'custom') {
      final intervalValue =
          int.tryParse(
            settingsCtrl.customInterval['value']?.toString() ?? '',
          ) ??
          int.tryParse(customIntervalController.text.trim()) ??
          0;
      final intervalUnit = (settingsCtrl.customInterval['unit'] ?? customUnit)
          .toString();

      if (intervalValue <= 0 || intervalUnit.isEmpty) {
        ToastMsg.error('Please enter a valid custom interval');
        return;
      }

      customInterval = {'unit': intervalUnit, 'value': intervalValue};
    }

    if (widget.isRecurring) {
      final success = await updateRecurringDonationController
          .updateRecurringDonation(
            recurringDonationId: getRecurringConnectionController
                .recurringConnectionList[settingsCtrl
                    .selectedRecurringConnectionIndex
                    .value]
                .id,
            amount: amount,
            frequency: freq,
            specialMessage: specialMessage,
            customInterval: customInterval,
          );

      if (success && mounted) {
        context.pop();
      }
    }
  }

  Future<void> _handleRoundupUpdateSettings() async {
    final thresholds = settingsCtrl.thresholdAmounts;
    if (thresholds.isEmpty) {
      ToastMsg.error('Please select a threshold amount');
      return;
    }

    final customIndex = thresholds.length - 1;
    final selectedIdx = settingsCtrl.selectedAmountIndex.value;
    final bool isCustomSelected = selectedIdx == customIndex;

    double? amount;
    if (isCustomSelected) {
      final custom = settingsCtrl.customAmountController.text.trim();
      amount = double.tryParse(custom);
    } else if (selectedIdx >= 0 && selectedIdx < thresholds.length) {
      amount = thresholds[selectedIdx].values.first;
    }

    if (amount == null || amount <= 0) {
      ToastMsg.error('Please enter a valid amount');
      return;
    }

    final specialMessage = settingsCtrl.specialMessageController.text.trim();

    final success = await updateRoundupController.updateRoundupConfig(
      roundupId: getRoundupController.roundupConfig.value?.id ?? '',
      specialMessage: specialMessage,
      monthlyThreshold: amount,
    );

    if (success && mounted) {
      context.pop();
    }
  }
}