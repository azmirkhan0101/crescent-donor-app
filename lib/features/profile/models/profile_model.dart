/*
{
    "success": true,
    "message": "Profile data retrieved successfully!",
    "data": {
        "_id": "69219f93013d9c2cf75aed5e",
        "auth": {
            "_id": "69219f63013d9c2cf75aed58",
            "email": "cctest9@yopmail.com",
            "isProfile": true,
            "role": "CLIENT"
        },
        "name": "CC Test 9",
        "address": "123 Main Street",
        "state": "California",
        "postalCode": "90001",
        "image": "public/images/scaled_23-1763811219556.jpg",
        "createdAt": "2025-11-22T11:33:39.618Z",
        "updatedAt": "2025-11-22T11:33:39.618Z"
    }
}
*/

// class ProfileResponseModel {
//   final bool success;
//   final String message;
//   final ProfileData? data;

//   ProfileResponseModel({
//     required this.success,
//     required this.message,
//     this.data,
//   });

//   factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
//     return ProfileResponseModel(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//       data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
//     );
//   }
// }

class ProfileModel {
  final String id;
  final AuthData auth;
  final String name;
  final String address;
  final String state;
  final String postalCode;
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
