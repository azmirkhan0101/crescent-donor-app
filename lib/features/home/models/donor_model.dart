/*
{
    "_id": "692148851592829c1823c4dd",
    "name": "CC Test 1",
    "image": "public/images/cbdc76580c32e7f726905f5a07893bd457477501-1763789380218.png",
    "donationDate": "2025-11-22T02:00:02.579Z",
    "amount": 2,
    "cause": "691fa5a60dba103068187fdb"
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
