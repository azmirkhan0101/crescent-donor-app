import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/bottom_sheet_button_widget.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RedemptionCodeBottomSheet extends StatelessWidget {
  const RedemptionCodeBottomSheet({
    super.key,
    required this.rewardTitle,
    required this.rewardDescription,
    required this.redemptionCode,
    required this.expiryDate,
    this.brandIcon,
  });

  final String rewardTitle;
  final String rewardDescription;
  final String redemptionCode;
  final String expiryDate;
  final Widget? brandIcon;

  void _copyCodeToClipboard() {
    Clipboard.setData(ClipboardData(text: redemptionCode));
    Get.snackbar(
      'Copied!',
      'Redemption code copied to clipboard',
      backgroundColor: AppColors.secondaryColor,
      colorText: const Color(0xFF000C0B),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border(
          top: BorderSide(color: Color(0xFFEBE9EC), width: 1),
          left: BorderSide(color: Color(0xFFEBE9EC), width: 1),
          right: BorderSide(color: Color(0xFFEBE9EC), width: 1),
        ),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              // Fixed top section with handle, title
              Container(
                padding: EdgeInsets.fromLTRB(24.rw, 12.rh, 24.rw, 0),
                child: Column(
                  children: [
                    // Handle bar
                    Container(
                      width: 32.rw,
                      height: 4.rh,
                      decoration: BoxDecoration(
                        color: const Color(0xFF000C0B),
                        borderRadius: BorderRadius.circular(100.rw),
                      ),
                    ),

                    16.rh.heightWidth,

                    // Title and close button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Redemption Details',
                          style: AppTextStyles.f20w600().copyWith(
                            color: const Color(0xFF000C0B),
                            fontSize: 20.rfs,
                            height: 1.2,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SizedBox(
                            width: 20.rw,
                            height: 20.rh,
                            child: Icon(
                              Icons.close,
                              size: 14.rfs,
                              color: const Color(0xFF000C0B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.fromLTRB(24.rw, 20.rh, 24.rw, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Instruction text
                      Text(
                        'Copy the code to redeem the reward',
                        style: AppTextStyles.f16W500().copyWith(
                          color: const Color(0xFF000C0B),
                          fontSize: 14.rfs,
                          height: 1.43,
                        ),
                      ),

                      12.rh.heightWidth,

                      // Coupon card with cutout design
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFF9F7F9),
                          borderRadius: BorderRadius.circular(12.rw),
                        ),
                        child: Stack(
                          children: [
                            // Main coupon content
                            Padding(
                              padding: EdgeInsets.all(16.rw),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Brand and reward info
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Brand logo
                                      Container(
                                        width: 28.rw,
                                        height: 28.rh,
                                        padding: EdgeInsets.all(7.rw),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF000C0B),
                                          borderRadius: BorderRadius.circular(
                                            874.125.rw,
                                          ),
                                        ),
                                        child:
                                            brandIcon ??
                                            Assets.rewards.amazonA.svg(
                                              width: 14.rw,
                                              height: 14.rh,
                                            ),
                                      ),

                                      8.rw.heightWidth,

                                      // Reward details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              rewardTitle,
                                              style: AppTextStyles.f16W500()
                                                  .copyWith(
                                                    color: const Color(
                                                      0xFF000C0B,
                                                    ),
                                                    height: 1.25,
                                                  ),
                                            ),

                                            8.rh.heightWidth,

                                            Text(
                                              rewardDescription,
                                              style: TextStyle(
                                                color: const Color(0xFF818F8D),
                                                fontSize: 12.rfs,
                                                fontFamily: 'Inter Display',
                                                fontWeight: FontWeight.w400,
                                                height: 1.33,
                                              ),
                                            ),

                                            8.rh.heightWidth,

                                            RichText(
                                              text: TextSpan(
                                                text: 'Expires: ',
                                                style: TextStyle(
                                                  color: const Color(
                                                    0xFF818F8D,
                                                  ),
                                                  fontSize: 12.rfs,
                                                  fontFamily: 'Inter Display',
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.33,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: expiryDate,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  16.rh.heightWidth,

                                  // Divider line
                                  Container(
                                    height: 1.rh,
                                    width: double.infinity,
                                    color: const Color(0xFFE0E0E0),
                                  ),

                                  16.rh.heightWidth,

                                  // Redemption code section
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.rw,
                                      vertical: 10.rh,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5F0FC),
                                      borderRadius: BorderRadius.circular(8.rw),
                                      border: Border.all(
                                        color: const Color(0xFFA55EEA),
                                        width: 1,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            redemptionCode,
                                            style: TextStyle(
                                              color: const Color(0xFF9D68DE),
                                              fontSize: 14.rfs,
                                              fontFamily: 'Inter Display',
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.7,
                                              height: 1.43,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: _copyCodeToClipboard,
                                          child: Icon(
                                            Icons.copy,
                                            size: 20.rfs,
                                            color: const Color(0xFF9D68DE),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Left cutout circle
                            Positioned(
                              left: -11.rw,
                              top: 107.rh,
                              child: Container(
                                width: 22.rw,
                                height: 22.rh,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),

                            // Right cutout circle
                            Positioned(
                              right: -11.rw,
                              top: 107.rh,
                              child: Container(
                                width: 22.rw,
                                height: 22.rh,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      12.rh.heightWidth,

                      // Footer text
                      Text(
                        'This code has been sent to registered email & phone address',
                        style: TextStyle(
                          color: const Color(0xFF818F8D),
                          fontSize: 12.rfs,
                          fontFamily: 'Inter Display',
                          fontWeight: FontWeight.w400,
                          height: 1.33,
                        ),
                      ),

                      // Add some bottom padding
                      100.rh.heightWidth,
                    ],
                  ),
                ),
              ),

              // Fixed bottom section with copy button
              Container(
                padding: EdgeInsets.fromLTRB(24.rw, 2.rh, 24.rw, 2.rh),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withValues(alpha: 0),
                      Colors.white.withValues(alpha: 0.7),
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
                child: BottomSheetButtonWidget(
                  backgroundColor: const Color(0xFFD1FF43),
                  text: 'Copy Code',
                ),
              ).onTap(() => _copyCodeToClipboard()).paddingB(24.rh),
            ],
          );
        },
      ),
    );
  }
}
