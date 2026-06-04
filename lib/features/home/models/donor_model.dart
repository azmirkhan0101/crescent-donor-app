
class DonorModel {
  final String id;
  final String name;
  final String image;
  final String donationDate;
  final double amount;
  final String cause;

  DonorModel({
    required this.id,
    required this.name,
    required this.image,
    required this.donationDate,
    required this.amount,
    required this.cause,
  });

  factory DonorModel.fromJson(Map<String, dynamic> json) {
    return DonorModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      donationDate: json['donationDate'] ?? '',
      amount: (json['amount'] != null)
          ? (json['amount'] as num).toDouble()
          : 0.0,
      cause: json['cause'] ?? '',
    );
  }
}
