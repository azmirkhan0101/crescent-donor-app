
class RoundupOrgModel {
  final String orgName;
  final String registeredCharityName;
  final String address;
  final String state;
  final String country;
  final String logoImage;
  final String coverImage;
  final String serviceType;
  final String roundupId;
  final String organizationId;

  RoundupOrgModel({
    required this.orgName,
    required this.registeredCharityName,
    required this.address,
    required this.state,
    required this.country,
    required this.logoImage,
    required this.coverImage,
    required this.serviceType,
    required this.roundupId,
    required this.organizationId,
  });

  factory RoundupOrgModel.fromJson(Map<String, dynamic> json) {
    return RoundupOrgModel(
      orgName: json['orgName'] ?? '',
      registeredCharityName: json['registeredCharityName'] ?? '',
      address: json['address'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      logoImage: json['logoImage'] ?? '',
      coverImage: json['coverImage'] ?? '',
      serviceType: json['serviceType'] ?? '',
      roundupId: json['roundupId'] ?? '',
      organizationId: json['organizationId'] ?? '',
    );
  }
}
