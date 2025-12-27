/*
{
    "success": true,
    "message": "Business profile retrived successfully!",
    "data": {
        "_id": "694796c1b750f35edef22ce5",
        "auth": "694796c0b750f35edef22ce3",
        "category": "Automotive",
        "name": "AutoZone BD",
        "tagLine": "Drive with confidence",
        "description": "We supply high-quality automotive parts, car accessories, and maintenance products.",
        "logoImage": "https://crecent-changes.s3.ap-southeast-2.amazonaws.com/profiles/businesses/logo-1766299328233",
        "businessPhoneNumber": "+8801855667788",
        "businessEmail": "support@autozonebd.com",
        "businessWebsite": "https://www.autozonebd.com",
        "locations": [
            "Dhaka",
            "Gazipur",
            "Cumilla"
        ],
        "websiteViews": 0,
        "views": 0,
        "createdAt": "2025-12-21T06:42:09.307Z",
        "updatedAt": "2025-12-21T09:17:02.744Z",
        "coverImage": "https://crecent-changes.s3.ap-southeast-2.amazonaws.com/profiles/businesses/cover-694796c0b750f35edef22ce3-1766308622194"
    }
}
*/

class StoreProfileModel {
  final String id;
  final String auth;
  final String category;
  final String name;
  final String? tagLine;
  final String? description;
  final String? logoImage;
  final String? businessPhoneNumber;
  final String? businessEmail;
  final String? businessWebsite;
  final List<String> locations;
  final int websiteViews;
  final int views;
  final String createdAt;
  final String updatedAt;
  final String? coverImage;

  StoreProfileModel({
    required this.id,
    required this.auth,
    required this.category,
    required this.name,
    this.tagLine,
    this.description,
    this.logoImage,
    this.businessPhoneNumber,
    this.businessEmail,
    this.businessWebsite,
    required this.locations,
    required this.websiteViews,
    required this.views,
    required this.createdAt,
    required this.updatedAt,
    this.coverImage,
  });

  factory StoreProfileModel.fromJson(Map<String, dynamic> json) {
    return StoreProfileModel(
      id: json['_id'],
      auth: json['auth'],
      category: json['category'],
      name: json['name'],
      tagLine: json['tagLine'],
      description: json['description'],
      logoImage: json['logoImage'],
      businessPhoneNumber: json['businessPhoneNumber'],
      businessEmail: json['businessEmail'],
      businessWebsite: json['businessWebsite'],
      locations: List<String>.from(json['locations'] ?? []),
      websiteViews: json['websiteViews'] ?? 0,
      views: json['views'] ?? 0,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      coverImage: json['coverImage'],
    );
  }
}
