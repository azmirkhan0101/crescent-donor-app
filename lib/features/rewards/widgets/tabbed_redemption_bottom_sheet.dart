import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/rewards/pages/redeem_success_page.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/bottom_sheet_button_widget.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

enum RedemptionMethod { qrCode, nfc, staticCode }

class TabbedRedemptionBottomSheet extends StatefulWidget {
  const TabbedRedemptionBottomSheet({
    super.key,
    required this.rewardTitle,
    required this.rewardDescription,
    required this.redemptionCode,
    required this.expiryDate,
    this.brandIcon,
    this.initialMethod = RedemptionMethod.qrCode,
  });

  final String rewardTitle;
  final String rewardDescription;
  final String redemptionCode;
  final String expiryDate;
  final Widget? brandIcon;
  final RedemptionMethod initialMethod;

  @override
  State<TabbedRedemptionBottomSheet> createState() =>
      _TabbedRedemptionBottomSheetState();
}

class _TabbedRedemptionBottomSheetState
    extends State<TabbedRedemptionBottomSheet> {
  late RedemptionMethod selectedMethod;

  @override
  void initState() {
    super.initState();
    selectedMethod = widget.initialMethod;
  }

  void _copyCodeToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.redemptionCode));
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
        minChildSize: 0.6,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              // Fixed top section with handle, title, and tabs
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

                    // /===> Title and close button <====\
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

                    20.rh.heightWidth,

                    // /===> Redemption method tabs <====\
                    Container(
                      padding: EdgeInsets.all(4.rw),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F7F9),
                        borderRadius: BorderRadius.circular(16.rw),
                        border: Border.all(
                          color: const Color(0xFFF3F1F3),
                          width: 1.rw,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildTabButton(
                              'QR Code',
                              RedemptionMethod.qrCode,
                            ),
                          ),
                          Expanded(
                            child: _buildTabButton('NFC', RedemptionMethod.nfc),
                          ),
                          Expanded(
                            child: _buildTabButton(
                              'Static Code',
                              RedemptionMethod.staticCode,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // /===> Scrollable content <====\
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.fromLTRB(24.rw, 20.rh, 24.rw, 0),
                  child: _buildMethodContent(),
                ),
              ),

              // Fixed bottom section with action button
              BottomSheetButtonWidget(
                    text: _getActionButtonText(),
                    backgroundColor: AppColors.secondaryColor,
                  )
                  .onLongPress(() => _copyCodeToClipboard())
                  .paddingX(24.rw)
                  .paddingB(24.rh),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTabButton(String title, RedemptionMethod method) {
    final isSelected = selectedMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = method;
        });
      },
      child: Container(
        height: 44.rh,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF000C0B) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.rw),
        ),
        child: Center(
          child: title
              .centerText(AppTextStyles.f14W400())
              .color(isSelected ? Colors.white : const Color(0xFF000C0B))
              .fontWeight(FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildMethodContent() {
    switch (selectedMethod) {
      case RedemptionMethod.qrCode:
        return _buildQRCodeContent();
      case RedemptionMethod.nfc:
        return _buildNFCContent();
      case RedemptionMethod.staticCode:
        return _buildStaticCodeContent();
    }
  }

  Widget _buildQRCodeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        "Scan QR code".centerText(AppTextStyles.f20w600()).fontSize(24.rfs),
        8.rh.heightWidth,
        "Please point the camera at the QR Code"
            .centerText(AppTextStyles.f14W400())
            .color(const Color(0xFF000C0B)),
        24.rh.heightWidth,

        // QR Code
        QrImageView(
          data: widget.redemptionCode,
          version: QrVersions.auto,
          size: 180.rfs,
          backgroundColor: Colors.white,
          dataModuleStyle: QrDataModuleStyle(
            color: const Color(0xFF000C0B),
            dataModuleShape: QrDataModuleShape.square,
          ),
        ).paddingY(40.rh),

        Row(
          children: [
            Expanded(
              child: Divider(height: 1.rh, color: const Color(0xFF777777)),
            ),
            "QR Code"
                .centerText(AppTextStyles.f14W400())
                .fontSize(12.rfs)
                .paddingX(12.rw),
            Expanded(
              child: Divider(height: 1.rh, color: const Color(0xFF777777)),
            ),
          ],
        ).paddingX(40.rw),

        16.rh.heightWidth,

        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.rw),
            border: Border.all(color: const Color(0xFFE4E4E4)),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.rw),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SWB-QR- ${widget.redemptionCode}',
                  style: AppTextStyles.f14W400(),
                ).color(const Color(0xFF000000)),
                Assets.common.copy.svg(width: 20.rw, height: 20.rh),
              ],
            ),
          ),
        ).paddingX(40.rw),
      ],
    );
  }

  Widget _buildNFCContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        88.rh.heightWidth,

        // NFC Animation/Icon
        Assets.rewards.mobileOnHand.svg(width: 48.rw, height: 48.rh),

        Text(
          'Tap to redeem',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF000C0B) /* Colors-Off-Black */,
            fontSize: 24,
            fontFamily: 'Familjen Grotesk',
            fontWeight: FontWeight.w600,
            height: 1.33,
          ),
        ),

        12.rh.heightWidth,
        Text(
          'Hold your phone near the NFC tag',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF808E8D),
            fontSize: 14,
            fontFamily: 'Inter Display',
            fontWeight: FontWeight.w400,
            height: 1.14,
          ),
        ),

        129.rh.heightWidth,
      ],
    );
  }

  Widget _buildStaticCodeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        96.rh.heightWidth,
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            Center(
              child: Text(
                'Copy the code to redeem the reward',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF000C0B) /* Colors-Off-Black */,
                  fontSize: 14,
                  fontFamily: 'Inter Display',
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFFF5F0FC),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: const Color(0xFFA55EEA)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 20,
                children: [
                  Text(
                    'AMAZON10FRESH',
                    style: TextStyle(
                      color: const Color(
                        0xFF9C68DD,
                      ) /* Colors-Primary-Purple-Dark */,
                      fontSize: 14,
                      fontFamily: 'Inter Display',
                      fontWeight: FontWeight.w600,
                      height: 1.43,
                      letterSpacing: 0.70,
                    ),
                  ),
                  Assets.common.copy.svg(width: 20.rw, height: 20.rh),
                ],
              ),
            ),
            Text(
              'This code has been sent to registered email & phone address',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF808E8D),
                fontSize: 12,
                fontFamily: 'Inter Display',
                fontWeight: FontWeight.w400,
                height: 1.33,
              ),
            ),
          ],
        ),
        137.rh.heightWidth,
      ],
    );
  }

  String _getActionButtonText() {
    switch (selectedMethod) {
      case RedemptionMethod.qrCode:
        return 'Save QR Code';
      case RedemptionMethod.nfc:
        return 'Activate NFC';
      case RedemptionMethod.staticCode:
        return 'Copy Code';
    }
  }

  VoidCallback _getActionButtonCallback() {
    switch (selectedMethod) {
      case RedemptionMethod.qrCode:
        return () {
          // Save QR code functionality
          Get.snackbar(
            'Saved!',
            'QR code saved to gallery',
            backgroundColor: AppColors.secondaryColor,
            colorText: const Color(0xFF000C0B),
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );
        };
      case RedemptionMethod.nfc:
        return () {
          // Activate NFC functionality
          Get.snackbar(
            'NFC Activated!',
            'Your reward is ready for NFC redemption',
            backgroundColor: AppColors.secondaryColor,
            colorText: const Color(0xFF000C0B),
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );
        };
      case RedemptionMethod.staticCode:
        return _copyCodeToClipboard;
    }
  }
}
