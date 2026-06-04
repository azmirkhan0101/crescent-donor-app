
class RecentDonationsGroupModel {
  final List<RecentDonationModel> donations;
  final String title;

  RecentDonationsGroupModel({required this.donations, required this.title});

  factory RecentDonationsGroupModel.fromJson(Map<String, dynamic> json) {
    return RecentDonationsGroupModel(
      donations: ((json['donations'] ?? json['data']) as List)
          .map((e) => RecentDonationModel.fromJson(e))
          .toList(),
      title: json['title'] ?? '',
    );
  }
}

class RecentDonationModel {
  String? donationId;
  final double amount;
  final String orgName;
  String? registeredCharityName;
  final String orgLogo;
  final String timeAgo;
  String? createdAt;

  RecentDonationModel({
    this.donationId,
    required this.amount,
    required this.orgName,
    this.registeredCharityName,
    required this.orgLogo,
    required this.timeAgo,
    this.createdAt,
  });

  factory RecentDonationModel.fromJson(Map<String, dynamic> json) {
    double parsedAmount = 0;
    final amountValue = json['amount'];
    if (amountValue is num) {
      parsedAmount = amountValue.toDouble();
    } else if (amountValue is String) {
      // Parse string like "+$2" or "$2"
      String cleanAmount = amountValue.replaceAll(RegExp(r'[^\d.]'), '');
      parsedAmount = double.tryParse(cleanAmount) ?? 0;
    }

    return RecentDonationModel(
      donationId: json['donationId'],
      amount: parsedAmount,
      orgName: json['orgName'] ?? '',
      registeredCharityName: json['registeredCharityName'],
      orgLogo: json['orgLogo'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
      createdAt: json['createdAt'],
    );
  }
}
