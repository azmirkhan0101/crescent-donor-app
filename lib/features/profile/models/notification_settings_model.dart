
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
