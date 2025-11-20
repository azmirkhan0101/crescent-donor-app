class CreateProfileResponseModel {
  final bool success;
  final String message;
  final ProfileData? data;

  CreateProfileResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory CreateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateProfileResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data?.toJson()};
  }
}

class ProfileData {
  final String id;
  final String name;
  final String email;
  final String role;
  final String address;
  final String state;
  final String postalCode;
  final String? clientImage;
  final CardInfo? cardInfo;
  final String createdAt;
  final String updatedAt;

  ProfileData({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.address,
    required this.state,
    required this.postalCode,
    this.clientImage,
    this.cardInfo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      address: json['address'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      clientImage: json['clientImage'],
      cardInfo: json['cardInfo'] != null
          ? CardInfo.fromJson(json['cardInfo'])
          : null,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'role': role,
      'address': address,
      'state': state,
      'postalCode': postalCode,
      'clientImage': clientImage,
      'cardInfo': cardInfo?.toJson(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class CardInfo {
  final String nameInCard;
  final String cardNumber;
  final String cardExpiryDate;

  CardInfo({
    required this.nameInCard,
    required this.cardNumber,
    required this.cardExpiryDate,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) {
    return CardInfo(
      nameInCard: json['nameInCard'] ?? '',
      cardNumber: json['cardNumber'] ?? '',
      cardExpiryDate: json['cardExpiryDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameInCard': nameInCard,
      'cardNumber': cardNumber,
      'cardExpiryDate': cardExpiryDate,
    };
  }
}
