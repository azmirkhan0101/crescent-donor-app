/*
{
  "success": true,
  "message": "Payment methods retrieved successfully!",
  "data": [
    {
      "_id": "64xyz123",
      "type": "card",
      "cardBrand": "visa",
      "cardLast4": "4242",
      "cardExpMonth": 12,
      "cardExpYear": 2027,
      "cardHolderName": "John Doe",
      "isDefault": true,
      "isActive": true
    },
    {
      "_id": "64xyz456",
      "type": "card",
      "cardBrand": "mastercard",
      "cardLast4": "5454",
      "cardExpMonth": 6,
      "cardExpYear": 2026,
      "cardHolderName": "John Doe",
      "isDefault": false,
      "isActive": true
    }
  ]
}
*/

class PaymentMethodModel {
  final String id;
  final String type;
  final String cardBrand;
  final String cardLast4;
  final int cardExpMonth;
  final int cardExpYear;
  final String cardHolderName;
  final bool isDefault;
  final bool isActive;

  PaymentMethodModel({
    required this.id,
    required this.type,
    required this.cardBrand,
    required this.cardLast4,
    required this.cardExpMonth,
    required this.cardExpYear,
    required this.cardHolderName,
    required this.isDefault,
    required this.isActive,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['_id'] as String,
      type: json['type'] as String,
      cardBrand: json['cardBrand'] as String,
      cardLast4: json['cardLast4'] as String,
      cardExpMonth: json['cardExpMonth'] as int,
      cardExpYear: json['cardExpYear'] as int,
      cardHolderName: json['cardHolderName'] as String,
      isDefault: json['isDefault'] as bool,
      isActive: json['isActive'] as bool,
    );
  }
}
