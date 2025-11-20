class CreateProfileRequestModel {
  final String role;
  final String name;
  final String address;
  final String state;
  final String postalCode;
  final String nameInCard;
  final String cardNumber;
  final String cardExpiryDate;
  final String cardCVC;

  CreateProfileRequestModel({
    required this.role,
    required this.name,
    required this.address,
    required this.state,
    required this.postalCode,
    required this.nameInCard,
    required this.cardNumber,
    required this.cardExpiryDate,
    required this.cardCVC,
  });

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'name': name,
      'address': address,
      'state': state,
      'postalCode': postalCode,
      'nameInCard': nameInCard,
      'cardNumber': cardNumber,
      'cardExpiryDate': cardExpiryDate,
      'cardCVC': cardCVC,
    };
  }
}
