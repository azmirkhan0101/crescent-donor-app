class MetaModel {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  MetaModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      page: int.tryParse(json['page']?.toString() ?? '0') ?? 0,
      limit: int.tryParse(json['limit']?.toString() ?? '0') ?? 0,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 0,
    );
  }
}
