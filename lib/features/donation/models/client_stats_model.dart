class ClientStatsResponse {
  final bool success;
  final String message;
  final ClientStats data;

  ClientStatsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ClientStatsResponse.fromJson(Map<String, dynamic> json) {
    return ClientStatsResponse(
      success: json['success'],
      message: json['message'],
      data: ClientStats.fromJson(json['data']),
    );
  }
}

class ClientStats {
  final double roundUpAmount;
  final double recurringAmount;
  final double oneTimeAmount;
  final double totalDonationAmount;
  final double averageDonation;
  final int maxConsistencyStreak;
  final int currentStreak;
  final List<DonationDate> donationDates;
  final List<String> uniqueDonationDates;
  final List<DailyStat> dailyStats;
  final List<UpcomingDonation> upcomingDonations;
  final RoundUpStatusData roundUpStatusData;

  ClientStats({
    required this.roundUpAmount,
    required this.recurringAmount,
    required this.oneTimeAmount,
    required this.totalDonationAmount,
    required this.averageDonation,
    required this.maxConsistencyStreak,
    required this.currentStreak,
    required this.donationDates,
    required this.uniqueDonationDates,
    required this.dailyStats,
    required this.upcomingDonations,
    required this.roundUpStatusData,
  });

  factory ClientStats.fromJson(Map<String, dynamic> json) {
    return ClientStats(
      roundUpAmount: json['roundUpAmount'].toDouble(),
      recurringAmount: json['recurringAmount'].toDouble(),
      oneTimeAmount: json['oneTimeAmount'].toDouble(),
      totalDonationAmount: json['totalDonationAmount'].toDouble(),
      averageDonation: json['averageDonation'].toDouble(),
      maxConsistencyStreak: json['maxConsistencyStreak'],
      currentStreak: json['currentStreak'],
      donationDates: (json['donationDates'] as List)
          .map((e) => DonationDate.fromJson(e))
          .toList(),
      uniqueDonationDates: List<String>.from(json['uniqueDonationDates']),
      dailyStats: (json['dailyStats'] as List)
          .map((e) => DailyStat.fromJson(e))
          .toList(),
      upcomingDonations: (json['upcomingDonations'] as List)
          .map((e) => UpcomingDonation.fromJson(e))
          .toList(),
      roundUpStatusData: RoundUpStatusData.fromJson(json['roundUpStatusData']),
    );
  }
}

class DonationDate {
  final String date;
  final double amount;
  final String type;

  DonationDate({required this.date, required this.amount, required this.type});

  factory DonationDate.fromJson(Map<String, dynamic> json) {
    return DonationDate(
      date: json['date'],
      amount: json['amount'].toDouble(),
      type: json['type'],
    );
  }
}

class DailyStat {
  final int count;
  final String date;
  final double totalAmount;

  DailyStat({
    required this.count,
    required this.date,
    required this.totalAmount,
  });

  factory DailyStat.fromJson(Map<String, dynamic> json) {
    return DailyStat(
      count: json['count'],
      date: json['date'],
      totalAmount: json['totalAmount'].toDouble(),
    );
  }
}

class UpcomingDonation {
  final String id;
  final double amount;
  final String nextDate;
  final String causeName;
  final String organizationName;
  final String organizationLogo;
  final String organizationCoverImage;
  final String organizationRegisteredName;
  final String organizationCountry;
  final String organizationPostalCode;
  final String organizationAddress;
  final String organizationState;

  UpcomingDonation({
    required this.id,
    required this.amount,
    required this.nextDate,
    required this.causeName,
    required this.organizationName,
    required this.organizationLogo,
    required this.organizationCoverImage,
    required this.organizationRegisteredName,
    required this.organizationCountry,
    required this.organizationPostalCode,
    required this.organizationAddress,
    required this.organizationState,
  });

  factory UpcomingDonation.fromJson(Map<String, dynamic> json) {
    return UpcomingDonation(
      id: json['_id'] ?? '',
      amount: json['amount'].toDouble(),
      nextDate: json['nextDate'] ?? '',
      causeName: json['causeName'] ?? '',
      organizationName: json['organizationName'] ?? '',
      organizationLogo: json['organizationLogo'] ?? '',
      organizationCoverImage: json['organizationCoverImage'] ?? '',
      organizationRegisteredName: json['organizationRegisteredName'] ?? '',
      organizationCountry: json['organizationCountry'] ?? '',
      organizationPostalCode: json['organizationPostalCode'] ?? '',
      organizationAddress: json['organizationAddress'] ?? '',
      organizationState: json['organizationState'] ?? '',
    );
  }
}

class RoundUpStatusData {
  final bool isEnabled;
  final String organizationName;
  final String registeredCharityName;
  final int daysRemaining;
  final String nextDate;

  RoundUpStatusData({
    required this.isEnabled,
    required this.organizationName,
    required this.registeredCharityName,
    required this.daysRemaining,
    required this.nextDate,
  });

  factory RoundUpStatusData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return RoundUpStatusData(
        isEnabled: false,
        organizationName: 'N/A',
        registeredCharityName: '',
        daysRemaining: 0,
        nextDate: '',
      );
    }
    return RoundUpStatusData(
      isEnabled: json['isEnabled'] ?? false,
      organizationName: json['organizationName'] ?? 'N/A',
      registeredCharityName: json['registeredCharityName'] ?? '',
      daysRemaining: json['daysRemaining'] ?? 0,
      nextDate: json['nextDate'] ?? '',
    );
  }
}
