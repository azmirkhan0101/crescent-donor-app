class CancelRedemptionResponse {
  final bool success;
  final String message;
  final CancelRedemptionData? data;

  CancelRedemptionResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'],
      message = json['message'],
      data = json['data'] != null
          ? CancelRedemptionData.fromJson(json['data'])
          : null;
}

class CancelRedemptionData {
  final String id;
  final String userId;
  final String rewardId;
  final String businessId;
  final int pointsSpent;
  final String? pointsTransactionId;
  final String status;
  final String claimedAt;
  final String? redeemedAt;
  final String? expiredAt;
  final String? cancelledAt;
  final String? assignedCode;
  final String? redemptionMethod;
  final String? qrCode;
  final String? qrCodeUrl;
  final String expiresAt;
  final String? redeemedByStaff;
  final String? redemptionLocation;
  final String? redemptionNotes;
  final String? cancellationReason;
  final String? refundTransactionId;
  final String? idempotencyKey;
  final String createdAt;
  final String updatedAt;

  CancelRedemptionData.fromJson(Map<String, dynamic> json)
    : id = json['_id'],
      userId = json['user'],
      rewardId = json['reward'],
      businessId = json['business'],
      pointsSpent = json['pointsSpent'],
      pointsTransactionId = json['pointsTransactionId'],
      status = json['status'],
      claimedAt = json['claimedAt'],
      redeemedAt = json['redeemedAt'],
      expiredAt = json['expiredAt'],
      cancelledAt = json['cancelledAt'],
      assignedCode = json['assignedCode'],
      redemptionMethod = json['redemptionMethod'],
      qrCode = json['qrCode'],
      qrCodeUrl = json['qrCodeUrl'],
      expiresAt = json['expiresAt'],
      redeemedByStaff = json['redeemedByStaff'],
      redemptionLocation = json['redemptionLocation'],
      redemptionNotes = json['redemptionNotes'],
      cancellationReason = json['cancellationReason'],
      refundTransactionId = json['refundTransactionId'],
      idempotencyKey = json['idempotencyKey'],
      createdAt = json['createdAt'],
      updatedAt = json['updatedAt'];
}
