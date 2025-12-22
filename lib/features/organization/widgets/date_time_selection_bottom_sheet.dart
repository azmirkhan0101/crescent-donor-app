import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:cresent_charge_user_app/core/helper/extension/base_extension.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/donate_now_controller.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// Date & Time selection bottom sheet for recurring donations
/// Matches the Figma design exactly from node ID 249:4573
class DateTimeSelectionBottomSheet extends StatefulWidget {
  const DateTimeSelectionBottomSheet({super.key});

  @override
  State<DateTimeSelectionBottomSheet> createState() =>
      _DateTimeSelectionBottomSheetState();
}

class _DateTimeSelectionBottomSheetState
    extends State<DateTimeSelectionBottomSheet> {
  final donateNowController = Get.find<DonateNowController>();
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  late String selectedFrequency;
  late TextEditingController customIntervalController;
  late String customUnit;

  final List<String> frequencies = [
    'Daily',
    'Weekly',
    'Monthly',
    'Quarterly',
    'Yearly',
    'Custom',
  ];

  final unitOptions = ['days', 'weeks', 'months'];

  @override
  void initState() {
    super.initState();
    // Initialize from controller or set defaults
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
    selectedFrequency = 'Daily';
    customUnit = 'days';
    customIntervalController = TextEditingController(text: '1');
    donateNowController.setRecurringDateTime(
      DateTime.now().add(
        const Duration(minutes: 5),
      ), // Set to 5 minutes in the future
    );
  }

  @override
  void dispose() {
    customIntervalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700.rh, // Height from Figma: 700px
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.rw),
          topRight: Radius.circular(24.rw),
        ),
        border: Border.all(color: const Color(0xFFEBE9EC)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar and header
          _buildHeader(),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.rw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Set the date & time, and forget it!',
                    style: TextStyle(
                      fontFamily: 'Inter Display',
                      fontSize: 14.rfs,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6E6E6E),
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  SizedBox(height: 32.rh),

                  // Date and Time row
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date',
                              style: TextStyle(
                                fontFamily: 'Inter Display',
                                fontSize: 16.rfs,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF000C0B),
                              ),
                            ),
                            SizedBox(height: 8.rh),
                            _buildDateField(),
                          ],
                        ),
                      ),

                      SizedBox(width: 16.rw),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time',
                              style: TextStyle(
                                fontFamily: 'Inter Display',
                                fontSize: 16.rfs,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF000C0B),
                              ),
                            ),
                            SizedBox(height: 8.rh),
                            _buildTimeField(),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 32.rh),

                  // Frequency section
                  Text(
                    'Frequency',
                    style: TextStyle(
                      fontFamily: 'Inter Display',
                      fontSize: 16.rfs,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF000C0B),
                    ),
                  ),

                  SizedBox(height: 16.rh),

                  // Frequency options
                  _buildFrequencyOptions(),

                  SizedBox(height: 16.rh),

                  // Custom frequency UI (shown only when Custom is selected)
                  if (selectedFrequency == 'Custom') _buildCustomFrequency(),

                  Spacer(),

                  // Continue Button
                  ElevatedButton(
                    onPressed: () {
                      print(
                        '---- Continue pressed ----\n dataTime: ${donateNowController.recurringStartDateTime.value}, frequency: ${donateNowController.selectedFrequency.value}, interval: ${donateNowController.intervalValue.value}, unit: ${donateNowController.frequencyUnit.value}',
                      );

                      // _saveRecurringSettings();
                      // Navigator.pop(context); // Close the bottom sheet
                      GoRouter.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 500));
                      GoRouter.of(
                        context,
                      ).pushNamed(RoutePath.linkedPaymentAccount);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(double.maxFinite, 56.rh),
                      backgroundColor: const Color(0xFF000C0B),
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Continue'),
                  ).paddingXY(X: 56.rw),
                  8.rh.heightWidth,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.rw, vertical: 16.rh),
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

          SizedBox(height: 16.rh),

          // Title and close button
          Row(
            children: [
              Expanded(
                child: Text(
                  'Date & Time',
                  style: TextStyle(
                    fontFamily: 'Inter Display',
                    fontSize: 20.rfs,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF000C0B),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SizedBox(
                  width: 20.rw,
                  height: 20.rh,
                  child: Icon(
                    Icons.close,
                    size: 20.rfs,
                    color: const Color(0xFF000C0B),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: () async {
        final now = DateTime.now();
        final initialDate = selectedDate.isBefore(now) ? now : selectedDate;

        final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: now,
          lastDate: now.add(const Duration(days: 365)),
        );

        if (date != null) {
          setState(() {
            selectedDate = date;
          });
        }
      },
      child: Container(
        height: 52.rh,
        padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.rw),
          border: Border.all(color: const Color(0xFFE4E4E4)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}',
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 14.rfs,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF000C0B),
                ),
              ),
            ),
            Icon(
              Icons.calendar_today,
              size: 20.rfs,
              color: const Color(0xFF6E6E6E),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeField() {
    return GestureDetector(
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: selectedTime,
        );
        if (time != null) {
          setState(() {
            selectedTime = time;
          });
        }
      },
      child: Container(
        height: 52.rh,
        padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.rw),
          border: Border.all(color: const Color(0xFFE4E4E4)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontFamily: 'Inter Display',
                  fontSize: 14.rfs,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF000C0B),
                ),
              ),
            ),
            Icon(
              Icons.access_time,
              size: 20.rfs,
              color: const Color(0xFF6E6E6E),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrequencyOptions() {
    return Wrap(
      spacing: 8.rw,
      runSpacing: 12.rh,
      children: frequencies.map((frequency) {
        final isSelected = selectedFrequency == frequency;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedFrequency = frequency;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 8.rh),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFAF6FF) : Colors.white,
              borderRadius: BorderRadius.circular(24.rw),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFFC08FFF)
                    : const Color(0xFFE4E4E4),
                width: 1,
              ),
            ),
            child: Text(
              frequency,
              style: TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 14.rfs,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF000C0B),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Build custom frequency UI with dropdown and text field
  Widget _buildCustomFrequency() {
    return Container(
      padding: EdgeInsets.all(16.rw),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF6FF),
        borderRadius: BorderRadius.circular(12.rw),
        border: Border.all(color: const Color(0xFFE4E4E4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Frequency',
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 14.rfs,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF000C0B),
            ),
          ),
          SizedBox(height: 12.rh),
          Row(
            children: [
              // Interval value text field
              Expanded(
                flex: 2,
                child: TextField(
                  controller: customIntervalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter number',
                    hintStyle: TextStyle(
                      fontSize: 14.rfs,
                      color: const Color(0xFFB3B3B3),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.rw),
                      borderSide: const BorderSide(color: Color(0xFFE4E4E4)),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.rw,
                      vertical: 12.rh,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.rw),
              // Unit dropdown
              Expanded(
                flex: 2,
                child: DropdownButton2<String>(
                  value: customUnit,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        customUnit = value;
                      });
                    }
                  },
                  items: unitOptions
                      .map(
                        (unit) => DropdownMenuItem<String>(
                          value: unit,
                          child: Text(
                            unit,
                            style: TextStyle(
                              fontSize: 14.rfs,
                              color: const Color(0xFF000C0B),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  buttonStyleData: ButtonStyleData(
                    height: 48.rh,
                    padding: EdgeInsets.symmetric(horizontal: 12.rw),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.rw),
                      border: Border.all(color: const Color(0xFFE4E4E4)),
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200.rh,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.rw),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Save recurring settings to controller
  void _saveRecurringSettings() {
    // Combine selected date and time
    DateTime dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    // Ensure the date/time is in the future (at least 5 minutes from now)
    final now = DateTime.now();
    final minFutureTime = now.add(const Duration(minutes: 5));
    if (dateTime.isBefore(minFutureTime)) {
      dateTime = minFutureTime;
    }

    // Save to controller
    donateNowController.setRecurringDateTime(dateTime);
    donateNowController.setSelectedFrequency(selectedFrequency);

    // If custom, save interval and unit
    if (selectedFrequency == 'Custom') {
      final interval = int.tryParse(customIntervalController.text) ?? 1;
      donateNowController.setIntervalValue(interval);
      donateNowController.setFrequencyUnit(customUnit);
    } else {
      // Map preset frequencies to interval and unit
      switch (selectedFrequency) {
        case 'Daily':
          donateNowController.setIntervalValue(1);
          donateNowController.setFrequencyUnit('days');
          break;
        case 'Weekly':
          donateNowController.setIntervalValue(1);
          donateNowController.setFrequencyUnit('weeks');
          break;
        case 'Monthly':
          donateNowController.setIntervalValue(1);
          donateNowController.setFrequencyUnit('months');
          break;
        case 'Quarterly':
          donateNowController.setIntervalValue(3);
          donateNowController.setFrequencyUnit('months');
          break;
        case 'Yearly':
          donateNowController.setIntervalValue(12);
          donateNowController.setFrequencyUnit('months');
          break;
        default:
          break;
      }
    }

    if (kDebugMode) {
      print('Recurring settings saved:');
      print('DateTime: ${donateNowController.recurringStartDateTime.value}');
      print('Frequency: ${donateNowController.selectedFrequency.value}');
      print('Interval: ${donateNowController.intervalValue.value}');
      print('Unit: ${donateNowController.frequencyUnit.value}');
    }
  }
}
