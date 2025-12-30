class ContentModel {
  final String id;
  final String aboutUs;
  final String createdAt;
  final String privacyPolicy;
  final String terms;
  final String updatedAt;

  ContentModel({
    required this.id,
    required this.aboutUs,
    required this.createdAt,
    required this.privacyPolicy,
    required this.terms,
    required this.updatedAt,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      id: json['_id'] ?? '',
      aboutUs: json['aboutUs'] ?? '',
      createdAt: json['createdAt'] ?? '',
      privacyPolicy: json['privacyPolicy'] ?? '',
      terms: json['terms'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
