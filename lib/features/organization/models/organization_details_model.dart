/*
{
    "success": true,
    "message": "Organization details retrieved successfully!",
    "data": {
        "_id": "693d3498c139b728a8d734d7",
        "auth": {
            "_id": "693d3498c139b728a8d734bb",
            "email": "gohomen778@alexida.com",
            "role": "ORGANIZATION",
            "isActive": true,
            "status": "verified"
        },
        "name": "Copeland and Merrill Inc",
        "serviceType": "Charity",
        "address": "Walters and Castaneda Traders",
        "state": "California",
        "postalCode": "Ipsum doloribus sun",
        "website": "Bonner Casey Traders",
        "phoneNumber": "+1 (481) 897-3611",
        "coverImage": null,
        "logoImage": null,
        "aboutUs": "",
        "registeredCharityName": "",
        "totalDonation": 5,
        "totalDonationAmount": 405,
        "recentDonors": [
            {
                "lastDonationDate": "2025-12-14T05:15:52.988Z",
                "lastDonationAmount": 5,
                "donorId": "69301feaddbf3fdf987e86e8",
                "donorName": "Mostafizur",
                "donorImage": "/images/scaled_18-1765684240320.jpg",
                "donorAddress": "Dhaka, Mohakhai"
            }
        ]
    }
}
*/

class OrganizationDetailsModel {
  final String id;
  final Auth? auth;
  final String name;
  final String serviceType;
  final String address;
  final String state;
  final String postalCode;
  final String website;
  final String phoneNumber;
  final String? coverImage;
  final String registeredCharityName;
  final String aboutUs;
  final String? logoImage;
  final int totalDonation;
  final double totalDonationAmount;
  final List<RecentDonor> recentDonors;

  OrganizationDetailsModel({
    required this.id,
    this.auth,
    required this.name,
    required this.serviceType,
    required this.address,
    required this.state,
    required this.postalCode,
    required this.website,
    required this.phoneNumber,
    this.coverImage,
    required this.registeredCharityName,
    required this.aboutUs,
    this.logoImage,
    required this.totalDonation,
    required this.totalDonationAmount,
    required this.recentDonors,
  });

  factory OrganizationDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrganizationDetailsModel(
      id: json['_id'] ?? '',
      auth: json['auth'] != null ? Auth.fromJson(json['auth']) : null,
      name: json['name'] ?? '',
      serviceType: json['serviceType'] ?? '',
      address: json['address'] ?? '',
      state: json['state'] ?? '',
      postalCode: json['postalCode'] ?? '',
      website: json['website'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      coverImage: json['coverImage'],
      registeredCharityName: json['registeredCharityName'] ?? '',
      aboutUs: json['aboutUs'] ?? '',
      logoImage: json['logoImage'],
      totalDonation: json['totalDonation'] ?? 0,
      totalDonationAmount: (json['totalDonationAmount'] ?? 0).toDouble(),
      recentDonors:
          (json['recentDonors'] as List<dynamic>?)
              ?.map((e) => RecentDonor.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'auth': auth?.toJson(),
      'name': name,
      'serviceType': serviceType,
      'address': address,
      'state': state,
      'postalCode': postalCode,
      'website': website,
      'phoneNumber': phoneNumber,
      'coverImage': coverImage,
      'registeredCharityName': registeredCharityName,
      'aboutUs': aboutUs,
      'logoImage': logoImage,
      'totalDonation': totalDonation,
      'totalDonationAmount': totalDonationAmount,
      'recentDonors': recentDonors.map((e) => e.toJson()).toList(),
    };
  }
}

class Auth {
  final String id;
  final String email;
  final String role;
  final bool isActive;
  final String status;

  Auth({
    required this.id,
    required this.email,
    required this.role,
    required this.isActive,
    required this.status,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      isActive: json['isActive'] ?? false,
      status: json['status'] ?? '',
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

class RecentDonor {
  final String lastDonationDate;
  final double lastDonationAmount;
  final String donorId;
  final String donorName;
  final String donorImage;
  final String donorAddress;

  RecentDonor({
    required this.lastDonationDate,
    required this.lastDonationAmount,
    required this.donorId,
    required this.donorName,
    required this.donorImage,
    required this.donorAddress,
  });

  factory RecentDonor.fromJson(Map<String, dynamic> json) {
    return RecentDonor(
      lastDonationDate: json['lastDonationDate'] ?? '',
      lastDonationAmount: (json['lastDonationAmount'] ?? 0).toDouble(),
      donorId: json['donorId'] ?? '',
      donorName: json['donorName'] ?? '',
      donorImage: json['donorImage'] ?? '',
      donorAddress: json['donorAddress'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastDonationDate': lastDonationDate,
      'lastDonationAmount': lastDonationAmount,
      'donorId': donorId,
      'donorName': donorName,
      'donorImage': donorImage,
      'donorAddress': donorAddress,
    };
  }
}
