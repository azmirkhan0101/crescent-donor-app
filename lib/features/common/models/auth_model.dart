class AuthModel {
  final String id;
  final String email;
  final String role;
  final bool isActive;
  final String? status;

  AuthModel({
    required this.id,
    required this.email,
    required this.role,
    required this.isActive,
    this.status,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      isActive: json['isActive'] ?? false,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'role': role,
      'isActive': isActive,
      'status': status,
    };
  }
}
