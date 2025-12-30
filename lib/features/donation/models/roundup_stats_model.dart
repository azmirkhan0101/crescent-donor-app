class RoundupStatsResponse {
  final bool success;
  final String message;
  final RoundupStats data;

  RoundupStatsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RoundupStatsResponse.fromJson(Map<String, dynamic> json) {
    return RoundupStatsResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      data: json['data'] != null ? RoundupStats.fromJson(json['data']) : throw ArgumentError('data is required'),
    );
  }
}

class RoundupStats {
  final double currentRoundupBalance;
  final double todaysRoundupAmount;
  final double monthlyThreshold;
  final double lastTransactionAmount;
  final double roundupPercentage;
  int? daysLeft;
  final List<RecentTransactionGroup> recentTransactions;

  RoundupStats({
    required this.currentRoundupBalance,
    required this.todaysRoundupAmount,
    required this.monthlyThreshold,
    required this.lastTransactionAmount,
    required this.roundupPercentage,
    this.daysLeft,
    required this.recentTransactions,
  });

  factory RoundupStats.fromJson(Map<String, dynamic> json) {
    return RoundupStats(
      currentRoundupBalance: (json['currentRoundupBalance'] as num?)?.toDouble() ?? 0.0,
      todaysRoundupAmount: (json['todaysRoundupAmount'] as num?)?.toDouble() ?? 0.0,
      monthlyThreshold: (json['monthlyThreshold'] as num?)?.toDouble() ?? 0.0,
      lastTransactionAmount: (json['lastTransactionAmount'] as num?)?.toDouble() ?? 0.0,
      roundupPercentage: (json['roundupPercentage'] as num?)?.toDouble() ?? 0.0,
      daysLeft: json['daysLeft'] != null ? json['daysLeft'] as int : null,
      recentTransactions: (json['recentTransactions'] as List?)
          ?.map((e) => RecentTransactionGroup.fromJson(e))
          .toList() ?? [],
    );
  }
}

class RecentTransactionGroup {
  final List<RecentTransaction> transactions;
  final String title;

  RecentTransactionGroup({required this.transactions, required this.title});

  factory RecentTransactionGroup.fromJson(Map<String, dynamic> json) {
    return RecentTransactionGroup(
      transactions: (json['transactions'] as List?)
          ?.map((e) => RecentTransaction.fromJson(e))
          .toList() ?? [],
      title: json['title'] as String? ?? '',
    );
  }
}

class RecentTransaction {
  final String transactionId;
  final double roundupAmount;
  final double transactionAmount;
  final String transactionName;
  final String createdAt;

  RecentTransaction({
    required this.transactionId,
    required this.roundupAmount,
    required this.transactionAmount,
    required this.transactionName,
    required this.createdAt,
  });

  factory RecentTransaction.fromJson(Map<String, dynamic> json) {
    return RecentTransaction(
      transactionId: json['transactionId'] as String? ?? '',
      roundupAmount: (json['roundupAmount'] as num?)?.toDouble() ?? 0.0,
      transactionAmount: (json['transactionAmount'] as num?)?.toDouble() ?? 0.0,
      transactionName: json['transactionName'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
    );
  }
}
