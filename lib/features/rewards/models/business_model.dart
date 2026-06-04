
class BusinessModel {
  final String id;
  final Auth auth;
  final String name;
  final String logoImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  BusinessModel({
    required this.id,
    required this.auth,
    required this.name,
    required this.logoImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['_id'],
      auth: Auth.fromJson(json['auth']),
      name: json['name'] ?? '',
      logoImage: json['logoImage'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Auth {
  final String? id;
  final String? email;
  final String? status;
  final bool? isActive;

  Auth({this.id, this.email, this.status, this.isActive});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      id: json['id'],
      email: json['email'],
      status: json['status'],
      isActive: json['isActive'],
    );
  }
}
