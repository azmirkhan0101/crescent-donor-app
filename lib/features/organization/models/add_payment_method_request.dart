class AddPaymentMethodRequest {
  final String stripePaymentMethodId;
  final String cardHolderName;
  final bool isDefault;

  AddPaymentMethodRequest({
    required this.stripePaymentMethodId,
    required this.cardHolderName,
    required this.isDefault,
  });

  Map<String, dynamic> toJson() {
    return {
      'stripePaymentMethodId': stripePaymentMethodId,
      'cardHolderName': cardHolderName,
      'isDefault': isDefault,
    };
  }
}
