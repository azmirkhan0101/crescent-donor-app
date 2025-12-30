/*
{
    "_id": "6942d397af3e0d14a9fdf58f",
    "name": "Mostafizur",
    "image": "https://crecent-changes.s3.ap-southeast-2.amazonaws.com/profiles/clients/client-6942d044af3e0d14a9fdf55d-1766486304922",
    "donationDate": "2025-12-25T04:01:48.892Z",
    "amount": 10.5,
    "cause": "6943896c2f333b75a39823c3"
}
*/
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
