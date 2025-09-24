import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/core/routes/route_path.dart';
import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/custom_calendar.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/donation_cards.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Section Header Widget
///
/// Reusable widget for section titles with optional "View all" action
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DonationConstants.paddingHorizontal.rw,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: DonationFonts.familjenGrotesk,
              fontSize: DonationConstants.fontSize20.rfs,
              fontWeight: FontWeight.w600,
              color: DonationConstants.neutralGray,
              letterSpacing: -0.2,
              height: 24 / 20,
            ),
          ),
          if (actionText != null)
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                actionText!,
                style: TextStyle(
                  fontFamily: DonationFonts.interDisplay,
                  fontSize: DonationConstants.fontSize14.rfs,
                  fontWeight: FontWeight.w500,
                  color: DonationConstants.primaryPurple,
                  height: 20 / 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Section Container Widget
///
/// Wrapper for sections with consistent padding
class SectionContainer extends StatelessWidget {
  final Widget child;

  const SectionContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DonationConstants.paddingHorizontal.rw,
      ),
      child: child,
    );
  }
}

/// Overview Section Widget
///
/// Contains round-up card and two small cards (Recurring & One Time)
class OverviewSection extends StatelessWidget {
  const OverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Overview',
          actionText: 'View all',
          onActionTap: () {
            // Handle view all action
          },
        ),
        SizedBox(height: DonationConstants.sectionSpacing.rh),
        SectionContainer(
          child: Column(
            children: [
              // Round Up Card (full width)
              RoundUpCard(
                roundUpAmount: '40.75',
                donationOrganization: 'HFL Foundation',
                daysUntilDonation: '18',
                onTap: () {
                  context.pushNamed(RoutePath.roundUp);
                },
              ),
              SizedBox(height: DonationConstants.cardSpacing.rh),
              // Two small cards in a row
              Row(
                children: [
                  SmallDonationCard(
                    title: 'Recurring',
                    amount: '20',
                    backgroundColor: DonationConstants.recurringCardBg,
                    borderColor: DonationConstants.recurringBorder,
                    amountColor: DonationConstants.recurringAmountColor,
                    icon: Assets.common.calendar.path,
                    onTap: () {
                      context.pushNamed(RoutePath.recurringDonations);
                    },
                  ),
                  SizedBox(width: DonationConstants.cardSpacing.rw),
                  SmallDonationCard(
                    title: 'One Time',
                    amount: '60',
                    backgroundColor: DonationConstants.oneTimeCardBg,
                    borderColor: DonationConstants.oneTimeBorder,
                    amountColor: DonationConstants.oneTimeAmountColor,
                    icon: Assets.common.gift.path,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Calendar Section Widget
///
/// Shows scrollable calendar view with full month dates and today in the middle
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
              dayState == CalendarDayState.completed,
        ),
      );
    }
  }

  CalendarDayState _getDayState(DateTime date, DateTime today) {
    final todayDate = DateTime(today.year, today.month, today.day);
    final currentDate = DateTime(date.year, date.month, date.day);

    if (currentDate.isBefore(todayDate)) {
      // Previous days - could be completed or uncompleted (for demo, showing some as completed)
      // In real app, this would be based on actual donation data
      return date.day % 2 == 0
          ? CalendarDayState.uncompletedPrevious
          : CalendarDayState.completed;
    } else if (currentDate.isAtSameMomentAs(todayDate)) {
      // Today - could be completed current or uncompleted based on donation status
      // For demo, showing as completed current
      return CalendarDayState.uncompletedCurrent;
    } else {
      // Future days - always upcoming (cannot be uncompleted)
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Badges',
          actionText: 'View all',
          onActionTap: () {
            // Handle view all action
          },
        ),
        SizedBox(height: DonationConstants.sectionSpacing.rh),
        SizedBox(
          height: 230.rh, // Fixed height for horizontal scroll
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: DonationConstants.paddingHorizontal.rw,
            ),
            scrollDirection: Axis.horizontal,
            children: [
              BadgeCard(
                badgeName: 'Badge no. 01',
                progressText: '3/5',
                description: 'Donate 5 times in a month to unlock Silver.',
                progress: 0.6, // 3/5
                badgeImage: Assets.donation.badgeNo1.path,
              ),
              SizedBox(width: DonationConstants.cardSpacing.rw),
              BadgeCard(
                badgeName: 'Round-Up Rebel',
                progressText: null,
                description:
                    'Earned for enabling round-up donations for 30 days.',
                progress: 1.0, // Completed
                badgeImage: Assets.donation.badgeRoundUp.path,
              ),
              SizedBox(width: DonationConstants.cardSpacing.rw),
              BadgeCard(
                badgeName: 'Badge no. 04',
                progressText: '3/5',
                description: 'Donate 5 times in a month to unlock Silver.',
                progress: 0.6, // 3/5
                badgeImage: Assets.donation.badgeNo4.path,
              ),
              SizedBox(width: DonationConstants.cardSpacing.rw),
              BadgeCard(
                badgeName: 'Badge no. 10',
                progressText: '3/5',
                description: 'Donate 5 times in a month to unlock Silver.',
                progress: 0.6, // 3/5
                badgeImage: Assets.donation.badgeNo10.path,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
