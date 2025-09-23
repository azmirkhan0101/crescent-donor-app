import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class RewardDetailsBottomSheet extends StatefulWidget {
  const RewardDetailsBottomSheet({
    super.key, 
    required this.index,
    this.isStoreReward = false,
    this.expiryDateTime,
    this.storeName,
  });

  final int index;
  final bool isStoreReward;
  final DateTime? expiryDateTime;
  final String? storeName;

  @override
  State<RewardDetailsBottomSheet> createState() => _RewardDetailsBottomSheetState();
}

class _RewardDetailsBottomSheetState extends State<RewardDetailsBottomSheet> {
  Timer? _timer;
  Duration _timeRemaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    if (widget.isStoreReward && widget.expiryDateTime != null) {
      _updateTimeRemaining();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _updateTimeRemaining();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTimeRemaining() {
    if (widget.expiryDateTime != null) {
      final now = DateTime.now();
      final difference = widget.expiryDateTime!.difference(now);
      if (mounted) {
        setState(() {
          _timeRemaining = difference.isNegative ? Duration.zero : difference;
        });
      }
    }
  }

  Widget _buildTimeUnit(String value, String unit) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF000C0B),
            fontSize: 24.rfs,
            fontWeight: FontWeight.w600,
            fontFamily: AppStrings.familjenGrotesk,
            height: 1.2,
          ),
        ),
        Text(
          unit,
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
        initialChildSize: 0.65,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              // Fixed top section with handle, title, and image
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
                          'Reward Details',
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

                    16.rh.heightWidth,

                    // Reward image
                    Container(
                      width: double.infinity,
                      height: 120.rh,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9F7F9),
                        borderRadius: BorderRadius.circular(8.rw),
                      ),
                      child: Stack(
                        children: [
                          // Background image
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.rw),
                              image: DecorationImage(
                                image: AssetImage(
                                  Assets.rewards.groceries.path,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Brand logo positioned at bottom left
                          Positioned(
                            bottom: 12.rh,
                            left: 12.rw,
                            child: Container(
                              width: 56.rw,
                              height: 56.rh,
                              padding: EdgeInsets.all(14.rw),
                              decoration: BoxDecoration(
                                color: const Color(0xFF000C0B),
                                borderRadius: BorderRadius.circular(1748.25.rw),
                              ),
                              child: Assets.rewards.amazonA.svg(
                                width: 28.rw,
                                height: 28.rh,
                              ),
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
                  padding: EdgeInsets.fromLTRB(24.rw, 16.rh, 24.rw, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and points row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              '10% off on Groceries',
                              style: AppTextStyles.f16W500().copyWith(
                                color: const Color(0xFF000C0B),
                                fontSize: 16.rfs,
                                height: 1.5,
                              ),
                            ),
                          ),
                          4.rw.heightWidth,
                          Row(
                            children: [
                              Assets.rewards.rewardCoin.svg(
                                width: 24.rw,
                                height: 24.rh,
                              ),
                              2.rw.heightWidth,
                              Text(
                                '150',
                                style: TextStyle(
                                  color: const Color(0xFF000C0B),
                                  fontSize: 20.rfs,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppStrings.familjenGrotesk,
                                  height: 1.2,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      8.rh.heightWidth,

                      // Conditional content based on reward type
                      if (widget.isStoreReward) ...[
                        // Store Reward tag
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.rw,
                            vertical: 8.rh,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE4B3),
                            borderRadius: BorderRadius.circular(16.rw),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.store,
                                size: 18.rfs,
                                color: const Color(0xFF000C0B),
                              ),
                              4.rw.heightWidth,
                              Text(
                                'In Store Reward',
                                style: TextStyle(
                                  color: const Color(0xFF000C0B),
                                  fontSize: 12.rfs,
                                  fontFamily: 'Inter Display',
                                  fontWeight: FontWeight.w400,
                                  height: 1.33,
                                ),
                              ),
                            ],
                          ),
                        ),

                        8.rh.heightWidth,

                        // Description
                        RichText(
                          text: TextSpan(
                            text: 'Enjoy ',
                            style: TextStyle(
                              color: const Color(0xFF818F8D),
                              fontSize: 14.rfs,
                              fontFamily: 'Inter Display',
                              fontWeight: FontWeight.w400,
                              height: 1.43,
                            ),
                            children: [
                              TextSpan(
                                text: '10% off',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              TextSpan(text: ' on your next grocery'),
                            ],
                          ),
                        ),

                        8.rh.heightWidth,

                        // Expiry
                        RichText(
                          text: TextSpan(
                            text: 'Expires: ',
                            style: TextStyle(
                              color: const Color(0xFF818F8D),
                              fontSize: 14.rfs,
                              fontFamily: 'Inter Display',
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                            ),
                            children: [
                              TextSpan(
                                text: '28 May 2025',
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),

                        16.rh.heightWidth,

                        // Countdown Timer Box
                        Container(
                          padding: EdgeInsets.all(16.rw),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F0FF),
                            borderRadius: BorderRadius.circular(12.rw),
                            border: Border.all(
                              color: const Color(0xFFE0D4FF),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.hourglass_empty,
                                    size: 18.rfs,
                                    color: const Color(0xFF000C0B),
                                  ),
                                  8.rw.heightWidth,
                                  Text(
                                    'Expires in',
                                    style: TextStyle(
                                      color: const Color(0xFF000C0B),
                                      fontSize: 14.rfs,
                                      fontFamily: 'Inter Display',
                                      fontWeight: FontWeight.w500,
                                      height: 1.43,
                                    ),
                                  ),
                                ],
                              ),
                              
                              12.rh.heightWidth,
                              
                              // Countdown display
                              Row(
                                children: [
                                  _buildTimeUnit(_timeRemaining.inDays.toString(), 'days'),
                                  8.rw.heightWidth,
                                  _buildTimeUnit((_timeRemaining.inHours % 24).toString(), 'hours'),
                                  8.rw.heightWidth,
                                  _buildTimeUnit((_timeRemaining.inMinutes % 60).toString(), 'minutes'),
                                ],
                              ),
                              
                              12.rh.heightWidth,
                              
                              // Specific time
                              Text(
                                '7:42 PM, Apr 16, 2025',
                                style: TextStyle(
                                  color: const Color(0xFF818F8D),
                                  fontSize: 12.rfs,
                                  fontFamily: 'Inter Display',
                                  fontWeight: FontWeight.w400,
                                  height: 1.33,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        // Online Reward tag
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.rw,
                            vertical: 8.rh,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA6F6E6).withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(16.rw),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.public,
                                size: 18.rfs,
                                color: const Color(0xFF000C0B),
                              ),
                              4.rw.heightWidth,
                              Text(
                                'Online Reward',
                                style: TextStyle(
                                  color: const Color(0xFF000C0B),
                                  fontSize: 12.rfs,
                                  fontFamily: 'Inter Display',
                                  fontWeight: FontWeight.w400,
                                  height: 1.33,
                                ),
                              ),
                            ],
                          ),
                        ),

                        8.rh.heightWidth,

                        // Description
                        RichText(
                          text: TextSpan(
                            text: 'Enjoy ',
                            style: TextStyle(
                              color: const Color(0xFF818F8D),
                              fontSize: 14.rfs,
                              fontFamily: 'Inter Display',
                              fontWeight: FontWeight.w400,
                              height: 1.43,
                            ),
                            children: [
                              TextSpan(
                                text: '10% off',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              TextSpan(text: ' on your next grocery'),
                            ],
                          ),
                        ),

                        8.rh.heightWidth,

                        // Expiry
                        RichText(
                          text: TextSpan(
                            text: 'Expires: ',
                            style: TextStyle(
                              color: const Color(0xFF818F8D),
                              fontSize: 14.rfs,
                              fontFamily: 'Inter Display',
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                            ),
                            children: [
                              TextSpan(
                                text: '28 May 2025',
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Add some bottom padding
                      100.rh.heightWidth,
                    ],
                  ),
                ),
              ),

              // Fixed bottom section with button
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
                    // Conditional buttons based on reward type
                    if (widget.isStoreReward) ...[
                      // Two buttons for store rewards
                      Row(
                        children: [
                          // Save button
                          Expanded(
                            child: SizedBox(
                              height: 48.rh,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Get.snackbar(
                                    'Saved',
                                    'Reward saved to your favorites!',
                                    backgroundColor: Colors.grey[100],
                                    colorText: const Color(0xFF000C0B),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF5F5F5),
                                  foregroundColor: const Color(0xFF000C0B),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.rw),
                                  ),
                                ),
                                child: Text(
                                  'Save',
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
                          ),
                          
                          12.rw.heightWidth,
                          
                          // Redeem button
                          Expanded(
                            child: SizedBox(
                              height: 48.rh,
                              child: ElevatedButton(
                                onPressed: widget.index % 3 == 2 ? null : () {
                                  Navigator.pop(context);
                                  Get.snackbar(
                                    'Success',
                                    'Reward redeemed successfully!',
                                    backgroundColor: AppColors.secondaryColor,
                                    colorText: const Color(0xFF000C0B),
                                    snackPosition: SnackPosition.TOP,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD1FF43),
                                  foregroundColor: const Color(0xFF000C0B),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.rw),
                                  ),
                                ),
                                child: Text(
                                  'Redeem Reward',
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
                          ),
                        ],
                      ),
                    ] else ...[
                      // Single button for online rewards
                      SizedBox(
                        width: double.infinity,
                        height: 48.rh,
                        child: ElevatedButton(
                          onPressed: widget.index % 3 == 2 ? null : () {
                            Navigator.pop(context);
                            Get.snackbar(
                              'Success',
                              'Reward redeemed successfully!',
                              backgroundColor: AppColors.secondaryColor,
                              colorText: const Color(0xFF000C0B),
                              snackPosition: SnackPosition.TOP,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD1FF43),
                            foregroundColor: const Color(0xFF000C0B),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.rw),
                            ),
                          ),
                          child: Text(
                            'Redeem Reward',
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
                    ],

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
}
