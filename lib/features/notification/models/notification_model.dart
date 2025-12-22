/// Notification Model
///
/// Represents a single notification item from the backend
class NotificationModel {
  final String id;
  final String title;
  final String message;
  final bool isSeen;
  final String receiver;
  final String type;
  final String? redirectId;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.isSeen,
    required this.receiver,
    required this.type,
    this.redirectId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      isSeen: json['isSeen'] as bool,
      receiver: json['receiver'] as String,
      type: json['type'] as String,
      redirectId: json['redirectId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     '_id': id,
  //     'title': title,
  //     'message': message,
  //     'isSeen': isSeen,
  //     'receiver': receiver,
  //     'type': type,
  //     'redirectId': redirectId,
  //     'createdAt': createdAt.toIso8601String(),
  //     'updatedAt': updatedAt.toIso8601String(),
  //   };
  // }

  /// Check if notification is unread
  bool get isUnread => !isSeen;

  /// Get notification type category
  NotificationType get notificationType {
    switch (type.toLowerCase()) {
      case 'reward_claimed':
        return NotificationType.rewardClaimed;
      case 'new_reward':
        return NotificationType.newReward;
      case 'donation_success':
        return NotificationType.donationSuccess;
      case 'scheduled_donation':
        return NotificationType.scheduledDonation;
      case 'donation_failed':
        return NotificationType.donationFailed;
      case 'points_earned':
        return NotificationType.pointsEarned;
      case 'badge_earned':
        return NotificationType.badgeEarned;
      default:
        return NotificationType.general;
    }
  }
}

/// Notification Type Enum
enum NotificationType {
  rewardClaimed,
  newReward,
  donationSuccess,
  scheduledDonation,
  donationFailed,
  pointsEarned,
  badgeEarned,
  general,
}

/// Notification Meta Model
///
/// Contains pagination information for notifications
class NotificationMeta {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  NotificationMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory NotificationMeta.fromJson(Map<String, dynamic> json) {
    return NotificationMeta(
      page: json['page'] as int,
      limit: json['limit'] as int,
      total: json['total'] as int,
      totalPages: json['totalPages'] as int,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'page': page,
  //     'limit': limit,
  //     'total': total,
  //     'totalPages': totalPages,
  //   };
  // }

  /// Check if there are more pages
  bool get hasNextPage => page < totalPages;

  /// Check if there is a previous page
  bool get hasPreviousPage => page > 1;
}

/// Notifications Response Model
///
/// Wraps the notifications list and metadata
class NotificationsResponse {
  final NotificationMeta meta;
  final List<NotificationModel> data;

  NotificationsResponse({required this.meta, required this.data});

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'] as Map<String, dynamic>;

    return NotificationsResponse(
      meta: NotificationMeta.fromJson(dataJson['meta'] as Map<String, dynamic>),
      data: (dataJson['data'] as List<dynamic>)
          .map(
            (item) => NotificationModel.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'meta': meta.toJson(),
  //     'data': data.map((item) => item.toJson()).toList(),
  //   };
  // }

  /// Get count of unread notifications
  int get unreadCount => data.where((n) => n.isUnread).length;

  /// Get only unread notifications
  List<NotificationModel> get unreadNotifications =>
      data.where((n) => n.isUnread).toList();

  /// Get only read notifications
  List<NotificationModel> get readNotifications =>
      data.where((n) => n.isSeen).toList();
}
