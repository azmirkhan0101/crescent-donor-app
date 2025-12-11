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
      success: json['success'],
      message: json['message'],
      data: RoundupStats.fromJson(json['data']),
    );
  }
}

class RoundupStats {
  final double currentRoundupBalance;
  final double todaysRoundupAmount;
  final int monthlyThreshold;
  final double lastTransactionAmount;
  final double roundupPercentage;
  final int daysLeft;
  final List<RecentTransactionGroup> recentTransactions;

  RoundupStats({
    required this.currentRoundupBalance,
    required this.todaysRoundupAmount,
    required this.monthlyThreshold,
    required this.lastTransactionAmount,
    required this.roundupPercentage,
    required this.daysLeft,
    required this.recentTransactions,
  });

  factory RoundupStats.fromJson(Map<String, dynamic> json) {
    return RoundupStats(
      currentRoundupBalance: json['currentRoundupBalance'].toDouble(),
      todaysRoundupAmount: json['todaysRoundupAmount'].toDouble(),
      monthlyThreshold: json['monthlyThreshold'],
      lastTransactionAmount: json['lastTransactionAmount'].toDouble(),
      roundupPercentage: json['roundupPercentage'].toDouble(),
      daysLeft: json['daysLeft'],
      recentTransactions: (json['recentTransactions'] as List)
          .map((e) => RecentTransactionGroup.fromJson(e))
          .toList(),
    );
  }
}

class RecentTransactionGroup {
  final List<RecentTransaction> transactions;
  final String title;

  RecentTransactionGroup({required this.transactions, required this.title});

  factory RecentTransactionGroup.fromJson(Map<String, dynamic> json) {
    return RecentTransactionGroup(
      transactions: (json['transactions'] as List)
          .map((e) => RecentTransaction.fromJson(e))
          .toList(),
      title: json['title'],
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
      transactionId: json['transactionId'],
      roundupAmount: json['roundupAmount'].toDouble(),
      transactionAmount: json['transactionAmount'].toDouble(),
      transactionName: json['transactionName'],
      createdAt: json['createdAt'],
    );
  }
}
