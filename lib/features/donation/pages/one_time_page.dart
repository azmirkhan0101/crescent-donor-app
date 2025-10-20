import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/donation/widgets/recent_donation.dart';
import 'package:cresent_charge_user_app/utils/sizer/sizer.dart';
import 'package:flutter/material.dart';

class Donation {
  final String id;
  final String organization;
  final double amount;
  final DateTime date;
  final String logo;

  const Donation({
    required this.id,
    required this.organization,
    required this.amount,
    required this.date,
    required this.logo,
  });
}

class OneTimePage extends StatelessWidget {
  OneTimePage({super.key});

  final List<Donation> donations = [
    Donation(
      id: '1',
      organization: 'Hope for Learning Foundation',
      amount: 20.0,
      date: DateTime.now().subtract(const Duration(hours: 4)),
      logo: 'assets/hope_foundation_logo.png',
    ),
    Donation(
      id: '2',
      organization: 'Hope for Learning Foundation',
      amount: 10.0,
      date: DateTime.now().subtract(const Duration(days: 2)),
      logo: 'assets/hope_foundation_logo.png',
    ),
    Donation(
      id: '3',
      organization: 'Animal Care & Shelter',
      amount: 20.2,
      date: DateTime.now().subtract(const Duration(days: 2)),
      logo: 'assets/animal_care_logo.png',
    ),
  ];

  double get totalDonations =>
      donations.fold(0, (sum, item) => sum + item.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 24),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'One Time',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      body: Column(
        children: [
          // Donation Overview Card
          Container(
            width: double.infinity,
            height: 208.rh,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17.15),
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
                Container(
                  width: 80.rw,
                  height: 80.rh,
                  padding: EdgeInsets.all(20.rh),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFE8FD),
                    shape: BoxShape.circle,
                  ),
                  child: Assets.common.gift.svg(
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF76195F),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '\$${totalDonations.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000C0B),
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '\$20 donated today',
                  style: TextStyle(
                    color: Color(0xFF818F8D),
                    fontSize: 14,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),

          // Recent Donations Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Donations',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF171717),
                    fontFamily: 'Familjen Grotesk',
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 12),

                // Donations List Container
                RecentDonation(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
