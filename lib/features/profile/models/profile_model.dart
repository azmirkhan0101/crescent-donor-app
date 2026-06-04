
class ProfileModel {
  final String id;
  final AuthData auth;
  final String name;
  final String address;
  final String state;
  final String postalCode;
  final String? phoneNumber;
  final String? image;
  final String createdAt;
  final String updatedAt;

  ProfileModel({
    required this.id,
    required this.auth,
    required this.name,
    required this.address,
    required this.state,
    required this.postalCode,
    this.phoneNumber,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'] ?? '',
      auth: AuthData.fromJson(json['auth'] ?? {}),
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      phoneNumber: json['phoneNumber'],
      image: json['image'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class AuthData {
  final String id;
  final String email;
  final bool isProfile;
  final String role;

  AuthData({
    required this.id,
    required this.email,
    required this.isProfile,
    required this.role,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      isProfile: json['isProfile'] ?? false,
      role: json['role'] ?? '',
    );
  }
}
