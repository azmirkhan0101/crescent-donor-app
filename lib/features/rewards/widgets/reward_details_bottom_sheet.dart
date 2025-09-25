import 'dart:async';

import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/go-router/app_router.dart';
import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/bottom_sheet_button_widget.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  State<RewardDetailsBottomSheet> createState() =>
      _RewardDetailsBottomSheetState();
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
        initialChildSize: widget.isStoreReward ? 0.8 : 0.65,
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
                    Stack(
                      children: [
                        SizedBox(height: 146.rh),
                        // Background image
                        Container(
                          width: double.infinity,
                          height: 120.rh,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.rw),
                            image: DecorationImage(
                              image: AssetImage(Assets.rewards.groceries.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Brand logo positioned at bottom left
                        Positioned(
                          bottom: 0.rh,
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
                                colorFilter: ColorFilter.mode(
                                  const Color(0xFF000C0B),
                                  BlendMode.srcIn,
                                ),
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
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.rw,
                          vertical: 8.rh,
                        ),
                        decoration: BoxDecoration(
                          color: widget.isStoreReward
                              ? const Color(0xFFFFF9E2)
                              : const Color(0xFFE9FDF9),
                          borderRadius: BorderRadius.circular(16.rw),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            widget.isStoreReward
                                ? Assets.rewards.shopIcon.svg(
                                    width: 18.rw,
                                    height: 18.rh,
                                  )
                                : Assets.common.globe.svg(
                                    width: 18.rw,
                                    height: 18.rh,
                                    colorFilter: ColorFilter.mode(
                                      const Color(0xFF000C0B),
                                      BlendMode.srcIn,
                                    ),
                                  ),

                            4.rw.heightWidth,
                            Text(
                                  widget.isStoreReward
                                      ? 'In Store Reward'
                                      : 'Online Reward',
                                  style: AppTextStyles.f14W400(),
                                )
                                .fontSize(12.rfs)
                                .color(
                                  widget.isStoreReward
                                      ? const Color(0xFFA18200)
                                      : const Color(0xFF000C0B),
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
                            fontSize: widget.isStoreReward ? 12.rfs : 14.rfs,
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
                            fontSize: widget.isStoreReward ? 12.rfs : 14.rfs,
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
                      24.rh.heightWidth,

                      // Countdown Timer Box
                      if (widget.isStoreReward)
                        Container(
                          padding: EdgeInsets.all(16.rw),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F0FC),
                            borderRadius: BorderRadius.circular(12.rw),
                            border: Border.all(
                              color: const Color(0xFFC08FFF),
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
                                    style: AppTextStyles.f14W400(),
                                  ).color(AppColors.black),
                                ],
                              ),

                              8.rh.heightWidth,

                              RichText(
                                text: TextSpan(
                                  text: _timeRemaining.inDays.toString(),
                                  style: AppTextStyles.f20w600().copyWith(
                                    fontSize: 24.rfs,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' Days  ',
                                      style: AppTextStyles.f14W400().copyWith(
                                        color: const Color(0xFF000C0B),
                                        fontSize: 14,
                                        height: 1.29,
                                      ),
                                    ),

                                    TextSpan(
                                      text: (_timeRemaining.inHours % 24)
                                          .toString(),
                                      style: AppTextStyles.f20w600().copyWith(
                                        fontSize: 24.rfs,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Hours  ',
                                      style: AppTextStyles.f14W400().copyWith(
                                        color: const Color(0xFF000C0B),
                                        fontSize: 14,
                                        height: 1.29,
                                      ),
                                    ),

                                    TextSpan(
                                      text: (_timeRemaining.inMinutes % 60)
                                          .toString(),
                                      style: AppTextStyles.f20w600().copyWith(
                                        fontSize: 24.rfs,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Minutes',
                                      style: AppTextStyles.f14W400().copyWith(
                                        color: const Color(0xFF000C0B),
                                        fontSize: 14,
                                        height: 1.29,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Countdown display
                              12.rh.heightWidth,

                              // Specific time
                              Text(
                                ' 7:42 PM, Apr 16, 2025',
                                style: AppTextStyles.f14W400().copyWith(
                                  color: const Color(0xFF000C0B),
                                  fontSize: 14,
                                  height: 1.29,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Add some bottom padding
                      24.rh.heightWidth,
                    ],
                  ),
                ),
              ),

              // Fixed bottom section with button
              widget.isStoreReward
                  ? Row(
                      spacing: 8.rw,
                      children: [
                        Expanded(
                          child: BottomSheetButtonWidget(
                            backgroundColor: const Color(0xFFF5F5F5),
                            text: 'Save',
                            onTap: () {
                              Navigator.pop(context);
                              Get.snackbar(
                                'Saved',
                                'Reward saved to your favorites!',
                                backgroundColor: Colors.grey[100],
                                colorText: const Color(0xFF000C0B),
                                snackPosition: SnackPosition.TOP,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: BottomSheetButtonWidget(
                            backgroundColor: const Color(0xFFD1FF43),
                            text: 'Redeem',
                            onTap: () {
                              Navigator.pop(context);
                              context.safeNavigateToRoute(
                                RoutePath.redeemSuccess,
                              );
                            },
                          ),
                        ),
                      ],
                    ).paddingX(24.rw)
                  : BottomSheetButtonWidget(
                      text: "Redeem Reward",
                      backgroundColor: const Color(0xFFD1FF43),
                      onTap: () {
                        Navigator.pop(context);
                        context.safeNavigateToRoute(RoutePath.redeemFailure);
                      },
                    ).paddingX(24.rw),

              16.rh.heightWidth,
            ],
          );
        },
      ),
    );
  }
}
