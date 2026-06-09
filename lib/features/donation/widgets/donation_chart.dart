import 'package:cresent_charge_user_app/features/donation/controllers/donation_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/helper/extension/context_extension.dart';

/// Donation Chart Widget
///
/// Creates a line chart showing donation progress over time using fl_chart
class DonationChart extends StatelessWidget {
  const DonationChart({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTab = context.isTab;
    return GetX<DonationController>(
      builder: (controller) {
        final donationData = controller.donationChartData;
        final labels = controller.donationChartLabels;
        final maxY = _calculateMaxY(donationData);
        final interval = maxY / 3;

        return Container(
          height: 216.rh,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 4.rh),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                drawHorizontalLine: true,
                horizontalInterval: interval,
                verticalInterval: 1,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: DonationConstants.lightGray.withValues(alpha: 0.4),
                    strokeWidth: 0.8,
                    dashArray: [2, 4],
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: DonationConstants.lightGray.withValues(alpha: 0.4),
                    strokeWidth: 0.8,
                    dashArray: [2, 4],
                  );
                },
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: interval,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: EdgeInsets.only(right: 1.rw),
                        child: Text(
                          '${value.toInt()}',
                          style: TextStyle(
                            fontFamily: DonationFonts.inter,
                            fontSize: isTab ? 10.sp : 10.rfs,
                            fontWeight: FontWeight.w400,
                            color: DonationConstants.offBlack,
                          ),
                        ),
                      );
                    },
                    reservedSize: 25.rw,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= 0 && index < labels.length) {
                        return Padding(
                          padding: EdgeInsets.only(top: 8.rh),
                          child: Text(
                            labels[index],
                            style: TextStyle(
                              fontFamily: DonationFonts.interDisplay,
                              fontSize: isTab ? 10.sp : 10.rfs,
                              fontWeight: FontWeight.w400,
                              color: DonationConstants.offBlack,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    reservedSize: 25.rh,
                    interval: 1,
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: _generateSpots(donationData),
                  isCurved: true,
                  curveSmoothness: 0.35,
                  color: DonationConstants.primaryPurpleDark,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 4,
                        color: DonationConstants.primaryPurpleDark,
                        strokeWidth: 0,
                      );
                    },
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        DonationConstants.primaryPurpleDark.withValues(
                          alpha: 0.12,
                        ),
                        DonationConstants.primaryPurpleDark.withValues(
                          alpha: 0.01,
                        ),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.7, 1.0],
                    ),
                  ),
                ),
              ],
              minX: 0,
              maxX: donationData.isNotEmpty
                  ? (donationData.length - 1).toDouble()
                  : 0,
              minY: 0,
              maxY: maxY,
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((barSpot) {
                      return LineTooltipItem(
                        '\$${barSpot.y.toStringAsFixed(1)}',
                        TextStyle(
                          color: DonationConstants.cardWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: isTab ? 10.sp : 12.rfs,
                          fontFamily: DonationFonts.inter,
                        ),
                      );
                    }).toList();
                  },
                ),
                getTouchedSpotIndicator:
                    (LineChartBarData barData, List<int> spotIndexes) {
                      return spotIndexes.map((spotIndex) {
                        return TouchedSpotIndicatorData(
                          FlLine(
                            color: DonationConstants.primaryPurpleDark
                                .withValues(alpha: 0.6),
                            strokeWidth: 1.5,
                            dashArray: [4, 4],
                          ),
                          FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 5,
                                color: DonationConstants.primaryPurpleDark,
                                strokeWidth: 2,
                                strokeColor: DonationConstants.cardWhite,
                              );
                            },
                          ),
                        );
                      }).toList();
                    },
              ),
            ),
          ),
        );
      },
    );
  }

  List<FlSpot> _generateSpots(List<double> donationData) {
    final List<FlSpot> spots = [];
    for (int i = 0; i < donationData.length; i++) {
      spots.add(FlSpot(i.toDouble(), donationData[i]));
    }
    return spots;
  }

  double _calculateMaxY(List<double> donationData) {
    if (donationData.isEmpty) return 15;
    final maxValue = donationData.reduce((a, b) => a > b ? a : b);
    // Round up to nearest integer and ensure it's divisible by 3
    int rounded = maxValue.ceil();
    // Find the nearest value divisible by 3 that is >= maxValue
    if (rounded % 3 != 0) {
      rounded = ((rounded / 3).ceil() * 3).toInt();
    }
    return rounded.toDouble();
  }
}
