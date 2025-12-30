import 'dart:async';

import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/helper/date_time_converter/date_time_converter.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/claim_reward_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_all_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_reward_detail_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/utils/show_rewards_bottom_sheet.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/bottom_sheet_button_widget.dart';
import 'package:cresent_charge_user_app/features/rewards/widgets/tabbed_redemption_bottom_sheet.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/static_strings/static_strings.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RewardDetailsBottomSheet extends StatefulWidget {
  const RewardDetailsBottomSheet({
    super.key,
    required this.rewardId,
    this.userStatus,
  });

  final String rewardId;
  final String? userStatus;

  @override
  State<RewardDetailsBottomSheet> createState() =>
      _RewardDetailsBottomSheetState();
}

class _RewardDetailsBottomSheetState extends State<RewardDetailsBottomSheet> {
  final ClaimRewardController claimRewardController =
      Get.find<ClaimRewardController>();
  Timer? _timer;
  Duration _timeRemaining = Duration.zero;
  DateTime? _expiryDateTime;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Construct full image URL from relative or absolute path
  String _getFullImageUrl(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return '';
    }

    // If already a full URL (starts with http:// or https://), return as is
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return imageUrl;
    }

    // Remove leading slash if present
    final cleanPath = imageUrl.startsWith('/')
        ? imageUrl.substring(1)
        : imageUrl;

    // Construct full URL
    return '${ApiUrl.imageBaseUrl}/$cleanPath';
  }

  void _initializeCountdown(String expiryDateString) {
    final parsedDate = DateTime.tryParse(expiryDateString);
    if (parsedDate == null) return;

    final localExpiry = parsedDate.toLocal();
    if (_expiryDateTime != null && _expiryDateTime == localExpiry) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _timer?.cancel();
      setState(() {
        _expiryDateTime = localExpiry;
      });

      _updateTimeRemaining();

      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => _updateTimeRemaining(),
      );
    });
  }

  void _updateTimeRemaining() {
    if (_expiryDateTime == null) return;

    final now = DateTime.now();
    final difference = _expiryDateTime!.difference(now);

    if (!mounted) return;

    setState(() {
      _timeRemaining = difference.isNegative ? Duration.zero : difference;
    });

    if (difference.isNegative) {
      _timer?.cancel();
      _timer = null;
    }
  }

  String _formattedExpiryDateTime() {
    if (_expiryDateTime == null) return 'N/A';
    return DateFormat('h:mm a, MMM d, yyyy').format(_expiryDateTime!);
  }

  @override
  Widget build(BuildContext context) {
    return GetX<GetRewardDetailController>(
      initState: (state) {
        state.controller?.fetchRewardDetail(widget.rewardId);
      },
      builder: (controller) {
        final bool isStoreReward =
            controller.rewardDetail.value?.type == 'in-store';

        final expiryDate = controller.rewardDetail.value?.expiryDate;
        if (isStoreReward && expiryDate != null) {
          _initializeCountdown(expiryDate);
        } else if (!isStoreReward && _timer != null) {
          _timer?.cancel();
          _timer = null;
        }

        return Skeletonizer(
          enabled: controller.isLoading.value,
          child: Container(
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
              initialChildSize: isStoreReward ? 0.8 : 0.65,
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
                                  color: Colors.grey[200],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.rw),
                                  child: () {
                                    final imageUrl = _getFullImageUrl(
                                      controller
                                          .rewardDetail
                                          .value
                                          ?.business
                                          ?.coverImage,
                                    );
                                    return imageUrl.isNotEmpty
                                        ? Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Center(
                                                    child: Icon(
                                                      Icons.store,
                                                      size: 48.rfs,
                                                      color: Colors.grey[400],
                                                    ),
                                                  );
                                                },
                                          )
                                        : Center(
                                            child: Icon(
                                              Icons.store,
                                              size: 48.rfs,
                                              color: Colors.grey[400],
                                            ),
                                          );
                                  }(),
                                ),
                              ),
                              // Brand logo positioned at bottom left
                              Positioned(
                                bottom: 0.rh,
                                left: 12.rw,
                                child: Container(
                                  width: 56.rw,
                                  height: 56.rh,
                                  // padding: EdgeInsets.all(14.rw),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF000C0B),
                                    borderRadius: BorderRadius.circular(
                                      1748.25.rw,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: () {
                                      final imageUrl = _getFullImageUrl(
                                        controller.rewardDetail.value?.image,
                                      );
                                      return imageUrl.isNotEmpty
                                          ? Image.network(
                                              imageUrl,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    return Icon(
                                                      Icons.store,
                                                      size: 24.rfs,
                                                      color: Colors.grey[400],
                                                    );
                                                  },
                                            )
                                          : Icon(
                                              Icons.store,
                                              size: 24.rfs,
                                              color: Colors.grey[400],
                                            );
                                    }(),
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
                            /// Title and points row
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.rewardDetail.value?.title ??
                                        'N/A',
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
                                      controller.rewardDetail.value?.pointsCost
                                              .toString() ??
                                          'N/A',
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
                                color: isStoreReward
                                    ? const Color(0xFFFFF9E2)
                                    : const Color(0xFFE9FDF9),
                                borderRadius: BorderRadius.circular(16.rw),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isStoreReward
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
                                        isStoreReward
                                            ? 'In Store Reward'
                                            : 'Online Reward',
                                        style: AppTextStyles.f14W400(),
                                      )
                                      .fontSize(12.rfs)
                                      .color(
                                        isStoreReward
                                            ? const Color(0xFFA18200)
                                            : const Color(0xFF000C0B),
                                      ),
                                ],
                              ),
                            ),
                            8.rh.heightWidth,

                            // Description
                            Text(
                              controller.rewardDetail.value?.description ??
                                  'N/A',
                              style: AppTextStyles.f14W400().copyWith(
                                color: const Color(0xFF818F8D),
                                fontSize: isStoreReward ? 12.rfs : 14.rfs,
                                height: 1.43,
                              ),
                            ),

                            8.rh.heightWidth,

                            // Expiry
                            RichText(
                              text: TextSpan(
                                text: 'Expires: ',
                                style: TextStyle(
                                  color: const Color(0xFF818F8D),
                                  fontSize: isStoreReward ? 12.rfs : 14.rfs,
                                  fontFamily: 'Inter Display',
                                  fontWeight: FontWeight.w500,
                                  height: 1.43,
                                ),
                                children: [
                                  TextSpan(
                                    text: () {
                                      final expiryDate = controller
                                          .rewardDetail
                                          .value
                                          ?.expiryDate;
                                      if (expiryDate == null ||
                                          expiryDate.isEmpty) {
                                        return ' N/A';
                                      }
                                      try {
                                        return ' ${DateConverter.estimatedDate(DateTime.parse(expiryDate))}';
                                      } catch (e) {
                                        return ' N/A';
                                      }
                                    }(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            24.rh.heightWidth,

                            // Countdown Timer Box
                            if (isStoreReward)
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
                                            style: AppTextStyles.f14W400()
                                                .copyWith(
                                                  color: const Color(
                                                    0xFF000C0B,
                                                  ),
                                                  fontSize: 14,
                                                  height: 1.29,
                                                ),
                                          ),

                                          TextSpan(
                                            text: (_timeRemaining.inHours % 24)
                                                .toString(),
                                            style: AppTextStyles.f20w600()
                                                .copyWith(fontSize: 24.rfs),
                                          ),
                                          TextSpan(
                                            text: ' Hours  ',
                                            style: AppTextStyles.f14W400()
                                                .copyWith(
                                                  color: const Color(
                                                    0xFF000C0B,
                                                  ),
                                                  fontSize: 14,
                                                  height: 1.29,
                                                ),
                                          ),

                                          TextSpan(
                                            text:
                                                (_timeRemaining.inMinutes % 60)
                                                    .toString(),
                                            style: AppTextStyles.f20w600()
                                                .copyWith(fontSize: 24.rfs),
                                          ),
                                          TextSpan(
                                            text: ' Minutes',
                                            style: AppTextStyles.f14W400()
                                                .copyWith(
                                                  color: const Color(
                                                    0xFF000C0B,
                                                  ),
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
                                      _formattedExpiryDateTime(),
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
                    if (isStoreReward && widget.userStatus != 'redeemed')
                      Row(
                        spacing: 8.rw,
                        children: [
                          if (widget.userStatus == 'not_claimed')
                            Expanded(
                              child: BottomSheetButtonWidget(
                                backgroundColor: const Color(0xFFF5F5F5),
                                text: 'Save',
                                onTap: () async {
                                  bool success =
                                      await Get.find<ClaimRewardController>()
                                          .claimReward(widget.rewardId);
                                  if (success) {
                                    Navigator.pop(context);
                                    Get.find<GetAllRewardsController>()
                                        .fetchRewards();
                                    ToastMsg.success(
                                      'Reward Claimed Successfully!',
                                    );
                                  }
                                },
                              ),
                            ),
                          Expanded(
                            child: BottomSheetButtonWidget(
                              backgroundColor: const Color(0xFFD1FF43),
                              text: widget.userStatus == 'claimed'
                                  ? 'Redeem Reward'
                                  : ' Claim Reward',
                              onTap: () async {
                                if (widget.userStatus == 'claimed') {
                                  Navigator.pop(context);
                                  _openRedemptionBottomSheet(
                                    context,
                                    controller,
                                  );
                                  return;
                                } else {
                                  /// ===> Claim Reward Flow <===
                                  bool success =
                                      await Get.find<ClaimRewardController>()
                                          .claimReward(widget.rewardId);
                                  if (success) {
                                    Navigator.pop(context);
                                    Get.find<GetAllRewardsController>()
                                        .fetchRewards();
                                    _openRedemptionBottomSheet(
                                      context,
                                      controller,
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ).paddingX(24.rw),

                    if (!isStoreReward && widget.userStatus != 'redeemed')
                      Obx(() {
                        return BottomSheetButtonWidget(
                          text: claimRewardController.isLoading.value
                              ? "Claiming..."
                              : "Claim Reward",
                          backgroundColor: const Color(0xFFD1FF43),
                          onTap: () {
                            // Navigator.pop(context);
                            // context.safeNavigateToRoute(RoutePath.redeemFailure);
                            // if (widget.userStatus == 'not_claimed') {
                            //   ToastMsg.error(
                            //     'This is an online reward and has already been claimed.',
                            //   );
                            //   return;
                            // }
                            claimRewardController
                                .claimReward(widget.rewardId)
                                .then((success) {
                                  if (success) {
                                    Navigator.pop(context);
                                    Get.find<GetAllRewardsController>()
                                        .fetchRewards();
                                    ToastMsg.success(
                                      'Reward Claimed Successfully!',
                                    );
                                  } else {
                                    ToastMsg.error(
                                      'Failed to claim reward. Please try again.',
                                    );
                                  }
                                });
                          },
                        ).paddingX(24.rw);
                      }),

                    16.rh.heightWidth,
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _openRedemptionBottomSheet(
    BuildContext context,
    GetRewardDetailController controller,
  ) {
    final inStoreMethod =
        controller.rewardDetail.value?.inStoreRedemptionMethods;

    if (inStoreMethod == null) {
      debugPrint('Cannot open redemption bottom sheet: not an in-store reward');
      return;
    }

    showRewardsBottomSheet(
      context,
      TabbedRedemptionBottomSheet(
        redemptionCode:
            controller.rewardDetail.value?.claimDetails?.assignedCode ?? '',
        availableMethods: inStoreMethod,
      ),
    );
  }
}
