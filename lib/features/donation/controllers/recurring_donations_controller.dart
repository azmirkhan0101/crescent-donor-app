import 'package:cresent_charge_user_app/core/go-router/paths/route_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Recurring Donations Controller
///
/// Manages the state and business logic for recurring donations
class RecurringDonationsController extends GetxController {
  /// Total weekly amount for all recurring donations
  final RxDouble totalWeeklyAmount = 20.10.obs;

  /// Weekly amount display
  final RxDouble weeklyAmount = 20.0.obs;

  /// List of recurring donations
  final RxList<RecurringDonation> recurringDonations = <RecurringDonation>[
    RecurringDonation(
      id: '1',
      organizationName: 'Hope for Learning Foundation',
      organizationImage: "https://picsum.photos/200/300",
      amount: 30.0,
      frequency: 'month',
      schedule: 'Every month of 6th, 4:00 PM',
      backgroundColor: const Color(0xFFE8F5E8),
    ),
    RecurringDonation(
      id: '2',
      organizationName: 'Healing Hands International',
      organizationImage: "https://picsum.photos/200/300",
      amount: 50.0,
      frequency: 'quarter',
      schedule: 'Every month of 6th, 4:00 PM',
      backgroundColor: const Color(0xFFE8E8F5),
    ),
  ].obs;

  /// Handle tap on donation item
  void onDonationTapped(RecurringDonation donation) {
    // Navigate to organization donations page to see detailed history
    Get.toNamed(
      '/${RoutePath.organizationDonations}',
      arguments: {
        'organizationId': donation.id,
        'organizationName': donation.organizationName,
      },
    );
  }

  /// Calculate total weekly amount
  double calculateWeeklyAmount() {
    double total = 0.0;
    for (var donation in recurringDonations) {
      switch (donation.frequency.toLowerCase()) {
        case 'week':
          total += donation.amount;
          break;
        case 'month':
          total += donation.amount / 4.33; // Average weeks per month
          break;
        case 'quarter':
          total += donation.amount / 13; // Weeks per quarter
          break;
        case 'year':
          total += donation.amount / 52; // Weeks per year
          break;
      }
    }
    return total;
  }

  @override
  void onInit() {
    super.onInit();
    // Update weekly amount calculation
    totalWeeklyAmount.value = calculateWeeklyAmount();
  }
}

/// Model for recurring donation
class RecurringDonation {
  final String id;
  final String organizationName;
  final String organizationImage;
  final double amount;
  final String frequency; // 'week', 'month', 'quarter', 'year'
  final String schedule;
  final Color backgroundColor;

  RecurringDonation({
    required this.id,
    required this.organizationName,
    required this.organizationImage,
    required this.amount,
    required this.frequency,
    required this.schedule,
    required this.backgroundColor,
  });
}
