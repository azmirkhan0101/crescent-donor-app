import 'package:cresent_charge_user_app/core/theme/theme.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

/// Donation bottom sheet with donation types and options
class DonationBottomSheet extends StatefulWidget {
  final String organizationName;

  const DonationBottomSheet({super.key, required this.organizationName});

  @override
  State<DonationBottomSheet> createState() => _DonationBottomSheetState();
}

class _DonationBottomSheetState extends State<DonationBottomSheet> {
  DonationType _selectedDonationType = DonationType.recurring;
  String _selectedCause = 'Youth';
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messageController.text =
        '"Sending love & hope to everyone you\'re helping 💛."';
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border.all(color: const Color(0xFFEBE9EC)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar and header
          _buildHeader(),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.rw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Donation Type Section
                  _buildDonationTypeSection(),

                  SizedBox(height: 24.rh),

                  // Causes Section
                  _buildCausesSection(),

                  SizedBox(height: 24.rh),

                  // Message Section
                  _buildMessageSection(),

                  SizedBox(height: 24.rh),
                ],
              ),
            ),
          ),

          // Continue Button
          _buildContinueButton(),
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
              borderRadius: BorderRadius.circular(100),
            ),
          ),

          SizedBox(height: 16.rh),

          // Title and close button
          Row(
            children: [
              Expanded(
                child: Text(
                  'Donation Details',
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
                child: Container(
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

  Widget _buildDonationTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Donation Type',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 16.rfs,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000C0B),
          ),
        ),

        SizedBox(height: 8.rh),

        Text(
          'Set it and forget it!',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 14.rfs,
            fontStyle: FontStyle.italic,
            color: const Color(0xFF6E6E6E),
          ),
        ),

        SizedBox(height: 16.rh),

        Row(
          children: [
            Expanded(
              child: _buildDonationTypeCard(
                icon: Icons.sync_alt,
                title: 'Round Up',
                type: DonationType.roundUp,
                isSelected: _selectedDonationType == DonationType.roundUp,
              ),
            ),

            SizedBox(width: 8.rw),

            Expanded(
              child: _buildDonationTypeCard(
                icon: Icons.calendar_today,
                title: 'Recurring',
                type: DonationType.recurring,
                isSelected: _selectedDonationType == DonationType.recurring,
                isHighlighted: true,
              ),
            ),

            SizedBox(width: 8.rw),

            Expanded(
              child: _buildDonationTypeCard(
                icon: Icons.card_giftcard,
                title: 'One Time',
                type: DonationType.oneTime,
                isSelected: _selectedDonationType == DonationType.oneTime,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDonationTypeCard({
    required IconData icon,
    required String title,
    required DonationType type,
    required bool isSelected,
    bool isHighlighted = false,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDonationType = type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.rw),
        decoration: BoxDecoration(
          color: isSelected
              ? (isHighlighted ? const Color(0xFFFAF6FF) : Colors.white)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? (isHighlighted
                      ? const Color(0xFFC08FFF)
                      : const Color(0xFFE4E4E4))
                : const Color(0xFFE4E4E4),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color:
                        (isHighlighted
                                ? const Color(0xFFC08FFF)
                                : const Color(0xFFE4E4E4))
                            .withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            // Icon container
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40.rw,
              height: 40.rh,
              decoration: BoxDecoration(
                color: isSelected && isHighlighted
                    ? const Color(0xFFC08FFF)
                    : const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Icon(
                icon,
                size: 20.rfs,
                color: isSelected && isHighlighted
                    ? Colors.white
                    : const Color(0xFF041E1E),
              ),
            ),

            SizedBox(height: 16.rh),

            Text(
              title,
              style: TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 14.rfs,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF000C0B),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 8.rh),

            // Radio button
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 12.rw,
              height: 12.rh,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? (isHighlighted
                            ? const Color(0xFFC08FFF)
                            : const Color(0xFFEBE9EC))
                      : const Color(0xFFEBE9EC),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Container(
                      margin: EdgeInsets.all(2.rw),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isHighlighted
                            ? const Color(0xFFC08FFF)
                            : const Color(0xFFEBE9EC),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCausesSection() {
    final causes = ['Youth', 'Utilities', 'Emam'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Causes',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 16.rfs,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000C0B),
          ),
        ),

        SizedBox(height: 16.rh),

        Wrap(
          spacing: 8.rw,
          children: causes.map((cause) => _buildCauseTag(cause)).toList(),
        ),
      ],
    );
  }

  Widget _buildCauseTag(String cause) {
    final isSelected = _selectedCause == cause;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCause = cause;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 8.rh),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFAF6FF) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFC08FFF)
                : const Color(0xFFE4E4E4),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          cause,
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 14.rfs,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            color: const Color(0xFF000C0B),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add a Special Message (Optional)',
          style: TextStyle(
            fontFamily: 'Inter Display',
            fontSize: 16.rfs,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF000C0B),
          ),
        ),

        SizedBox(height: 16.rh),

        Container(
          padding: EdgeInsets.all(12.rw),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE4E4E4)),
          ),
          child: TextField(
            controller: _messageController,
            maxLines: 4,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Add your message here...',
              hintStyle: TextStyle(
                fontFamily: 'Inter Display',
                fontSize: 14.rfs,
                color: const Color(0xFF9E9E9E),
              ),
            ),
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 14.rfs,
              color: const Color(0xFF000C0B),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.rw, vertical: 16.rh),
      child: GestureDetector(
        onTap: () {
          // Handle continue action - you can add navigation logic here
          Navigator.pop(context);
          // Add your donation flow logic here
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 14.rh),
          decoration: BoxDecoration(
            color: const Color(0xFF000C0B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Continue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter Display',
              fontSize: 16.rfs,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

enum DonationType { roundUp, recurring, oneTime }
