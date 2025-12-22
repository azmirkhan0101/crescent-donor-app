import 'package:cresent_charge_user_app/service/api_url.dart';
/*
{
    "success": true,
    "message": "Business profile retrived successfully!",
    "data": {
        "_id": "69413330eaa7c8a7c9ca05ea",
        "auth": "69413330eaa7c8a7c9ca05e8",
        "category": "Electronics",
        "name": "TechMart BD",
        "tagLine": "Quality products guaranteed",
        "description": "We sell high-quality electronic gadgets and accessories.",
        "businessPhoneNumber": "+8801712345678",
        "businessEmail": "contact@techmartbd.com",
        "businessWebsite": "https://www.techmartbd.com",
        "locations": [
            "Dhaka",
            "Chattogram",
            "Sylhet"
        ],
        "websiteViews": 0,
        "views": 0,
        "createdAt": "2025-12-16T10:23:44.614Z",
        "updatedAt": "2025-12-16T10:23:44.614Z"
    }
}
*/

class StoreProfileModel {
  final String id;
  final String auth;
  final String category;
  final String name;
  final String tagLine;
  final String description;
  final String coverImage;
  final String businessPhoneNumber;
  final String businessEmail;
  final String businessWebsite;
  final List<String> locations;
  final int websiteViews;
  final int views;
  final String createdAt;
  final String updatedAt;

  StoreProfileModel({
    required this.id,
    required this.auth,
    required this.category,
    required this.name,
    required this.tagLine,
    required this.description,
    required this.coverImage,
    required this.businessPhoneNumber,
    required this.businessEmail,
    required this.businessWebsite,
    required this.locations,
    required this.websiteViews,
    required this.views,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StoreProfileModel.fromJson(Map<String, dynamic> json) {
    String rawCover = json['coverImage'] ?? json['logoImage'] ?? '';
    String resolvedCover = rawCover.isEmpty
        ? ''
        : (rawCover.startsWith('http')
              ? rawCover
              : '${ApiUrl.imageBaseUrl}/$rawCover');
    return StoreProfileModel(
      id: json['_id'] ?? '',
      auth: json['auth'] ?? '',
      category: json['category'] ?? '',
      name: json['name'] ?? '',
      tagLine: json['tagLine'] ?? '',
      description: json['description'] ?? '',
      coverImage: resolvedCover,
      businessPhoneNumber: json['businessPhoneNumber'] ?? '',
      businessEmail: json['businessEmail'] ?? '',
      businessWebsite: json['businessWebsite'] ?? '',
      locations: List<String>.from(json['locations'] ?? []),
      websiteViews: json['websiteViews'] ?? 0,
      views: json['views'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
