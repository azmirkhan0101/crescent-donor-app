class CauseCategoryModel {
  final String label;
  final String value;

  CauseCategoryModel({required this.label, required this.value});

  factory CauseCategoryModel.fromJson(Map<String, dynamic> json) {
    return CauseCategoryModel(
      label: json['label']?.toString() ?? '',
      value: json['value']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'label': label, 'value': value};
}

class CauseCategoriesResponse {
  final bool success;
  final String? message;
  final List<CauseCategoryModel> data;

  CauseCategoriesResponse({
    required this.success,
    this.message,
    required this.data,
  });

  factory CauseCategoriesResponse.fromJson(Map<String, dynamic> json) {
    final list = <CauseCategoryModel>[];
    if (json['data'] is List) {
      for (final item in json['data']) {
        if (item is Map<String, dynamic>) {
          list.add(CauseCategoryModel.fromJson(item));
        }
      }
    }

    return CauseCategoriesResponse(
      success: json['success'] == true,
      message: json['message']?.toString(),
      data: list,
    );
  }
}
