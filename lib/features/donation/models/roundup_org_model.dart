/*
{
    "success": true,
    "message": "All organization Fetched successfully for user roundup.",
    "data": [
        {
            "orgName": "Mason and Frederick Plc",
            "registeredCharityName": "",
            "address": "Enim provident mini",
            "state": "California",
            "country": "",
            "logoImage": "https://crecent-changes.s3.ap-southeast-2.amazonaws.com/profiles/organizations/695217230ba280e9348ff993-1766989577642",
            "coverImage": "https://crecent-changes.s3.ap-southeast-2.amazonaws.com/profiles/organizations/695217230ba280e9348ff993-1767067352294",
            "serviceType": "charity",
            "roundupId": "6958e57a0b6e5d533ef1c007",
            "organizationId": "695217240ba280e9348ff995"
        }
    ]
}
*/

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
