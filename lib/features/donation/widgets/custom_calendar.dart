import 'package:cresent_charge_user_app/features/donation/utils/donation_constants.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

/// Shows custom calendar modal that matches Figma design
void showCustomCalendarModal(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 60.rh),
        child: const CustomCalendarModal(),
      );
    },
  );
}

/// Custom Calendar Modal Widget
///
/// Modal dialog that matches the Figma design exactly
class CustomCalendarModal extends StatefulWidget {
  const CustomCalendarModal({super.key});

  @override
  State<CustomCalendarModal> createState() => _CustomCalendarModalState();
}

class _CustomCalendarModalState extends State<CustomCalendarModal> {
  late DateTime _displayDate;
  late DateTime _today;
  DateTime? _selectedDate;
  final Set<DateTime> _completedDates = {};

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    _displayDate = _today;
    _generateSampleCompletedDates();
  }

  void _generateSampleCompletedDates() {
    final now = DateTime.now();

    // Add uncompleted dates matching the image pattern
    _completedDates.addAll([
      DateTime(now.year, now.month, 4), // 4th (green border)
      DateTime(now.year, now.month, 9), // 9th (green border)
      DateTime(now.year, now.month, 12), // 12th (green border)
      DateTime(now.year, now.month, 15), // 15th (green border)
      DateTime(now.year, now.month, 17), // 17th (filled green - today)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DonationConstants.cardWhite,
        borderRadius: BorderRadius.circular(20.rw),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.rw, vertical: 24.rh),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          SizedBox(height: 28.rh),
          _buildWeekdayHeaders(),
          SizedBox(height: 20.rh),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: _previousMonth,
          child: Container(
            width: 32.rw,
            height: 32.rw,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chevron_left,
              size: 20.rw,
              color: DonationConstants.offBlack,
            ),
          ),
        ),
        Text(
          _getMonthYearText(),
          style: TextStyle(
            fontFamily: DonationFonts.familjenGrotesk,
            fontSize: 18.rfs,
            fontWeight: FontWeight.w600,
            color: DonationConstants.offBlack,
            letterSpacing: -0.2,
          ),
        ),
        GestureDetector(
          onTap: _nextMonth,
          child: Container(
            width: 32.rw,
            height: 32.rw,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chevron_right,
              size: 20.rw,
              color: DonationConstants.offBlack,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekdayHeaders() {
    const weekdays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: weekdays
          .map(
            (day) => Expanded(
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontFamily: DonationFonts.inter,
                    fontSize: 12.rfs,
                    fontWeight: FontWeight.w500,
                    color: DonationConstants.mediumGrayText,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth = _getDaysInMonth();
    final firstDayOfMonth = DateTime(_displayDate.year, _displayDate.month, 1);
    final weekdayOfFirstDay =
        firstDayOfMonth.weekday % 7; // Adjust for Sunday = 0

    // Calculate total cells needed (6 rows * 7 days)
    const totalCells = 42;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 12.rh,
        crossAxisSpacing: 8.rw,
        childAspectRatio: 1.0,
      ),
      itemCount: totalCells,
      itemBuilder: (context, index) {
        // Calculate which day this cell represents
        final dayIndex = index - weekdayOfFirstDay;

        if (dayIndex < 0 || dayIndex >= daysInMonth) {
          // Empty cell (previous/next month days)
          return const SizedBox.shrink();
        }

        final day = dayIndex + 1;
        final date = DateTime(_displayDate.year, _displayDate.month, day);

        return _buildDayCell(day, date);
      },
    );
  }

  Widget _buildDayCell(int day, DateTime date) {
    final isToday = _isSameDay(date, _today);
    final isSelected =
        _selectedDate != null && _isSameDay(date, _selectedDate!);
    final isCompleted = _completedDates.any((d) => _isSameDay(d, date));
    final isPastDate = date.isBefore(
      DateTime(_today.year, _today.month, _today.day),
    );

    Color backgroundColor = Colors.transparent;
    Color textColor = DonationConstants.offBlack;
    Color borderColor = Colors.transparent;

    // Style based on the image pattern
    if (isToday && !isCompleted) {
      // Today and completed (day 17 in image) - filled green
      backgroundColor = DonationConstants.calendarCompletedCurrentBg;
      textColor = DonationConstants.cardWhite;
      borderColor = DonationConstants.calendarCompletedCurrentBorder;
    } else if (!isCompleted && !isToday && isPastDate) {
      // Completed previous days (4, 9, 12, 15) - green border only
      backgroundColor = Colors.transparent;
      textColor = DonationConstants.calendarActiveText;
      borderColor = DonationConstants.calendarCompletedCurrentBorder;
    } else if (isPastDate && isCompleted) {
      // Past uncompleted days - gray background
      backgroundColor = DonationConstants.lightGray.withValues(alpha: 0.5);
      textColor = DonationConstants.mediumGrayText;
      borderColor = Colors.transparent;
    } else {
      // Future days - no styling
      backgroundColor = Colors.transparent;
      textColor = DonationConstants.offBlack;
      borderColor = Colors.transparent;
    }

    if (isSelected) {
      borderColor = DonationConstants.primaryPurpleDark;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = date;
        });
      },
      child: Container(
        height: 36.rh,
        width: 36.rw,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: borderColor != Colors.transparent
              ? Border.all(color: borderColor, width: 2)
              : null,
          borderRadius: BorderRadius.circular(8.rw),
        ),
        child: Center(
          child: Text(
            day.toString(),
            style: TextStyle(
              fontFamily: DonationFonts.inter,
              fontSize: 14.rfs,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  String _getMonthYearText() {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[_displayDate.month - 1]} ${_displayDate.year}';
  }

  int _getDaysInMonth() {
    return DateTime(_displayDate.year, _displayDate.month + 1, 0).day;
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void _previousMonth() {
    setState(() {
      _displayDate = DateTime(_displayDate.year, _displayDate.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _displayDate = DateTime(_displayDate.year, _displayDate.month + 1, 1);
    });
  }
}
