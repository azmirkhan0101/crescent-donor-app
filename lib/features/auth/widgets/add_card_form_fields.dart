// import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
// import 'package:cresent_charge_user_app/features/auth/controllers/profile_controller.dart';
// import 'package:cresent_charge_user_app/features/auth/widgets/custom_input_field.dart';
// import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
// import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
// import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AddCardFormFields extends StatefulWidget {
//   const AddCardFormFields({super.key});

//   @override
//   State<AddCardFormFields> createState() => _AddCardFormFieldsState();
// }

// class _AddCardFormFieldsState extends State<AddCardFormFields> {
//   late final ProfileController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.isRegistered<ProfileController>()
//         ? Get.find<ProfileController>()
//         : Get.put(ProfileController());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       // spacing: 16.rh, // If needed, add SizedBox for spacing between children
//       children: [
//         // Full Name field
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AppStrings.fullName
//                 .text(AppTextStyles.baseStyle())
//                 .color("#000C0B".hexColor),

//             8.rh.heightWidth,
//             CustomInputField(
//               controller: controller.nameInCardController,
//               hintText: AppStrings.enterName,
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.text,
//               isPrefixIcon: false,
//               validator: controller.validateName,
//             ),
//           ],
//         ),

//         // Card number field
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AppStrings.cardNumber
//                 .text(AppTextStyles.baseStyle())
//                 .color("#000C0B".hexColor),

//             8.rh.heightWidth,

//             CustomInputField(
//               controller: controller.cardNumberController,
//               hintText: "**** **** **** ****",
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.number,
//               isPrefixIcon: false,
//               validator: controller.validateCardNumber,
//             ),
//           ],
//         ),

//         // Expiry date and CVC fields
//         Row(
//           children: [
//             // Expiry date field
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   AppStrings.expiryDate
//                       .text(AppTextStyles.baseStyle())
//                       .color("#000C0B".hexColor),

//                   8.rh.heightWidth,
//                   CustomInputField(
//                     controller: controller.cardExpiryDateController,
//                     hintText: "MM/YY",
//                     textInputAction: TextInputAction.next,
//                     keyboardType: TextInputType.text,
//                     isPrefixIcon: false,
//                     validator: controller.validateExpiryDate,
//                   ),
//                 ],
//               ),
//             ),

//             16.rw.heightWidth,

//             // CVC field
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   AppStrings.cvc
//                       .text(AppTextStyles.baseStyle())
//                       .color("#000C0B".hexColor),

//                   8.rh.heightWidth,
//                   CustomInputField(
//                     controller: controller.cardCVCController,
//                     hintText: "***",
//                     textInputAction: TextInputAction.done,
//                     keyboardType: TextInputType.number,
//                     isPrefixIcon: false,
//                     validator: controller.validateCVC,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
