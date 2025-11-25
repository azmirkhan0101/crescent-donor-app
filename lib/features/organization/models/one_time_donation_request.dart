class OneTimeDonationRequest {
  final int amount;
  final String currency;
  final String organizationId;
  final String causeId;
  final String paymentMethodId;
  final String? specialMessage;

  OneTimeDonationRequest({
    required this.amount,
    this.currency = 'usd',
    required this.organizationId,
    required this.causeId,
    required this.paymentMethodId,
    this.specialMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      'organizationId': organizationId,
      'causeId': causeId,
      'paymentMethodId': paymentMethodId,
      if (specialMessage != null && specialMessage!.isNotEmpty)
        'specialMessage': specialMessage,
    };
  }
}
