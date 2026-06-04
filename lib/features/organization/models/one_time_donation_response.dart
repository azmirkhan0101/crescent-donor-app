
class OneTimeDonationModel {
  Donation? donation;
  Payment? payment;

  OneTimeDonationModel({this.donation, this.payment});

  factory OneTimeDonationModel.fromJson(Map<String, dynamic> json) {
    return OneTimeDonationModel(
      donation: json['donation'] != null
          ? Donation.fromJson(json['donation'])
          : null,
      payment: json['payment'] != null
          ? Payment.fromJson(json['payment'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (donation != null) {
      data['donation'] = donation!.toJson();
    }
    if (payment != null) {
      data['payment'] = payment!.toJson();
    }
    return data;
  }
}

class Donation {
  String? id;
  String? donor;
  String? organization;
  String? cause;
  String? donationType;
  num? amount; // Using num to handle both int and double safely
  String? currency;
  String? status;
  String? stripeCustomerId;
  String? stripePaymentMethodId;
  int? pointsEarned;
  String? connectedAccountId;
  List<String>? roundUpTransactionIds;
  bool? receiptGenerated;
  String? idempotencyKey;
  int? paymentAttempts;
  DateTime? createdAt;
  DateTime? donationDate;
  DateTime? updatedAt;
  int? v;
  String? stripePaymentIntentId;

  Donation({
    this.id,
    this.donor,
    this.organization,
    this.cause,
    this.donationType,
    this.amount,
    this.currency,
    this.status,
    this.stripeCustomerId,
    this.stripePaymentMethodId,
    this.pointsEarned,
    this.connectedAccountId,
    this.roundUpTransactionIds,
    this.receiptGenerated,
    this.idempotencyKey,
    this.paymentAttempts,
    this.createdAt,
    this.donationDate,
    this.updatedAt,
    this.v,
    this.stripePaymentIntentId,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['_id'], // Mapping _id from JSON to id
      donor: json['donor'],
      organization: json['organization'],
      cause: json['cause'],
      donationType: json['donationType'],
      amount: json['amount'],
      currency: json['currency'],
      status: json['status'],
      stripeCustomerId: json['stripeCustomerId'],
      stripePaymentMethodId: json['stripePaymentMethodId'],
      pointsEarned: json['pointsEarned'],
      connectedAccountId: json['connectedAccountId'],
      roundUpTransactionIds: json['roundUpTransactionIds'] != null
          ? List<String>.from(json['roundUpTransactionIds'])
          : [],
      receiptGenerated: json['receiptGenerated'],
      idempotencyKey: json['idempotencyKey'],
      paymentAttempts: json['paymentAttempts'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      donationDate: json['donationDate'] != null
          ? DateTime.tryParse(json['donationDate'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      v: json['__v'],
      stripePaymentIntentId: json['stripePaymentIntentId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['donor'] = donor;
    data['organization'] = organization;
    data['cause'] = cause;
    data['donationType'] = donationType;
    data['amount'] = amount;
    data['currency'] = currency;
    data['status'] = status;
    data['stripeCustomerId'] = stripeCustomerId;
    data['stripePaymentMethodId'] = stripePaymentMethodId;
    data['pointsEarned'] = pointsEarned;
    data['connectedAccountId'] = connectedAccountId;
    data['roundUpTransactionIds'] = roundUpTransactionIds;
    data['receiptGenerated'] = receiptGenerated;
    data['idempotencyKey'] = idempotencyKey;
    data['paymentAttempts'] = paymentAttempts;
    data['createdAt'] = createdAt?.toIso8601String();
    data['donationDate'] = donationDate?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['__v'] = v;
    data['stripePaymentIntentId'] = stripePaymentIntentId;
    return data;
  }
}

class Payment {
  String? clientSecret;
  String? paymentIntentId;
  String? status;

  Payment({this.clientSecret, this.paymentIntentId, this.status});

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      clientSecret: json['clientSecret'],
      paymentIntentId: json['paymentIntentId'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clientSecret'] = clientSecret;
    data['paymentIntentId'] = paymentIntentId;
    data['status'] = status;
    return data;
  }
}