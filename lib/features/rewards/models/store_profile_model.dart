
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
