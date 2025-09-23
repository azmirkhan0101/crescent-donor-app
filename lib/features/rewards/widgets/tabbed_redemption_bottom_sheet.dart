import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
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
  State<TabbedRedemptionBottomSheet> createState() => _TabbedRedemptionBottomSheetState();
}

class _TabbedRedemptionBottomSheetState extends State<TabbedRedemptionBottomSheet> {
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
        initialChildSize: 0.8,
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
                    
                    20.rh.heightWidth,
                    
                    // Redemption method tabs
                    Container(
                      padding: EdgeInsets.all(4.rw),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.rw),
                        border: Border.all(
                          color: const Color(0xFFE4E4E4).withValues(alpha: 0.3),
                          width: 1,
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
                            child: _buildTabButton(
                              'NFC',
                              RedemptionMethod.nfc,
                            ),
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
              
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.fromLTRB(24.rw, 20.rh, 24.rw, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Reward info card
                      _buildRewardInfoCard(),
                      
                      20.rh.heightWidth,
                      
                      // Method-specific content
                      _buildMethodContent(),
                      
                      // Add some bottom padding
                      100.rh.heightWidth,
                    ],
                  ),
                ),
              ),
              
              // Fixed bottom section with action button
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
                child: Column(
                  children: [
                    // Action button
                    SizedBox(
                      width: double.infinity,
                      height: 48.rh,
                      child: ElevatedButton(
                        onPressed: _getActionButtonCallback(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD1FF43),
                          foregroundColor: const Color(0xFF000C0B),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.rw),
                          ),
                        ),
                        child: Text(
                          _getActionButtonText(),
                          style: TextStyle(
                            color: const Color(0xFF000C0B),
                            fontSize: 16.rfs,
                            fontFamily: 'Inter Display',
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                          ),
                        ),
                      ),
                    ),
                    
                    // Home indicator
                    Container(
                      margin: EdgeInsets.only(top: 8.rh, bottom: 8.rh),
                      width: 139.rw,
                      height: 5.rh,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100.rw),
                      ),
                    ),
                  ],
                ),
              ),
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
        padding: EdgeInsets.symmetric(horizontal: 24.rw, vertical: 12.rh),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF000C0B) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.rw),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF000C0B),
            fontSize: 14.rfs,
            fontFamily: 'Inter Display',
            fontWeight: FontWeight.w600,
            height: 1.43,
          ),
        ),
      ),
    );
  }

  Widget _buildRewardInfoCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.rw),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand logo
          Container(
            width: 28.rw,
            height: 28.rh,
            padding: EdgeInsets.all(7.rw),
            decoration: BoxDecoration(
              color: const Color(0xFF000C0B),
              borderRadius: BorderRadius.circular(874.125.rw),
            ),
            child: widget.brandIcon ?? Assets.rewards.amazonA.svg(
              width: 14.rw,
              height: 14.rh,
            ),
          ),
          
          8.rw.heightWidth,
          
          // Reward details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.rewardTitle,
                  style: AppTextStyles.f16W500().copyWith(
                    color: const Color(0xFF000C0B),
                    height: 1.25,
                  ),
                ),
                
                8.rh.heightWidth,
                
                Text(
                  widget.rewardDescription,
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
                      color: const Color(0xFF818F8D),
                      fontSize: 12.rfs,
                      fontFamily: 'Inter Display',
                      fontWeight: FontWeight.w500,
                      height: 1.33,
                    ),
                    children: [
                      TextSpan(
                        text: widget.expiryDate,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
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
        Text(
          'Scan this QR code at the store to redeem your reward',
          textAlign: TextAlign.center,
          style: AppTextStyles.f16W500().copyWith(
            color: const Color(0xFF000C0B),
            fontSize: 14.rfs,
            height: 1.43,
          ),
        ),
        
        24.rh.heightWidth,
        
        // QR Code
        Container(
          padding: EdgeInsets.all(24.rw),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.rw),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: QrImageView(
            data: widget.redemptionCode,
            version: QrVersions.auto,
            size: 200.rw,
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF000C0B),
          ),
        ),
        
        16.rh.heightWidth,
        
        Text(
          'Code: ${widget.redemptionCode}',
          style: TextStyle(
            color: const Color(0xFF818F8D),
            fontSize: 12.rfs,
            fontFamily: 'Inter Display',
            fontWeight: FontWeight.w500,
            height: 1.33,
          ),
        ),
      ],
    );
  }

  Widget _buildNFCContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Hold your phone near the NFC reader at the store',
          textAlign: TextAlign.center,
          style: AppTextStyles.f16W500().copyWith(
            color: const Color(0xFF000C0B),
            fontSize: 14.rfs,
            height: 1.43,
          ),
        ),
        
        32.rh.heightWidth,
        
        // NFC Animation/Icon
        Container(
          width: 200.rw,
          height: 200.rh,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F0FC),
            borderRadius: BorderRadius.circular(16.rw),
            border: Border.all(
              color: const Color(0xFF9D68DE),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.nfc,
                size: 80.rfs,
                color: const Color(0xFF9D68DE),
              ),
              
              16.rh.heightWidth,
              
              Text(
                'NFC Ready',
                style: TextStyle(
                  color: const Color(0xFF9D68DE),
                  fontSize: 16.rfs,
                  fontFamily: 'Inter Display',
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
        
        24.rh.heightWidth,
        
        Container(
          padding: EdgeInsets.all(16.rw),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F7F9),
            borderRadius: BorderRadius.circular(12.rw),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16.rfs,
                    color: const Color(0xFF818F8D),
                  ),
                  
                  8.rw.heightWidth,
                  
                  Expanded(
                    child: Text(
                      'Make sure NFC is enabled on your device',
                      style: TextStyle(
                        color: const Color(0xFF818F8D),
                        fontSize: 12.rfs,
                        fontFamily: 'Inter Display',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStaticCodeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Show this code to the cashier at checkout',
          style: AppTextStyles.f16W500().copyWith(
            color: const Color(0xFF000C0B),
            fontSize: 14.rfs,
            height: 1.43,
          ),
        ),
        
        16.rh.heightWidth,
        
        // Static Code Display
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.rw),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F0FC),
            borderRadius: BorderRadius.circular(16.rw),
            border: Border.all(
              color: const Color(0xFFA55EEA),
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            children: [
              Text(
                widget.redemptionCode,
                style: TextStyle(
                  color: const Color(0xFF9D68DE),
                  fontSize: 32.rfs,
                  fontFamily: 'Inter Display',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 4.0,
                  height: 1.2,
                ),
              ),
              
              16.rh.heightWidth,
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _copyCodeToClipboard,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.copy,
                          size: 16.rfs,
                          color: const Color(0xFF9D68DE),
                        ),
                        
                        8.rw.heightWidth,
                        
                        Text(
                          'Copy Code',
                          style: TextStyle(
                            color: const Color(0xFF9D68DE),
                            fontSize: 14.rfs,
                            fontFamily: 'Inter Display',
                            fontWeight: FontWeight.w600,
                            height: 1.43,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        16.rh.heightWidth,
        
        Text(
          'This code has been sent to your registered email & phone address',
          style: TextStyle(
            color: const Color(0xFF818F8D),
            fontSize: 12.rfs,
            fontFamily: 'Inter Display',
            fontWeight: FontWeight.w400,
            height: 1.33,
          ),
        ),
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
