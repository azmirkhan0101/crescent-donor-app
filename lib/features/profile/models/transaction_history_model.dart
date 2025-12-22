/// Transaction History Model
class TransactionHistoryModel {
  final String title;
  final List<TransactionItemModel> transactions;

  TransactionHistoryModel({required this.title, required this.transactions});

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryModel(
      title: json['title'] ?? '',
      transactions:
          (json['transactions'] as List<dynamic>?)
              ?.map((e) => TransactionItemModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'transactions': transactions.map((e) => e.toJson()).toList(),
    };
  }
}

/// Transaction Item Model
class TransactionItemModel {
  final String id;
  final String title;
  final String organizationName;
  final num amount;
  final num originalAmount;
  final String type;
  final String? image;
  final String timeAgo;
  final String fullDate;

  TransactionItemModel({
    required this.id,
    required this.title,
    required this.organizationName,
    required this.amount,
    required this.originalAmount,
    required this.type,
    this.image,
    required this.timeAgo,
    required this.fullDate,
  });

  factory TransactionItemModel.fromJson(Map<String, dynamic> json) {
    return TransactionItemModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      organizationName: json['organizationName'] ?? '',
      amount: json['amount'] ?? 0,
      originalAmount: json['originalAmount'] ?? 0,
      type: json['type'] ?? '',
      image: json['image'],
      timeAgo: json['timeAgo'] ?? '',
      fullDate: json['fullDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'organizationName': organizationName,
      'amount': amount,
      'originalAmount': originalAmount,
      'type': type,
      'image': image,
      'timeAgo': timeAgo,
      'fullDate': fullDate,
    };
  }
}

/// Transaction History Response Model
class TransactionHistoryResponse {
  final List<TransactionHistoryModel> data;
  final MetaModel meta;

  TransactionHistoryResponse({required this.data, required this.meta});

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryResponse(
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => TransactionHistoryModel.fromJson(e))
              .toList() ??
          [],
      meta: MetaModel.fromJson(json['meta'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'meta': meta.toJson(),
    };
  }
}

/// Meta Model for Pagination
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
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 20,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'totalPage': totalPage,
    };
  }
}
