/// Points Transaction Model
class PointsTransactionModel {
  final String id;
  final String user;
  final String transactionType;
  final int amount;
  final int balance;
  final String source;
  final DonationInfo? donation;
  final String description;
  final Map<String, dynamic> metadata;
  final bool isExpired;
  final String createdAt;
  final String updatedAt;

  PointsTransactionModel({
    required this.id,
    required this.user,
    required this.transactionType,
    required this.amount,
    required this.balance,
    required this.source,
    this.donation,
    required this.description,
    required this.metadata,
    required this.isExpired,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PointsTransactionModel.fromJson(Map<String, dynamic> json) {
    return PointsTransactionModel(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      transactionType: json['transactionType'] ?? '',
      amount: json['amount'] ?? 0,
      balance: json['balance'] ?? 0,
      source: json['source'] ?? '',
      donation: json['donation'] != null
          ? DonationInfo.fromJson(json['donation'])
          : null,
      description: json['description'] ?? '',
      metadata: Map<String, dynamic>.from(json['metadata'] ?? {}),
      isExpired: json['isExpired'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'transactionType': transactionType,
      'amount': amount,
      'balance': balance,
      'source': source,
      'donation': donation?.toJson(),
      'description': description,
      'metadata': metadata,
      'isExpired': isExpired,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

/// Donation Info Model
class DonationInfo {
  final String id;
  final String organization;
  final String donationType;
  final int amount;

  DonationInfo({
    required this.id,
    required this.organization,
    required this.donationType,
    required this.amount,
  });

  factory DonationInfo.fromJson(Map<String, dynamic> json) {
    return DonationInfo(
      id: json['_id'] ?? '',
      organization: json['organization'] ?? '',
      donationType: json['donationType'] ?? '',
      amount: json['amount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'organization': organization,
      'donationType': donationType,
      'amount': amount,
    };
  }
}

/// Transactions Response Model
class TransactionsResponse {
  final List<PointsTransactionModel> transactions;
  final int total;
  final String page;
  final String limit;

  TransactionsResponse({
    required this.transactions,
    required this.total,
    required this.page,
    required this.limit,
  });

  factory TransactionsResponse.fromJson(Map<String, dynamic> json) {
    return TransactionsResponse(
      transactions:
          (json['transactions'] as List<dynamic>?)
              ?.map((e) => PointsTransactionModel.fromJson(e))
              .toList() ??
          [],
      total: json['total'] ?? 0,
      page: json['page']?.toString() ?? '1',
      limit: json['limit']?.toString() ?? '20',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactions': transactions.map((e) => e.toJson()).toList(),
      'total': total,
      'page': page,
      'limit': limit,
    };
  }
}
