/*
{
    "success": true,
    "message": "Businesses report fetched successfully!",
    "meta": {
        "limit": 10,
        "page": 1,
        "total": 2,
        "totalPage": 1
    },
    "data": [
        {
            "_id": "693804a6d1a53418b083b1af",
            "auth": {
                "id": "693804a6d1a53418b083b1ad",
                "email": "azmir.azamkhan@gmail.com",
                "status": "verified",
                "isActive": true
            },
            "name": "jdjdkwka",
            "createdAt": "2025-12-09T11:14:46.666Z",
            "updatedAt": "2025-12-09T11:14:46.666Z"
        },
        {
            "_id": "693a5062893d3c3a90696cb4",
            "auth": {
                "id": "693a5062893d3c3a90696cb2",
                "email": "azmirdroid@gmail.com",
                "status": "verified",
                "isActive": true
            },
            "name": "Azmir shop",
            "createdAt": "2025-12-11T05:02:26.913Z",
            "updatedAt": "2025-12-11T05:02:26.913Z"
        },
        {
            "_id": "693109abaa6d1208849d5c2f",
            "auth": {
                "id": "693109aaaa6d1208849d5c2d",
                "email": "azmirdoid@gmail.com",
                "status": "verified",
                "isActive": true
            },
            "name": "Azmir Shop",
            "createdAt": "2025-12-04T04:10:19.348Z",
            "updatedAt": "2025-12-04T04:10:19.348Z"
        }
    ]
}
*/

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
