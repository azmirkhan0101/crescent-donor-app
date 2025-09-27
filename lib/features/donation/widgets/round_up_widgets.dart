import 'dart:math' as math;

import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/round_up_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/utils/app_colors/app_colors.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:cresent_charge_user_app/utils/text_style/text_style.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

/// Round Up Progress Chart Widget
///
/// Displays the current round up progress with a circular design
class RoundUpProgressChart extends StatelessWidget {
  final double currentAmount;
  final double targetAmount;
  final double recentlyRoundedUp;
  final RoundUpController controller;

  const RoundUpProgressChart({
    super.key,
    required this.currentAmount,
    required this.targetAmount,
    required this.recentlyRoundedUp,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.toggleProgressView(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.rw),
        decoration: BoxDecoration(
          color: DonationConstants.cardWhite,
          borderRadius: BorderRadius.circular(17.15),
          border: Border.all(color: const Color(0xFFEDEDED), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 0.715,
              offset: const Offset(0, 0.715),
            ),
          ],
        ),
        child: Column(
          children: [
            // Circular progress icon
            Container(
              padding: EdgeInsets.all(20.rw),
              decoration: BoxDecoration(
                color: const Color(0xFFD5EDFF),
                borderRadius: BorderRadius.circular(99.rw),
              ),
              child: Assets.common.coins.svg(
                width: 40.rw,
                height: 40.rh,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF2196F3),
                  BlendMode.srcIn,
                ),
              ),
            ),

            SizedBox(height: 16.rh),

            // Amount text
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\$${currentAmount.toInt()} ',
                    style: TextStyle(
                      fontFamily: DonationFonts.interDisplay,
                      fontSize: 24.rfs,
                      fontWeight: FontWeight.w600,
                      color: DonationConstants.offBlack,
                      height: 28 / 24,
                    ),
                  ),
                  TextSpan(
                    text: 'of \$${targetAmount.toInt()}',
                    style: TextStyle(
                      fontFamily: DonationFonts.interDisplay,
                      fontSize: 24.rfs,
                      fontWeight: FontWeight.w600,
                      color: DonationConstants.offBlack.withValues(alpha: 0.25),
                      height: 28 / 24,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8.rh),

            // Recently rounded up text
            Text(
              '\$$recentlyRoundedUp recently rounded up',
              style: TextStyle(
                fontFamily: DonationFonts.interDisplay,
                fontSize: 14.rfs,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF818F8D),
                height: 18 / 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Detailed Progress Chart Widget
///
/// Shows detailed donation statistics with semicircular progress chart
class DetailedProgressChart extends StatelessWidget {
  final double totalAmount;
  final int progressPercentage;
  final double todaysRoundUp;
  final int daysLeft;
  final RoundUpController controller;

  const DetailedProgressChart({
    super.key,
    required this.totalAmount,
    required this.progressPercentage,
    required this.todaysRoundUp,
    required this.daysLeft,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.toggleProgressView(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.rw),
        decoration: BoxDecoration(
          color: DonationConstants.cardWhite,
          borderRadius: BorderRadius.circular(12.rw),
          border: Border.all(color: const Color(0xFFEDEDED), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 0.715,
              offset: const Offset(0, 0.715),
            ),
          ],
        ),
        child: Column(
          children: [
            // Change icon
            Container(
              padding: EdgeInsets.all(16.rw),
              decoration: BoxDecoration(
                color: const Color(0xFFD5EDFF),
                borderRadius: BorderRadius.circular(79.2.rw),
              ),
              child: Assets.common.coins.svg(
                width: 32.rw,
                height: 32.rh,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF006FCE),
                  BlendMode.srcIn,
                ),
              ),
            ),

            SizedBox(height: 16.rh),

            // Text section
            Column(
              children: [
                Text(
                  'You\'ve donated a total of',
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: 12.rfs,
                    fontWeight: FontWeight.w400,
                    color: DonationConstants.offBlack,
                    height: 16 / 12,
                  ),
                ),
                SizedBox(height: 4.rh),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '\$',
                        style: TextStyle(
                          fontFamily: DonationFonts.familjenGrotesk,
                          fontSize: 24.rfs,
                          fontWeight: FontWeight.w700,
                          color: DonationConstants.offBlack.withValues(
                            alpha: 0.25,
                          ),
                          height: 28 / 24,
                        ),
                      ),
                      TextSpan(
                        text: totalAmount.toStringAsFixed(2),
                        style: TextStyle(
                          fontFamily: DonationFonts.familjenGrotesk,
                          fontSize: 24.rfs,
                          fontWeight: FontWeight.w700,
                          color: DonationConstants.offBlack,
                          height: 28 / 24,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.rh),
                Text(
                  'in last 30 days.',
                  style: TextStyle(
                    fontFamily: DonationFonts.interDisplay,
                    fontSize: 12.rfs,
                    fontWeight: FontWeight.w400,
                    color: DonationConstants.offBlack,
                    height: 16 / 12,
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.rh),

            Stack(
              children: [
                CircularStepProgressIndicator(
                  totalSteps: 22,
                  currentStep: 16,
                  stepSize: 66.rh,
                  selectedColor: Color(0xFF1B7ED3),
                  unselectedColor: Color(0xFFD9DBDA),
                  // padding: math.pi / 80,
                  padding: math.pi / 80,
                  width: 300.rw,
                  height: 300.rh,
                  // startingAngle: -math.pi * 2 / 3,
                  startingAngle: math.pi / 2,
                  // arcSize: math.pi * 2 / 3 * 2,
                  arcSize: math.pi * 2 / 3 * 1.5,
                ),
                Positioned(
                  bottom: 150.rh,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      '60%',
                      style: AppTextStyles.f20w600(),
                    ).fontSize(32.rfs),
                  ),
                ),

                Positioned(
                  bottom: 140.rh,
                  child: DottedBorder(
                    options: CustomPathDottedBorderOptions(
                      padding: const EdgeInsets.all(8),
                      color: AppColors.grayColor,
                      strokeWidth: 0.2,
                      dashPattern: [10, 5],
                      customPath: (size) => Path()
                        ..moveTo(0, size.height)
                        ..relativeLineTo(size.width, 0),
                    ),
                    child: SizedBox(width: 300.rw),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBulletPoint(
                        '• Deposit triggers when you hit \$50 or after 30 days — whichever comes first!',
                      ),
                      SizedBox(height: 4.rh),
                      _buildBulletPoint(
                        '• Progress resets after deposit — keep the momentum going 🚀',
                      ),

                      SizedBox(height: 16.rh),

                      // Another divider line
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: const Color(0xFFEDEDED),
                      ),

                      SizedBox(height: 16.rh),
                    ],
                  ),
                ),
              ],
            ),

            // Stats section
            Column(
              children: [
                Row(
                  children: [
                    Text('💰 ', style: TextStyle(fontSize: 12.rfs)),
                    Text(
                      '\$${todaysRoundUp.toStringAsFixed(2)} rounded up today',
                      style: TextStyle(
                        fontFamily: DonationFonts.interDisplay,
                        fontSize: 12.rfs,
                        fontWeight: FontWeight.w500,
                        color: DonationConstants.offBlack,
                        height: 16 / 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.rh),
                Row(
                  children: [
                    Text('📆 ', style: TextStyle(fontSize: 12.rfs)),
                    Text(
                      '$daysLeft days left to auto-donate',
                      style: TextStyle(
                        fontFamily: DonationFonts.interDisplay,
                        fontSize: 12.rfs,
                        fontWeight: FontWeight.w500,
                        color: DonationConstants.offBlack,
                        height: 16 / 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: DonationFonts.interDisplay,
        fontSize: 12.rfs,
        fontWeight: FontWeight.w400,
        color: DonationConstants.offBlack,
        height: 16 / 12,
      ),
    );
  }
}

/// Custom painter for semicircle progress chart
class SemicircleProgressPainter extends CustomPainter {
  final double progress;

  SemicircleProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 8.0;
    final Paint backgroundPaint = Paint()
      ..color = const Color(0xFFE5E5E5)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [const Color(0xFF2196F3), const Color(0xFF1976D2)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Rect rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      (size.height - strokeWidth / 2) * 2,
    );

    // Draw background semicircle
    canvas.drawArc(rect, math.pi, math.pi, false, backgroundPaint);

    // Draw progress semicircle
    canvas.drawArc(rect, math.pi, math.pi * progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// Recent Activity List Widget
///
/// Displays the list of recent round up activities
class RecentActivityList extends StatelessWidget {
  final List<RecentActivity> activities;
  final RoundUpController controller;

  const RecentActivityList({
    super.key,
    required this.activities,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.rw),
      decoration: BoxDecoration(
        color: DonationConstants.cardWhite,
        borderRadius: BorderRadius.circular(12.rw),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Today section
          Padding(
            padding: EdgeInsets.only(left: 8.rw, bottom: 8.rh),
            child: Text(
              'Today',
              style: TextStyle(
                fontFamily: DonationFonts.interDisplay,
                fontSize: 11.rfs,
                fontWeight: FontWeight.w500,
                color: Colors.grey.withValues(alpha: 0.6),
                height: 16 / 11,
              ),
            ),
          ),

          // Activities list
          ...activities.asMap().entries.map(
            (entry) => ActivityItem(
              activity: entry.value,
              index: entry.key,
              controller: controller,
            ),
          ),

          SizedBox(height: 16.rh),

          // 20 July section (placeholder for earlier activities)
          Padding(
            padding: EdgeInsets.only(left: 8.rw, bottom: 8.rh),
            child: Text(
              '20 July',
              style: TextStyle(
                fontFamily: DonationFonts.interDisplay,
                fontSize: 11.rfs,
                fontWeight: FontWeight.w500,
                color: Colors.grey.withValues(alpha: 0.6),
                height: 16 / 11,
              ),
            ),
          ),

          // Earlier activities from controller
          ...controller.earlierActivities.asMap().entries.map(
            (entry) => ActivityItem(
              activity: entry.value,
              index:
                  activities.length +
                  entry.key, // Offset by today's activities length
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual Activity Item Widget
///
/// Displays a single round up activity
class ActivityItem extends StatelessWidget {
  final RecentActivity activity;
  final int index;
  final dynamic
  controller; // Can be any controller that implements ActivityExpansionMixin

  const ActivityItem({
    super.key,
    required this.activity,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final String activityKey = controller.getActivityKey(activity, index);

    return GetBuilder(
      init: controller,
      builder: (_) {
        final bool isExpanded = controller.isActivityExpanded(activityKey);

        return GestureDetector(
          onTap: () => controller.toggleActivityExpansion(activityKey),
          child: Container(
            margin: EdgeInsets.only(bottom: 8.rh),
            padding: EdgeInsets.all(8.rw),
            decoration: BoxDecoration(
              color: isExpanded
                  ? const Color(0xFFF9F7F9)
                  : DonationConstants.cardWhite,
              borderRadius: BorderRadius.circular(12.rw),
            ),
            child: Column(
              children: [
                // Main activity row
                Row(
                  children: [
                    // Brand logo
                    Container(
                      width: 44.rw,
                      height: 44.rh,
                      padding: EdgeInsets.all(11.rw),
                      decoration: BoxDecoration(
                        color: activity.brandColor,
                        borderRadius: BorderRadius.circular(22.rw),
                      ),
                      child: SvgPicture.asset(
                        activity.brandLogo,
                        width: 44.rw,
                        height: 44.rh,
                      ),
                    ),

                    // Container(
                    //   width: 44.rw,
                    //   height: 44.rh,
                    //   padding: EdgeInsets.all(11.rw),
                    //   decoration: BoxDecoration(
                    //     color: activity.brandColor,
                    //     borderRadius: BorderRadius.circular(22.rw),
                    //   ),
                    //   child: SvgPicture.asset(activity.brandLogo),
                    // ),
                    SizedBox(width: 8.rw),

                    // Activity details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Brand name and purchase amount
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                activity.brandName,
                                style: TextStyle(
                                  fontFamily: DonationFonts.interDisplay,
                                  fontSize: 14.rfs,
                                  fontWeight: FontWeight.w500,
                                  color: DonationConstants.offBlack,
                                  height: 18 / 14,
                                ),
                              ),
                              Text(
                                '\$${activity.purchaseAmount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontFamily: DonationFonts.interDisplay,
                                  fontSize: 12.rfs,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  height: 16 / 12,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 8.rh),

                          // Time and round up amount
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                activity.timeAgo,
                                style: TextStyle(
                                  fontFamily: DonationFonts.interDisplay,
                                  fontSize: 12.rfs,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  height: 16 / 12,
                                ),
                              ),
                              Text(
                                '+\$${activity.roundUpAmount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontFamily: DonationFonts.interDisplay,
                                  fontSize: 12.rfs,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1AC461),
                                  height: 16 / 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 8.rw),

                    // Chevron icon
                    Assets.common.arrowDown.svg(
                      width: 16.rw,
                      height: 16.rh,
                      colorFilter: ColorFilter.mode(
                        Colors.grey.withValues(alpha: 0.5),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),

                // Additional details for expanded activities
                if (isExpanded) ...[
                  SizedBox(height: 8.rh),

                  // Divider
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: const Color(0xFFEDEDED),
                  ),

                  SizedBox(height: 8.rh),

                  // Donated to information
                  if (activity.donatedTo != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Donated to:',
                          style: TextStyle(
                            fontFamily: DonationFonts.interDisplay,
                            fontSize: 12.rfs,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            height: 16 / 12,
                          ),
                        ),
                        Text(
                          activity.donatedTo!,
                          style: TextStyle(
                            fontFamily: DonationFonts.interDisplay,
                            fontSize: 12.rfs,
                            fontWeight: FontWeight.w400,
                            color: DonationConstants.offBlack,
                            height: 16 / 12,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.rh),
                  ],

                  // Timestamp information
                  if (activity.timestamp != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Timestamp:',
                          style: TextStyle(
                            fontFamily: DonationFonts.interDisplay,
                            fontSize: 12.rfs,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            height: 16 / 12,
                          ),
                        ),
                        Text(
                          activity.timestamp!,
                          style: TextStyle(
                            fontFamily: DonationFonts.interDisplay,
                            fontSize: 12.rfs,
                            fontWeight: FontWeight.w400,
                            color: DonationConstants.offBlack,
                            height: 16 / 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Step Progress Semicircle Painter
///
/// Creates a semicircle progress indicator with individual step segments
/// matching the exact design from the provided SVG
class StepProgressSemicirclePainter extends CustomPainter {
  final double progress;
  static const int totalSteps = 16; // Total number of segments

  StepProgressSemicirclePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Colors for different states
    const activeColor = Color(0xFF006FCE); // Blue color from SVG
    const inactiveColor = Color(0x26000C0B); // Gray color with opacity from SVG

    // Calculate how many steps should be active
    final activeSteps = (progress * totalSteps).round();

    // Draw each step segment
    for (int i = 0; i < totalSteps; i++) {
      final isActive = i < activeSteps;
      final paint = Paint()
        ..color = isActive ? activeColor : inactiveColor
        ..style = PaintingStyle.fill;

      // Calculate the angle for this segment
      // Start from left (180 degrees) and go to right (0 degrees) - TOP semicircle
      final startAngle = math.pi + (i * math.pi / totalSteps);
      final sweepAngle = math.pi / totalSteps;

      // Create the segment path based on SVG coordinates
      final path = _createSegmentPath(
        center,
        radius,
        startAngle,
        sweepAngle,
        i,
      );

      // Add gradient effect for active segments
      if (isActive) {
        final gradient = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [activeColor.withOpacity(0.05), activeColor.withOpacity(0.4)],
        );

        final gradientPaint = Paint()
          ..shader = gradient.createShader(
            Rect.fromCircle(center: center, radius: radius),
          );

        canvas.drawPath(path, gradientPaint);
      } else {
        canvas.drawPath(path, paint);
      }
    }
  }

  Path _createSegmentPath(
    Offset center,
    double radius,
    double startAngle,
    double sweepAngle,
    int segmentIndex,
  ) {
    final path = Path();

    // Calculate segment dimensions based on position (matching SVG design)
    final segmentWidth = _getSegmentWidth(segmentIndex);
    final segmentHeight = _getSegmentHeight(segmentIndex);

    // Calculate the position for this segment
    final segmentRadius = radius * 0.7; // Distance from center
    final segmentCenter = Offset(
      center.dx + math.cos(startAngle + sweepAngle / 2) * segmentRadius,
      center.dy + math.sin(startAngle + sweepAngle / 2) * segmentRadius,
    );

    // Create rounded rectangle path for each segment
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: segmentCenter,
        width: segmentWidth,
        height: segmentHeight,
      ),
      const Radius.circular(4),
    );

    path.addRRect(rect);

    // Rotate the path to match the angle
    final matrix = Matrix4.identity();
    matrix.translate(segmentCenter.dx, segmentCenter.dy);
    matrix.rotateZ(startAngle + sweepAngle / 2 - math.pi / 2);
    matrix.translate(-segmentCenter.dx, -segmentCenter.dy);

    return path.transform(matrix.storage);
  }

  double _getSegmentWidth(int index) {
    // Width varies based on position - center segments are wider
    final distanceFromCenter = (index - 7.5).abs();
    return 8.0 + (12.0 * (1 - distanceFromCenter / 8));
  }

  double _getSegmentHeight(int index) {
    // Height varies based on position - outer segments are taller
    final distanceFromCenter = (index - 7.5).abs();
    return 35.0 + (15.0 * (distanceFromCenter / 8));
  }

  @override
  bool shouldRepaint(StepProgressSemicirclePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
