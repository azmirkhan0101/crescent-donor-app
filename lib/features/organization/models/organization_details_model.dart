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
  final List<OrgDetailsCause> causes;
  final bool isOnetime;
  final bool isRecurring;
  final bool isRoundup;

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
    this.causes = const [],
    required this.isOnetime,
    required this.isRecurring,
    required this.isRoundup,
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
      causes:
          (json['causes'] as List<dynamic>?)
              ?.map((e) => OrgDetailsCause.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isOnetime: json['isOnetime'] ?? false,
      isRecurring: json['isRecurring'] ?? false,
      isRoundup: json['isRoundup'] ?? false,
    );
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
}

class RecentDonor {
  final String lastDonationDate;
  final double lastDonationAmount;
  final String donorId;
  final String donorName;
  final String? donorImage;
  final String donorAddress;

  RecentDonor({
    required this.lastDonationDate,
    required this.lastDonationAmount,
    required this.donorId,
    required this.donorName,
    this.donorImage,
    required this.donorAddress,
  });

  factory RecentDonor.fromJson(Map<String, dynamic> json) {
    return RecentDonor(
      lastDonationDate: json['lastDonationDate'] ?? '',
      lastDonationAmount: (json['lastDonationAmount'] ?? 0).toDouble(),
      donorId: json['donorId'] ?? '',
      donorName: json['donorName'] ?? '',
      donorImage: json['donorImage'],
      donorAddress: json['donorAddress'] ?? '',
    );
  }
}

class OrgDetailsCause {
  final String id;
  final String name;
  final String description;
  final String category;
  final String status;

  OrgDetailsCause({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.status,
  });

  factory OrgDetailsCause.fromJson(Map<String, dynamic> json) {
    return OrgDetailsCause(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
