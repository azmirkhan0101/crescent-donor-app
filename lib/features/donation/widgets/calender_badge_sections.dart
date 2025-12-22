import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/badges_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/donation_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_badges_progress_controller.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/badge_card.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/custom_calendar.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/donation_cards.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/section_header.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CalendarSection extends StatefulWidget {
  const CalendarSection({super.key});

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  late ScrollController _scrollController;
  late DateTime _currentDate;
  late List<CalendarDay> _calendarDays;

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _scrollController = ScrollController();
    _generateCalendarDays();

    // Scroll to today after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _generateCalendarDays() {
    _calendarDays = [];
    final now = DateTime.now();
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    // Generate days for the current month
    for (int day = 1; day <= endOfMonth.day; day++) {
      final date = DateTime(now.year, now.month, day);
      final dayState = _getDayState(date, now);

      _calendarDays.add(
        CalendarDay(
          date: date,
          state: dayState,
          hasIcon:
              dayState == CalendarDayState.uncompletedCurrent ||
              dayState == CalendarDayState.uncompletedPrevious,
        ),
      );
    }
  }

  CalendarDayState _getDayState(DateTime date, DateTime today) {
    final controller = Get.find<DonationController>();
    final uniqDonationDates =
        controller.clientStats.value?.uniqueDonationDates ?? [];

    final todayDate = DateTime(today.year, today.month, today.day);
    final currentDate = DateTime(date.year, date.month, date.day);

    // Check if this date has a donation
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final isCompletedDate = uniqDonationDates.any((d) => d.startsWith(dateStr));

    if (currentDate.isBefore(todayDate)) {
      // Previous days - check if there's a donation
      return isCompletedDate
          ? CalendarDayState.uncompletedPrevious
          : CalendarDayState.completed;
    } else if (currentDate.isAtSameMomentAs(todayDate)) {
      // Today - mark as current if has donation
      return isCompletedDate
          ? CalendarDayState.uncompletedCurrent
          : CalendarDayState.upcoming;
    } else {
      // Future days - always upcoming
      return CalendarDayState.upcoming;
    }
  }

  void _scrollToToday() {
    final todayIndex = _calendarDays.indexWhere(
      (day) => day.date.day == _currentDate.day,
    );

    if (todayIndex != -1) {
      final targetOffset =
          (todayIndex * (56.rw + 4.rw)) -
          (MediaQuery.of(context).size.width / 2) +
          (56.rw / 2);

      _scrollController.animateTo(
        targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX<DonationController>(
      builder: (controller) {
        // Regenerate calendar days when client stats change
        _generateCalendarDays();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Calendar',
              actionText: 'View all',
              onActionTap: () {
                showCustomCalendarModal(context);
              },
            ),
            SizedBox(height: DonationConstants.sectionSpacing.rh),
            SizedBox(
              height: 78.rh,
              child: ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: DonationConstants.paddingHorizontal.rw,
                ),
                itemCount: _calendarDays.length,
                separatorBuilder: (context, index) => SizedBox(width: 8.rw),
                itemBuilder: (context, index) {
                  final day = _calendarDays[index];
                  return CalendarDayWidget(
                    dayName: _getDayName(day.date.weekday),
                    dayNumber: day.date.day.toString(),
                    state: day.state,
                    hasIcon: day.hasIcon,
                    isToday: day.date.day == _currentDate.day,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }
}

/// Calendar Day Data Model
class CalendarDay {
  final DateTime date;
  final CalendarDayState state;
  final bool hasIcon;

  CalendarDay({required this.date, required this.state, required this.hasIcon});
}

/// Badges Section Widget
///
/// Horizontal scrolling badges with progress indicators
class BadgesSection extends StatelessWidget {
  const BadgesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<GetBadgesProgressController>(
      initState: (state) {
        state.controller!.fetchBadgesProgress();
      },
      builder: (controller) {
        return Skeletonizer(
          enabled: controller.isLoading.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: 'Badges',
                actionText: 'View all',
                onActionTap: () {
                  context.pushNamed(RoutePath.badges);
                },
              ),
              SizedBox(height: DonationConstants.sectionSpacing.rh),

              // Show empty state or badges list
              controller.badgesProgressData.isEmpty &&
                      !controller.isLoading.value
                  ? Container(
                      height: 230.rh,
                      margin: EdgeInsets.symmetric(
                        horizontal: DonationConstants.paddingHorizontal.rw,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.rw),
                        border: Border.all(
                          color: const Color(0xFFE4E4E4),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.emoji_events_outlined,
                              size: 48.rw,
                              color: const Color(0xFFB3B3B3),
                            ),
                            SizedBox(height: 12.rh),
                            Text(
                              'No badges yet',
                              style: TextStyle(
                                fontFamily: DonationFonts.familjenGrotesk,
                                fontSize: 18.rfs,
                                fontWeight: FontWeight.w600,
                                color: DonationConstants.offBlack,
                              ),
                            ),
                            SizedBox(height: 8.rh),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32.rw),
                              child: Text(
                                'Keep donating to unlock amazing badges\nand track your progress!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: DonationFonts.interDisplay,
                                  fontSize: 14.rfs,
                                  color: const Color(0xFF515A59),
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 230.rh, // Fixed height for horizontal scroll
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: DonationConstants.paddingHorizontal.rw,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.badgesProgressData.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: DonationConstants.cardSpacing.rw),
                        itemBuilder: (context, index) {
                          final badgeData =
                              controller.badgesProgressData[index];
                          final badgesController = Get.put(BadgesController());

                          // Find matching badge from local badges list
                          final badge = badgesController.badges
                              .firstWhereOrNull(
                                (b) => b.name == badgeData.badge?.name,
                              );

                          if (badge == null) return const SizedBox.shrink();

                          return SizedBox(
                            width: 180.rw, // Fixed width for each badge card
                            child: BadgeCard(
                              badge: badge,
                              badgeDataModel: badgeData,
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
