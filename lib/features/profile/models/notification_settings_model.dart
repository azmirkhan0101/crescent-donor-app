/*
{
    "success": true,
    "message": "Notification settings retrieved successfully",
    "data": {
        "_id": "6954a151bcffba308569f763",
        "user": "695393485e75af740761d118",
        "createdAt": "2025-12-31T04:06:38.401Z",
        "donations": true,
        "pushNotifications": false,
        "rewardsAndPerks": true,
        "updatedAt": "2025-12-31T04:08:47.618Z"
    }
}
*/

class NotificationSettingsModel {
  final String? id;
  final String? user;
  final String? createdAt;
  final bool? donations;
  final bool? pushNotifications;
  final bool? rewardsAndPerks;
  final String? updatedAt;

  NotificationSettingsModel({
    this.id,
    this.user,
    this.createdAt,
    this.donations,
    this.pushNotifications,
    this.rewardsAndPerks,
    this.updatedAt,
  });

  factory NotificationSettingsModel.fromJson(Map<String, dynamic> json) =>
      NotificationSettingsModel(
        id: json["_id"],
        user: json["user"],
        createdAt: json["createdAt"],
        donations: json["donations"],
        pushNotifications: json["pushNotifications"],
        rewardsAndPerks: json["rewardsAndPerks"],
        updatedAt: json["updatedAt"],
      );
}
