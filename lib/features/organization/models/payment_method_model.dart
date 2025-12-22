/*
{
  "success": true,
  "message": "Payment methods retrieved successfully!",
  "data": [
    {
      "_id": "64xyz123",
      "user": "6930158addbf3fdf987e86c4",
      "stripePaymentMethodId": "pm_1SeBFAGWHt6mKfvJkXX8QwRm",
      "stripeCustomerId": "cus_TOzhLDzvHmwhbE",
      "type": "card",
      "cardBrand": "visa",
      "cardLast4": "4242",
      "cardExpMonth": 12,
      "cardExpYear": 2027,
      "cardHolderName": "John Doe",
      "isDefault": true,
      "isActive": true,
      "createdAt": "2025-12-14T09:05:35.140Z",
      "updatedAt": "2025-12-14T09:05:35.140Z"
    }
  ]
}
*/

class PaymentMethodModel {
  final String id;
  final String user;
  final String stripePaymentMethodId;
  final String stripeCustomerId;
  final String type;
  final String cardBrand;
  final String cardLast4;
  final int cardExpMonth;
  final int cardExpYear;
  final String? cardHolderName;
  final bool isDefault;
  final bool isActive;
  final String createdAt;
  final String updatedAt;

  PaymentMethodModel({
    required this.id,
    required this.user,
    required this.stripePaymentMethodId,
    required this.stripeCustomerId,
    required this.type,
    required this.cardBrand,
    required this.cardLast4,
    required this.cardExpMonth,
    required this.cardExpYear,
    required this.cardHolderName,
    required this.isDefault,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['_id'] as String,
      user: json['user'] as String,
      stripePaymentMethodId: json['stripePaymentMethodId'] as String,
      stripeCustomerId: json['stripeCustomerId'] as String,
      type: json['type'] as String,
      cardBrand: json['cardBrand'] as String,
      cardLast4: json['cardLast4'] as String,
      cardExpMonth: json['cardExpMonth'] as int,
      cardExpYear: json['cardExpYear'] as int,
      cardHolderName: json['cardHolderName'] as String?,
      isDefault: json['isDefault'] as bool,
      isActive: json['isActive'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'stripePaymentMethodId': stripePaymentMethodId,
      'stripeCustomerId': stripeCustomerId,
      'type': type,
      'cardBrand': cardBrand,
      'cardLast4': cardLast4,
      'cardExpMonth': cardExpMonth,
      'cardExpYear': cardExpYear,
      'cardHolderName': cardHolderName,
      'isDefault': isDefault,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
