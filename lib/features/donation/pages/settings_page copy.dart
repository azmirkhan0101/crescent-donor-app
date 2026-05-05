// import 'dart:async';

// import 'package:donor/core/custom_assets/assets.gen.dart';
// import 'package:donor/core/helper/extension/base_extension.dart';
// import 'package:donor/core/helper/tost_message/toast_message.dart';
// import 'package:donor/features/donation/controllers/get_round_up_bank_connection_controller.dart';
// import 'package:donor/features/donation/controllers/plaid_controller.dart';
// import 'package:donor/features/donation/controllers/settings_controller.dart';
// import 'package:donor/features/donation/utils/donation_constants.dart';
// import 'package:donor/features/donation/widgets/round_up_settings_widgets.dart';
// import 'package:donor/features/organization/controllers/organization_controller.dart';
// import 'package:donor/features/organization/widgets/capsule_button_widget.dart';
// import 'package:donor/features/payment/controllers/payment_method_controller.dart';
// import 'package:donor/utils/sizer/sizer.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// /// Round Up Settings Page
// ///
// /// Allows users to configure their round-up donation settings including
// /// organization, bank account, threshold amounts, and custom messages
// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key, required this.isRecurring});

//   final bool isRecurring;

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   final roundUpSettingsCtrl = Get.put(SettingsController());
//   final getBankConnectionController = Get.put(GetRoundUpBankConnection());
//   final PlaidController plaidCtrl = Get.isRegistered<PlaidController>()
//       ? Get.find<PlaidController>()
//       : Get.put(PlaidController());
//   final PaymentMethodController paymentMethodController =
//       Get.isRegistered<PaymentMethodController>()
//       ? Get.find<PaymentMethodController>()
//       : Get.put(PaymentMethodController());

//   final OrganizationController organizationController =
//       Get.find<OrganizationController>();

//   final TextEditingController _orgSearchController = TextEditingController();
//   Timer? _debounce;

//   @override
//   void initState() {
//     super.initState();
//     // Set up callback to refresh bank accounts after successful link
//     plaidCtrl.onSuccessCallback = (event) {
//       getBankConnectionController.fetchRoundUpBankConnection();
//     };
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     _orgSearchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: DonationConstants.backgroundColor,
//       appBar: _buildAppBar(context),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
//         child: GetX<GetRoundUpBankConnection>(
//           initState: (state) {
//             state.controller?.fetchRoundUpBankConnection();
//           },
//           builder: (controller) {
//             if (controller.isLoading.value) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   color: DonationConstants.primaryPurple,
//                 ),
//               );
//             }

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // _buildOrganizationField(roundUpSettingsCtrl),
//                 _buildRoundUpFieldField(
//                   controller: controller,
//                   label: 'Organization',
//                   isOrg: true,
//                 ),

//                 SizedBox(height: 16.rh),

//                 // Bank Account Link
//                 _buildRoundUpFieldField(
//                   controller: controller,
//                   label: 'Bank Account Link',
//                   isOrg: false,
//                 ),

//                 SizedBox(height: 16.rh),

//                 // // Frequency Selection
//                 // Obx(() {
//                 //   final orgs = organizationController.organizationsList;
//                 //   final selectedIndex =
//                 //       roundUpSettingsCtrl.selectedOrganizationIndex.value;

//                 //   if (orgs.isNotEmpty &&
//                 //       selectedIndex >= 0 &&
//                 //       selectedIndex < orgs.length &&
//                 //       orgs[selectedIndex].serviceType == 'recurring') {
//                 //     return _buildFrequencySection(
//                 //       roundUpSettingsCtrl,
//                 //     ).paddingB(16.rh);
//                 //   }
//                 //   return SizedBox.shrink();
//                 // }),

//                 // Threshold Amount Selection
//                 _buildThresholdAmountSection(roundUpSettingsCtrl),

//                 SizedBox(height: 16.rh),

//                 // Special Message
//                 _buildSpecialMessageSection(roundUpSettingsCtrl),

//                 SizedBox(height: 24.rh),

//                 // Cancel Donation Button
//                 _buildCancelDonationButton(roundUpSettingsCtrl),

//                 Get.size.height > 850 ? 80.rh.heightWidth : 16.rh.heightWidth,

//                 Obx(() {
//                   final orgs = organizationController.organizationsList;
//                   final selIdx =
//                       roundUpSettingsCtrl.selectedOrganizationIndex.value;

//                   if (orgs.isNotEmpty &&
//                       selIdx >= 0 &&
//                       selIdx < orgs.length &&
//                       orgs[selIdx].serviceType != 'recurring') {
//                     return 60.rh.heightWidth;
//                   }
//                   return SizedBox.shrink();
//                 }),

//                 _buildBottomButtons(roundUpSettingsCtrl, context),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   /// Build app bar with back button and title
//   AppBar _buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: DonationConstants.backgroundColor,
//       elevation: 0,
//       leading: IconButton(
//         onPressed: () => context.pop(),
//         icon: Container(
//           padding: EdgeInsets.all(12.rw),
//           child: SvgPicture.asset(
//             Assets.common.arrowLeft.path,
//             width: 20.rw,
//             height: 20.rh,
//           ),
//         ),
//       ),
//       title: Text(
//         'Round Up Settings',
//         style: TextStyle(
//           fontFamily: DonationFonts.familjenGrotesk,
//           fontSize: 20.rfs,
//           fontWeight: FontWeight.bold,
//           color: DonationConstants.offBlack,
//           letterSpacing: -0.2,
//         ),
//       ),
//       centerTitle: true,
//       actions: [
//         const SizedBox(width: 48), // Placeholder for symmetry
//         Obx(() {
//           return Skeletonizer(
//             enabled:
//                 plaidCtrl.isLoadingConfiguration.value ||
//                 plaidCtrl.createPlaidTokenCtrl.isLinkTokenLoading,
//             child: IconButton(
//               onPressed: () => plaidCtrl.createLinkTokenConfiguration(),
//               icon: Icon(Icons.add),
//             ),
//           );
//         }),
//       ],
//     );
//   }

//   /// Build organization and bank account field
//   Widget _buildRoundUpFieldField({
//     required GetRoundUpBankConnection controller,
//     required String label,
//     bool isOrg = false,
//   }) {
//     List<DropdownMenuItem<String>>? items() {
//       if (controller.roundUpBankConnectionModel.isEmpty) {
//         return [
//           DropdownMenuItem<String>(
//             value: null,
//             child: Text(
//               isOrg ? 'No linked organizations' : 'No linked accounts',
//             ),
//           ),
//         ];
//       } else {
//         if (isOrg) {
//           // Filter for accounts with active round-up organization details
//           final orgsWithRoundUp = controller.roundUpBankConnectionModel
//               .where(
//                 (e) =>
//                     e.isLinkedToActiveRoundUp &&
//                     e.roundUpDetails?.organizationName != null,
//               )
//               .toList();

//           if (orgsWithRoundUp.isEmpty) {
//             return [
//               DropdownMenuItem<String>(
//                 value: null,
//                 child: Text('No linked organizations'),
//               ),
//             ];
//           }

//           return orgsWithRoundUp
//               .map(
//                 (e) => DropdownMenuItem(
//                   value: e.roundUpDetails!.organizationName,
//                   child: Text(e.roundUpDetails!.organizationName),
//                 ),
//               )
//               .toList();
//         } else {
//           return controller.roundUpBankConnectionModel
//               .map(
//                 (e) => DropdownMenuItem(
//                   value: e.institutionName,
//                   child: Text(e.institutionName),
//                 ),
//               )
//               .toList();
//         }
//       }
//     }

//     return GetX<SettingsController>(
//       builder: (roundUpSettingsCtrl) {
//         final roundUpModelList = controller.roundUpBankConnectionModel;
//         final selectedIndex =
//             roundUpSettingsCtrl.selectedRoundUpModelIndex.value;

//         String displayText;
//         if (roundUpModelList.isEmpty) {
//           displayText = isOrg
//               ? 'No linked organizations'
//               : 'No linked accounts';
//         } else if (selectedIndex >= 0 &&
//             selectedIndex < roundUpModelList.length) {
//           if (isOrg) {
//             displayText =
//                 roundUpModelList[selectedIndex]
//                     .roundUpDetails
//                     ?.organizationName ??
//                 'Select organization';
//           } else {
//             displayText = roundUpModelList[selectedIndex].institutionName;
//           }
//         } else {
//           displayText = isOrg ? 'Select organization' : 'Select account';
//         }
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 fontFamily: DonationFonts.interDisplay,
//                 fontSize: 14.rfs,
//                 fontWeight: FontWeight.w500,
//                 color: DonationConstants.offBlack,
//               ),
//             ),

//             SizedBox(height: 8.rh),

//             DropdownButtonHideUnderline(
//               child: DropdownButton2(
//                 items: items() as List<DropdownMenuItem<Object>>?,
//                 onChanged: (value) {
//                   if (controller.roundUpBankConnectionModel.isEmpty ||
//                       value == null) {
//                     return;
//                   }
//                   int index;
//                   if (isOrg) {
//                     // Find by organization name in roundUpDetails
//                     index = controller.roundUpBankConnectionModel.indexWhere(
//                       (e) => e.roundUpDetails?.organizationName == value,
//                     );
//                   } else {
//                     // Find by institution name
//                     index = controller.roundUpBankConnectionModel.indexWhere(
//                       (e) => e.institutionName == value,
//                     );
//                   }

//                   // Only change if a valid index is found
//                   if (index >= 0) {
//                     roundUpSettingsCtrl.changeRoundUpModelIndex(index);
//                   }
//                 },
//                 customButton: Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 16.rw,
//                     vertical: 16.rh,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12.rw),
//                     border: Border.all(
//                       color: const Color(0xFFE4E4E4),
//                       width: 1,
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           displayText,
//                           style: TextStyle(
//                             fontFamily: DonationFonts.interDisplay,
//                             fontSize: 14.rfs,
//                             fontWeight: FontWeight.w500,
//                             color: DonationConstants.offBlack,
//                           ),
//                         ),
//                       ),

//                       Text(
//                         'Change',
//                         textAlign: TextAlign.right,
//                         style: TextStyle(
//                           color: const Color(
//                             0xFFC08FFF,
//                           ) /* Colors-Primary-Purple */,
//                           fontSize: 14,
//                           fontFamily: 'Inter Display',
//                           fontWeight: FontWeight.w500,
//                           height: 1.43,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   /// Build threshold amount selection section
//   Widget _buildThresholdAmountSection(SettingsController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select Threshold Amount (Per Month)',
//           style: TextStyle(
//             fontFamily: DonationFonts.interDisplay,
//             fontSize: 14.rfs,
//             fontWeight: FontWeight.w500,
//             color: DonationConstants.offBlack,
//           ),
//         ),

//         SizedBox(height: 8.rh),

//         Obx(() {
//           return Wrap(
//             spacing: 8.rw,
//             runSpacing: 8.rh,
//             children: controller.amounts.map((amount) {
//               final isSelected = controller.selectedAmount.value == amount;

//               return CapsuleButton(
//                 title: amount,
//                 isSelected: isSelected,
//                 onTap: () {
//                   controller.changeAmount(amount);
//                 },
//               );
//             }).toList(),
//           );
//         }),

//         Obx(() {
//           final isCustomSelected = controller.selectedAmount.value == 'Custom';
//           if (!isCustomSelected) return SizedBox.shrink();

//           return Padding(
//             padding: EdgeInsets.only(top: 12.rh),
//             child: TextField(
//               controller: controller.customAmountController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Enter custom amount',
//                 hintText: 'e.g., 75',
//                 contentPadding: EdgeInsets.symmetric(
//                   horizontal: 12.rw,
//                   vertical: 12.rh,
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12.rw),
//                 ),
//               ),
//             ),
//           );
//         }),
//       ],
//     );
//   }

//   /// Build special message section
//   Widget _buildSpecialMessageSection(SettingsController controller) {
//     return SpecialMessageField(
//       message: '',
//       controller: controller.specialMessageController,
//       onMessageChanged: (message) {},
//     );
//   }

//   /// Build cancel donation button
//   Widget _buildCancelDonationButton(SettingsController controller) {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         width: double.infinity,
//         alignment: Alignment.center,
//         child: Text(
//           'Cancel this donation',
//           style: TextStyle(
//             fontFamily: DonationFonts.interDisplay,
//             fontSize: 14.rfs,
//             fontWeight: FontWeight.w500,
//             color: const Color(0xFFF0323C),
//           ),
//         ),
//       ),
//     );
//   }

//   /// Build bottom action buttons
//   Widget _buildBottomButtons(
//     SettingsController controller,
//     BuildContext context,
//   ) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 56.rw, vertical: 16.rh),
//       color: Colors.transparent,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Save Button
//           ElevatedButton(
//             onPressed: () => _handleSave(),
//             style: ElevatedButton.styleFrom(
//               fixedSize: const Size(double.maxFinite, 52),
//               backgroundColor: DonationConstants.secondaryLime,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.rw),
//               ),
//               elevation: 0,
//             ),
//             child: Text(
//               'Save',
//               style: TextStyle(
//                 fontFamily: DonationFonts.familjenGrotesk,
//                 fontSize: 18.rfs,
//                 fontWeight: FontWeight.bold,
//                 color: DonationConstants.offBlack,
//                 letterSpacing: -0.36,
//               ),
//             ),
//           ),

//           SizedBox(height: 16.rh),

//           // Cancel Button
//           GestureDetector(
//             onTap: () => context.pop(),
//             child: Text(
//               'Cancel',
//               style: TextStyle(
//                 fontFamily: DonationFonts.interDisplay,
//                 fontSize: 14.rfs,
//                 fontWeight: FontWeight.w600,
//                 color: DonationConstants.offBlack,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _handleSave() async {
//     if (roundUpSettingsCtrl.isSavingConsent.value) return;

//     final orgs = organizationController.organizationsList;
//     if (orgs.isEmpty) {
//       ToastMsg.error('Please select an organization');
//       return;
//     }

//     int orgIndex = roundUpSettingsCtrl.selectedOrganizationIndex.value;
//     if (orgIndex < 0 || orgIndex >= orgs.length) {
//       orgIndex = 0;
//     }
//     final organization = orgs[orgIndex];

//     final banks = getBankConnectionController.roundUpBankConnectionModel;
//     if (banks.isEmpty) {
//       ToastMsg.error('Please link a bank account');
//       return;
//     }

//     int bankIndex = roundUpSettingsCtrl.selectedRoundUpModelIndex.value;
//     if (bankIndex < 0 || bankIndex >= banks.length) {
//       bankIndex = 0;
//     }
//     final bank = banks[bankIndex];

//     final paymentMethods = paymentMethodController.paymentMethods;
//     if (paymentMethods.isEmpty) {
//       ToastMsg.error('Please add a payment method');
//       return;
//     }

//     final paymentMethod = paymentMethods.firstWhere(
//       (method) => method.isDefault,
//       orElse: () => paymentMethods.first,
//     );

//     final selectedAmount = roundUpSettingsCtrl.selectedAmount.value;
//     double? monthlyThreshold;

//     if (selectedAmount == 'Custom') {
//       final custom = roundUpSettingsCtrl.customAmountController.text.trim();
//       monthlyThreshold = double.tryParse(custom);
//     } else if (selectedAmount == 'No Limit') {
//       monthlyThreshold = 0;
//     } else {
//       monthlyThreshold = double.tryParse(
//         selectedAmount.replaceAll(RegExp(r'[^0-9.]'), ''),
//       );
//     }

//     if (monthlyThreshold == null ||
//         (selectedAmount != 'No Limit' && monthlyThreshold <= 0)) {
//       ToastMsg.error('Please enter a valid threshold amount');
//       return;
//     }

//     final specialMessage = roundUpSettingsCtrl.specialMessageController.text
//         .trim();

//     final success = await roundUpSettingsCtrl.saveRoundUpConsent(
//       bankConnectionId: bank.id,
//       organizationId: organization.id,
//       paymentMethodId: paymentMethod.id,
//       monthlyThreshold: monthlyThreshold,
//       specialMessage: specialMessage.isEmpty ? null : specialMessage,
//     );

//     if (success) {
//       ToastMsg.success('Round up settings saved');
//       if (mounted) {
//         context.pop();
//       }
//     } else {
//       final error = roundUpSettingsCtrl.saveConsentError.value;
//       ToastMsg.error(error.isNotEmpty ? error : 'Failed to save settings');
//     }
//   }

//   /// ===================> Unused Methods <==================
//   /// Build frequency selection section
//   Widget _buildFrequencySection(SettingsController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Select Frequency',
//           style: TextStyle(
//             fontFamily: DonationFonts.interDisplay,
//             fontSize: 14.rfs,
//             fontWeight: FontWeight.w500,
//             color: DonationConstants.offBlack,
//           ),
//         ),

//         SizedBox(height: 8.rh),

//         Obx(() {
//           return Wrap(
//             spacing: 8.rw,
//             runSpacing: 8.rh,
//             children: controller.frequency.map((frequency) {
//               final isSelected =
//                   controller.selectedFrequency.value == frequency;

//               return CapsuleButton(
//                 title: frequency,
//                 isSelected: isSelected,
//                 onTap: () {
//                   controller.changeFrequency(frequency);
//                 },
//               );
//             }).toList(),
//           );
//         }),
//       ],
//     );
//   }

//   ///
//   Widget _buildOrganizationField(SettingsController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Organization',
//           style: TextStyle(
//             fontFamily: DonationFonts.interDisplay,
//             fontSize: 14.rfs,
//             fontWeight: FontWeight.w500,
//             color: DonationConstants.offBlack,
//           ),
//         ),

//         SizedBox(height: 8.rh),

//         // TextField(
//         //   controller: TextEditingController(),
//         //   decoration: InputDecoration(
//         //     hintText: 'Search Organization',
//         //     contentPadding: EdgeInsets.symmetric(
//         //       horizontal: 16.rw,
//         //       vertical: 16.rh,
//         //     ),
//         //   ),
//         //   onChanged: (value) async {
//         //     await organizationController.fetchAllOrganizations(
//         //       searchTerm: value,
//         //     );
//         //   },
//         // ),
//         // GetX<OrganizationController>(
//         //   builder: (orgCtrl) {
//         //     final orgs = orgCtrl.organizationsList;
//         //     if (orgs.isEmpty) {
//         //       return SizedBox(
//         //         height: 64.rh,
//         //         child: Center(
//         //           child: Text(
//         //             'No organizations found',
//         //             style: TextStyle(color: DonationConstants.offBlack),
//         //           ),
//         //         ),
//         //       );
//         //     }

//         //     return ListView.builder(
//         //       shrinkWrap: true,
//         //       physics: const NeverScrollableScrollPhysics(),
//         //       itemCount: orgs.length,
//         //       itemBuilder: (context, index) {
//         //         final organization = orgs[index];
//         //         return ListTile(title: Text(organization.name), onTap: () {});
//         //       },
//         //     );
//         //   },
//         // ),
//         // SizedBox(height: 8.rh),
//         DropdownButtonHideUnderline(
//           child: DropdownButton2(
//             isExpanded: true,
//             items: organizationController.organizationsList
//                 .map(
//                   (e) => DropdownMenuItem(value: e.name, child: Text(e.name)),
//                 )
//                 .toList(),
//             dropdownSearchData: DropdownSearchData(
//               searchController: _orgSearchController,
//               searchInnerWidgetHeight: 50,
//               searchInnerWidget: Container(
//                 height: 50,
//                 padding: EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8),
//                 child: TextFormField(
//                   controller: _orgSearchController,
//                   decoration: InputDecoration(
//                     isDense: true,
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 8,
//                     ),
//                     hintText: 'Search organization...',
//                     hintStyle: TextStyle(fontSize: 12),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     if (_debounce?.isActive ?? false) _debounce!.cancel();
//                     _debounce = Timer(
//                       const Duration(milliseconds: 500),
//                       () async {
//                         await organizationController.fetchAllOrganizations(
//                           searchTerm: value,
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               searchMatchFn: (item, searchValue) {
//                 return item.value.toString().toLowerCase().contains(
//                   searchValue.toLowerCase(),
//                 );
//               },
//             ),
//             onChanged: (value) {
//               if (value == null) return;

//               int index = organizationController.organizationsList.indexWhere(
//                 (e) => e.name == value,
//               );

//               if (index >= 0) {
//                 controller.changeOrganization(index);
//               }
//               _orgSearchController.clear();
//             },
//             onMenuStateChange: (isOpen) {
//               if (!isOpen) {
//                 _orgSearchController.clear();
//               }
//             },
//             customButton: Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12.rw),
//                 border: Border.all(color: const Color(0xFFE4E4E4), width: 1),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Obx(() {
//                       final orgs = organizationController.organizationsList;
//                       final selIdx = controller.selectedOrganizationIndex.value;

//                       final name =
//                           (orgs.isNotEmpty &&
//                               selIdx >= 0 &&
//                               selIdx < orgs.length)
//                           ? orgs[selIdx].name
//                           : 'Select organization';

//                       return Text(
//                         name,
//                         style: TextStyle(
//                           fontFamily: DonationFonts.interDisplay,
//                           fontSize: 14.rfs,
//                           fontWeight: FontWeight.w500,
//                           color: DonationConstants.offBlack,
//                         ),
//                       );
//                     }),
//                   ),

//                   Text(
//                     'Change',
//                     textAlign: TextAlign.right,
//                     style: TextStyle(
//                       color: const Color(
//                         0xFFC08FFF,
//                       ) /* Colors-Primary-Purple */,
//                       fontSize: 14,
//                       fontFamily: 'Inter Display',
//                       fontWeight: FontWeight.w500,
//                       height: 1.43,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
