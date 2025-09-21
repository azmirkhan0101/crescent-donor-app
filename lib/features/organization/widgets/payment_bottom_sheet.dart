// import 'package:flutter/material.dart';

// import '../../../utils/sizer/sizer.dart';

// class PaymentBottomSheet extends StatefulWidget {
//   final bool hasLinkedAccounts;

//   const PaymentBottomSheet({super.key, this.hasLinkedAccounts = false});

//   @override
//   State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
// }

// class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Color(0xFFF7F7F7),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Handle bar
//           Container(
//             margin: EdgeInsets.only(top: 8.rh),
//             width: 36.rw,
//             height: 4.rh,
//             decoration: BoxDecoration(
//               color: const Color(0xFFE0E0E0),
//               borderRadius: BorderRadius.circular(2.rh),
//             ),
//           ),

//           // Header
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
//             child: Row(
//               children: [
//                 GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Container(
//                     padding: EdgeInsets.all(12.rw),
//                     decoration: BoxDecoration(
//                       color: Colors.transparent,
//                       borderRadius: BorderRadius.circular(24.rw),
//                     ),
//                     child: Icon(
//                       Icons.chevron_left,
//                       size: 20.rw,
//                       color: const Color(0xFF000C0B),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     'Linked Account',
//                     style: TextStyle(
//                       fontSize: 20.rfs,
//                       fontWeight: FontWeight.bold,
//                       color: const Color(0xFF000C0B),
//                       letterSpacing: -0.2,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     // Add account functionality
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(12.rw),
//                     decoration: BoxDecoration(
//                       color: Colors.transparent,
//                       borderRadius: BorderRadius.circular(24.rw),
//                     ),
//                     child: Icon(
//                       Icons.add,
//                       size: 20.rw,
//                       color: const Color(0xFF000C0B),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Content based on account state
//           if (widget.hasLinkedAccounts)
//             _buildLinkedAccountsContent()
//           else
//             _buildNoAccountsContent(),

//           // Continue button
//           Container(
//             width: double.infinity,
//             margin: EdgeInsets.all(16.rw),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Handle continue action
//                 Navigator.pop(context);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF000C0B),
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(vertical: 16.rh),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.rw),
//                 ),
//                 elevation: 0,
//               ),
//               child: Text(
//                 'Continue',
//                 style: TextStyle(
//                   fontSize: 18.rfs,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: -0.36,
//                 ),
//               ),
//             ),
//           ),

//           // Bottom safe area
//           SizedBox(height: MediaQuery.of(context).padding.bottom),
//         ],
//       ),
//     );
//   }

//   Widget _buildNoAccountsContent() {
//     return Column(
//       children: [
//         // Credit card visual
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
//           height: 217.rh,
//           decoration: BoxDecoration(
//             color: const Color(0xFF000C0B),
//             borderRadius: BorderRadius.circular(24.rw),
//           ),
//           child: Stack(
//             children: [
//               // Background patterns
//               Positioned(
//                 left: -65.03.rw,
//                 top: 20.72.rh,
//                 child: Transform.rotate(
//                   angle: 82 * 3.14159 / 180,
//                   child: Container(
//                     width: 256.393.rw,
//                     height: 256.393.rh,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(24.01.rw),
//                       gradient: const RadialGradient(
//                         colors: [
//                           Color.fromRGBO(209, 255, 67, 0.05),
//                           Color.fromRGBO(209, 255, 67, 0.1),
//                           Color.fromRGBO(209, 255, 67, 1),
//                         ],
//                         stops: [0.0, 0.15096, 1.0],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 20.58.rw,
//                 top: 80.61.rh,
//                 child: Transform.rotate(
//                   angle: 100 * 3.14159 / 180,
//                   child: Container(
//                     width: 256.393.rw,
//                     height: 256.393.rh,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(24.01.rw),
//                       gradient: const RadialGradient(
//                         colors: [
//                           Color.fromRGBO(192, 143, 255, 0.05),
//                           Color.fromRGBO(192, 143, 255, 0.1),
//                           Color.fromRGBO(192, 143, 255, 1),
//                         ],
//                         stops: [0.0, 0.15096, 1.0],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               // Card logo
//               Positioned(
//                 left: 20.58.rw,
//                 top: 24.01.rh,
//                 child: Container(
//                   width: 37.73.rw,
//                   height: 24.01.rh,
//                   decoration: const BoxDecoration(color: Colors.white),
//                   child: const Center(
//                     child: Text(
//                       'VISA',
//                       style: TextStyle(
//                         color: Color(0xFF1A1F71),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),

//               // Card number
//               Positioned(
//                 left: 20.58.rw,
//                 top: 102.9.rh,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'CARD NUMBER',
//                       style: TextStyle(
//                         fontSize: 10.rfs,
//                         color: const Color(0xFF0D0D15),
//                         fontWeight: FontWeight.w500,
//                         letterSpacing: 0.2,
//                       ),
//                     ),
//                     SizedBox(height: 3.43.rh),
//                     Text(
//                       '9252 5836 2947 5988',
//                       style: TextStyle(
//                         fontSize: 20.rfs,
//                         color: const Color(0xFF0D0D15),
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 1.715,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // Card holder info
//               Positioned(
//                 left: 20.58.rw,
//                 top: 162.93.rh,
//                 child: Row(
//                   children: [
//                     // Cardholder name
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'CARD HOLDER NAME',
//                           style: TextStyle(
//                             fontSize: 10.rfs,
//                             color: const Color(0xFF0D0D15),
//                             fontWeight: FontWeight.w500,
//                             letterSpacing: 0.2,
//                           ),
//                         ),
//                         SizedBox(height: 3.43.rh),
//                         Text(
//                           'Talha S.',
//                           style: TextStyle(
//                             fontSize: 12.rfs,
//                             color: const Color(0xFF0D0D15),
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(width: 124.338.rw),
//                     // Valid thru
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'VAID THRU',
//                           style: TextStyle(
//                             fontSize: 10.rfs,
//                             color: const Color(0xFF0D0D15),
//                             fontWeight: FontWeight.w500,
//                             letterSpacing: 0.2,
//                           ),
//                         ),
//                         SizedBox(height: 3.43.rh),
//                         Text(
//                           '09/17',
//                           style: TextStyle(
//                             fontSize: 12.rfs,
//                             color: const Color(0xFF0D0D15),
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Divider
//         Container(
//           height: 32.rh,
//           width: double.infinity,
//           color: const Color(0xFFEDEDED),
//         ),

//         // Payment options
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
//           child: Row(
//             children: [
//               // Apple Pay
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(
//                     vertical: 24.rh,
//                     horizontal: 8.rw,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12.rw),
//                     border: Border.all(color: const Color(0xFFEDEDED)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: 0.02),
//                         blurRadius: 5,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: 46.4.rw,
//                         height: 16.rh,
//                         decoration: const BoxDecoration(color: Colors.black),
//                         child: Center(
//                           child: Text(
//                             'Pay',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12.rfs,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(width: 8.rw),
//               // Google Pay
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(
//                     vertical: 24.rh,
//                     horizontal: 8.rw,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12.rw),
//                     border: Border.all(color: const Color(0xFFEDEDED)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: 0.02),
//                         blurRadius: 5,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: 51.2.rw,
//                         height: 16.rh,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'G',
//                               style: TextStyle(
//                                 color: const Color(0xFF4285F4),
//                                 fontSize: 12.rfs,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(' ', style: TextStyle(fontSize: 12.rfs)),
//                             Text(
//                               'Pay',
//                               style: TextStyle(
//                                 color: const Color(0xFF5F6368),
//                                 fontSize: 12.rfs,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLinkedAccountsContent() {
//     return Column(
//       children: [
//         // Payment accounts list
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.rw),
//           child: Column(
//             children: [
//               // Apple Pay
//               _buildAccountItem(
//                 icon: Container(
//                   width: 40.rw,
//                   height: 40.rh,
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(40.rw),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Pay',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 10.rfs,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//                 title: 'Apple Pay',
//                 subtitle: 'Talha Shafqat',
//               ),
//               SizedBox(height: 8.rh),

//               // Google Pay
//               _buildAccountItem(
//                 icon: Container(
//                   width: 40.rw,
//                   height: 40.rh,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF4285F4),
//                     borderRadius: BorderRadius.circular(40.rw),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'G',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16.rfs,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 title: 'Google Pay',
//                 subtitle: 'Talha Shafqat',
//               ),
//               SizedBox(height: 8.rh),

//               // Chase Bank
//               _buildAccountItem(
//                 icon: Container(
//                   width: 40.rw,
//                   height: 40.rh,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF0066B2),
//                     borderRadius: BorderRadius.circular(40.rw),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'C',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16.rfs,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 title: 'Chase',
//                 subtitle: 'CHASUS33 XXXXXXXXX 1234',
//               ),
//             ],
//           ),
//         ),

//         // Divider
//         Container(
//           height: 32.rh,
//           width: double.infinity,
//           color: const Color(0xFFEDEDED),
//           margin: EdgeInsets.symmetric(vertical: 16.rh),
//         ),

//         // Add another account
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.rw),
//           child: _buildAccountItem(
//             icon: Container(
//               width: 40.rw,
//               height: 40.rh,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFE0E0E0),
//                 borderRadius: BorderRadius.circular(40.rw),
//               ),
//               child: Icon(
//                 Icons.add,
//                 size: 20.rw,
//                 color: const Color(0xFF5F6368),
//               ),
//             ),
//             title: 'Add another account',
//             subtitle: null,
//             showChevron: true,
//           ),
//         ),

//         SizedBox(height: 16.rh),
//       ],
//     );
//   }

//   Widget _buildAccountItem({
//     required Widget icon,
//     required String title,
//     String? subtitle,
//     bool showChevron = true,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(8.rw),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.rw),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.02),
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           icon,
//           SizedBox(width: 8.rw),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 12.rfs,
//                     fontWeight: FontWeight.w600,
//                     color: const Color(0xFF0D0D15),
//                   ),
//                 ),
//                 if (subtitle != null) ...[
//                   SizedBox(height: 6.rh),
//                   Text(
//                     subtitle,
//                     style: TextStyle(
//                       fontSize: 10.rfs,
//                       color: const Color(0xFF0D0D15),
//                       letterSpacing: 0.2,
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//           if (showChevron)
//             Icon(
//               Icons.chevron_right,
//               size: 20.rw,
//               color: const Color(0xFF5F6368),
//             ),
//         ],
//       ),
//     );
//   }

//   static Future<void> show(
//     BuildContext context, {
//     bool hasLinkedAccounts = false,
//   }) {
//     return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) =>
//           PaymentBottomSheet(hasLinkedAccounts: hasLinkedAccounts),
//     );
//   }
// }
