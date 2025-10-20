import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Organization Donations Controller
///
/// Manages the state and data for organization donations page
/// including upcoming and previous donations with their status
class OrganizationDonationsController extends GetxController {
  // Organization data
  late final OrganizationData organization;

  // Donations lists
  final RxList<OrganizationDonation> upcomingDonations =
      <OrganizationDonation>[].obs;
  final RxList<OrganizationDonation> previousDonations =
      <OrganizationDonation>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  /// Initialize sample data based on Figma design
  void _initializeData() {
    // Sample organization data
    organization = OrganizationData(
      id: '1',
      name: 'Hope for Learning Foundation',
      description: 'Turning hope into opportunity through education.',
      coverImage: 'assets/sample/org-cover.jpg',
      logoImage: 'assets/sample/hope-learning-logo.jpg',
      isVerified: true,
      tags: [
        OrganizationTag(emoji: '📚', label: 'Education', isHighlighted: true),
        OrganizationTag(emoji: '🌍', label: 'South Asia', isHighlighted: false),
      ],
    );

    // Sample upcoming donations
    upcomingDonations.assignAll([
      OrganizationDonation(
        id: '1',
        title: 'Monthly Recurring Donation',
        amount: 30.0,
        date: DateTime(2025, 8, 17),
        time: '4:00 PM',
        status: DonationStatus.upcoming,
        dayName: 'Wed',
        dayNumber: '17',
      ),
    ]);

    // Sample previous donations
    previousDonations.assignAll([
      OrganizationDonation(
        id: '2',
        title: 'Monthly Recurring Donation',
        amount: 30.0,
        date: DateTime(2025, 7, 15),
        time: '4:00 PM',
        status: DonationStatus.successful,
        dayName: 'Mon',
        dayNumber: '15',
      ),
      OrganizationDonation(
        id: '3',
        title: 'Monthly Recurring Donation',
        amount: 30.0,
        date: DateTime(2025, 6, 16),
        time: '4:00 PM',
        status: DonationStatus.failed,
        dayName: 'Tue',
        dayNumber: '16',
      ),
    ]);
  }

  /// Handle donation item tap
  void onDonationTapped(OrganizationDonation donation) {
    // TODO: Navigate to donation details or show more info
    Get.snackbar(
      'Donation Details',
      'Donation ID: ${donation.id}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

/// Organization Data Model
class OrganizationData {
  final String id;
  final String name;
  final String description;
  final String coverImage;
  final String logoImage;
  final bool isVerified;
  final List<OrganizationTag> tags;

  OrganizationData({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImage,
    required this.logoImage,
    required this.isVerified,
    required this.tags,
  });
}

/// Organization Tag Model
class OrganizationTag {
  final String emoji;
  final String label;
  final bool isHighlighted;

  OrganizationTag({
    required this.emoji,
    required this.label,
    required this.isHighlighted,
  });
}

/// Organization Donation Model
class OrganizationDonation {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String time;
  final DonationStatus status;
  final String dayName;
  final String dayNumber;

  OrganizationDonation({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.time,
    required this.status,
    required this.dayName,
    required this.dayNumber,
  });

  /// Format date for display (e.g., "6 August")
  String get formattedDate {
    final months = [
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
    return '${date.day} ${months[date.month - 1]}';
  }
}

/// Donation Status Enum
enum DonationStatus { upcoming, successful, failed }

/// Extension to get display properties for donation status
extension DonationStatusExtension on DonationStatus {
  String get displayName {
    switch (this) {
      case DonationStatus.upcoming:
        return 'Upcoming';
      case DonationStatus.successful:
        return 'Successful';
      case DonationStatus.failed:
        return 'Failed';
    }
  }

  Color get backgroundColor {
    switch (this) {
      case DonationStatus.upcoming:
        return const Color(0x40A6F6E6); // rgba(166,246,230,0.25)
      case DonationStatus.successful:
        return const Color(0x40A6F6E6); // rgba(166,246,230,0.25)
      case DonationStatus.failed:
        return const Color(0x14F0323C); // rgba(240,50,60,0.08)
    }
  }

  Color get textColor {
    switch (this) {
      case DonationStatus.upcoming:
        return const Color(0xFF000C0B);
      case DonationStatus.successful:
        return const Color(0xFF1AC461);
      case DonationStatus.failed:
        return const Color(0xFFF0323C);
    }
  }

  Color get amountColor {
    switch (this) {
      case DonationStatus.upcoming:
        return const Color(0xFF000C0B);
      case DonationStatus.successful:
        return const Color(0xFF1AC461);
      case DonationStatus.failed:
        return const Color(0xFF000C0B);
    }
  }

  String get amountPrefix {
    switch (this) {
      case DonationStatus.upcoming:
        return '\$';
      case DonationStatus.successful:
        return '+\$';
      case DonationStatus.failed:
        return '';
    }
  }

  String get amountDisplay {
    switch (this) {
      case DonationStatus.failed:
        return '-';
      default:
        return '';
    }
  }
}
