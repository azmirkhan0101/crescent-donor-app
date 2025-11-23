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
  final String coverImage;
  final String registeredCharityName;
  final String aboutUs;
  final String logoImage;
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
    required this.coverImage,
    required this.registeredCharityName,
    required this.aboutUs,
    required this.logoImage,
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
      coverImage: json['coverImage'] ?? '',
      registeredCharityName: json['registeredCharityName'] ?? '',
      aboutUs: json['aboutUs'] ?? '',
      logoImage: json['logoImage'] ?? '',
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
      'recentDonors': recentDonors.map((e) => e.toJson()).toList(),
    };
  }
}

class Auth {
  final String id;
  final String email;
  final String role;
  final bool isActive;

  Auth({
    required this.id,
    required this.email,
    required this.role,
    required this.isActive,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'email': email, 'role': role, 'isActive': isActive};
  }
}

class RecentDonor {
  final Donor? donor;
  final String lastDonationDate;
  final double lastDonationAmount;

  RecentDonor({
    this.donor,
    required this.lastDonationDate,
    required this.lastDonationAmount,
  });

  factory RecentDonor.fromJson(Map<String, dynamic> json) {
    return RecentDonor(
      donor: json['donor'] != null ? Donor.fromJson(json['donor']) : null,
      lastDonationDate: json['lastDonationDate'] ?? '',
      lastDonationAmount: (json['lastDonationAmount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'donor': donor?.toJson(),
      'lastDonationDate': lastDonationDate,
      'lastDonationAmount': lastDonationAmount,
    };
  }
}

class Donor {
  final String id;
  final String? name;
  final String? email;
  final String? image;

  Donor({required this.id, this.name, this.email, this.image});

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      id: json['_id'] ?? '',
      name: json['name'],
      email: json['email'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'email': email, 'image': image};
  }
}
