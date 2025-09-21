class OrganizationModel {
  final String id;
  final String name;
  final String description;
  final String location;
  final String category;
  final String logoUrl;
  final String bannerUrl;
  final bool verified;
  final double rating;
  final String totalDonations;
  final int activeCampaigns;
  final String beneficiaries;
  final int establishedYear;
  final String website;
  final String email;
  final String phone;
  final String mission;
  final String impact;
  final List<CauseModel> causes;
  final List<UpdateModel> recentUpdates;

  OrganizationModel({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.category,
    required this.logoUrl,
    required this.bannerUrl,
    required this.verified,
    required this.rating,
    required this.totalDonations,
    required this.activeCampaigns,
    required this.beneficiaries,
    required this.establishedYear,
    required this.website,
    required this.email,
    required this.phone,
    required this.mission,
    required this.impact,
    required this.causes,
    required this.recentUpdates,
  });

  // Factory constructor for creating from JSON
  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      category: json['category'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      bannerUrl: json['bannerUrl'] ?? '',
      verified: json['verified'] ?? false,
      rating: (json['rating'] ?? 0.0).toDouble(),
      totalDonations: json['totalDonations'] ?? '0',
      activeCampaigns: json['activeCampaigns'] ?? 0,
      beneficiaries: json['beneficiaries'] ?? '',
      establishedYear: json['establishedYear'] ?? 0,
      website: json['website'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      mission: json['mission'] ?? '',
      impact: json['impact'] ?? '',
      causes:
          (json['causes'] as List<dynamic>?)
              ?.map((item) => CauseModel.fromJson(item))
              .toList() ??
          [],
      recentUpdates:
          (json['recentUpdates'] as List<dynamic>?)
              ?.map((item) => UpdateModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'category': category,
      'logoUrl': logoUrl,
      'bannerUrl': bannerUrl,
      'verified': verified,
      'rating': rating,
      'totalDonations': totalDonations,
      'activeCampaigns': activeCampaigns,
      'beneficiaries': beneficiaries,
      'establishedYear': establishedYear,
      'website': website,
      'email': email,
      'phone': phone,
      'mission': mission,
      'impact': impact,
      'causes': causes.map((cause) => cause.toJson()).toList(),
      'recentUpdates': recentUpdates.map((update) => update.toJson()).toList(),
    };
  }
}

class CauseModel {
  final String emoji;
  final String title;
  final String description;

  CauseModel({
    required this.emoji,
    required this.title,
    required this.description,
  });

  factory CauseModel.fromJson(Map<String, dynamic> json) {
    return CauseModel(
      emoji: json['emoji'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'emoji': emoji, 'title': title, 'description': description};
  }
}

class UpdateModel {
  final String title;
  final String description;
  final String date;
  final String imageUrl;

  UpdateModel({
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
  });

  factory UpdateModel.fromJson(Map<String, dynamic> json) {
    return UpdateModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'imageUrl': imageUrl,
    };
  }
}
