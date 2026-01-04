class BadgeDataModel {
  final String? badgeId;
  final String? name;
  final String? icon;
  final String? description;
  final String? type;
  final bool? isUnlocked;
  final bool? isCompleted;
  final String? currentTier;
  final List<TierModel>? tiers;
  final ProgressInfo? progress;
  final RawProgress? rawProgress;

  BadgeDataModel({
    this.badgeId,
    this.name,
    this.icon,
    this.description,
    this.type,
    this.isUnlocked,
    this.isCompleted,
    this.currentTier,
    this.tiers,
    this.progress,
    this.rawProgress,
  });

  // Legacy fields for backward compatibility
  BadgeModel? get badge => BadgeModel(
    id: badgeId,
    name: name,
    description: description,
    icon: icon,
    unlockType: type,
  );

  UserBadge? get userBadge => null;

  NextTier? get nextTier => progress != null
      ? NextTier(
          tier: currentTier,
          name: progress!.nextTierName,
          requiredCount: rawProgress?.requiredCount,
          requiredAmount: rawProgress?.requiredAmount?.toDouble(),
        )
      : null;

  int? get progressCount => rawProgress?.count;
  double? get progressAmount => rawProgress?.amount?.toDouble();
  int? get progressPercentage => progress?.percentage;
  int? get remainingForNextTier => progress?.remaining;

  factory BadgeDataModel.fromJson(Map<String, dynamic> json) => BadgeDataModel(
    badgeId: json["badgeId"],
    name: json["name"],
    icon: json["icon"],
    description: json["description"],
    type: json["type"],
    isUnlocked: json["isUnlocked"],
    isCompleted: json["isCompleted"],
    currentTier: json["currentTier"],
    tiers: json["tiers"] == null
        ? []
        : List<TierModel>.from(json["tiers"].map((x) => TierModel.fromJson(x))),
    progress: json["progress"] == null
        ? null
        : ProgressInfo.fromJson(json["progress"]),
    rawProgress: json["rawProgress"] == null
        ? null
        : RawProgress.fromJson(json["rawProgress"]),
  );

  Map<String, dynamic> toJson() => {
    "badgeId": badgeId,
    "name": name,
    "icon": icon,
    "description": description,
    "type": type,
    "isUnlocked": isUnlocked,
    "isCompleted": isCompleted,
    "currentTier": currentTier,
    "tiers": tiers == null
        ? []
        : List<dynamic>.from(tiers!.map((x) => x.toJson())),
    "progress": progress?.toJson(),
    "rawProgress": rawProgress?.toJson(),
  };
}

class ProgressInfo {
  final int? percentage;
  final int? remaining;
  final String? unit;
  final String? nextTierName;

  ProgressInfo({this.percentage, this.remaining, this.unit, this.nextTierName});

  factory ProgressInfo.fromJson(Map<String, dynamic> json) => ProgressInfo(
    percentage: json["percentage"],
    remaining: json["remaining"],
    unit: json["unit"],
    nextTierName: json["nextTierName"],
  );

  Map<String, dynamic> toJson() => {
    "percentage": percentage,
    "remaining": remaining,
    "unit": unit,
    "nextTierName": nextTierName,
  };
}

class RawProgress {
  final int? count;
  final num? amount;
  final int? requiredCount;
  final num? requiredAmount;

  RawProgress({
    this.count,
    this.amount,
    this.requiredCount,
    this.requiredAmount,
  });

  factory RawProgress.fromJson(Map<String, dynamic> json) => RawProgress(
    count: json["count"],
    amount: json["amount"],
    requiredCount: json["requiredCount"],
    requiredAmount: json["requiredAmount"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "amount": amount,
    "requiredCount": requiredCount,
    "requiredAmount": requiredAmount,
  };
}

class BadgeModel {
  final String? id;
  final String? name;
  final String? description;
  final String? icon;
  final String? unlockType;
  final String? conditionLogic;
  final List<String>? specificCategories;
  final List<TierModel>? tiers;
  final bool? isSingleTier;
  final bool? isActive;
  final int? priority;
  final bool? featured;
  final String? seasonalPeriod;
  final TimeRangeModel? timeRange;
  final double? minDonationAmount;
  final double? maxDonationAmount;
  final String? createdAt;
  final String? updatedAt;

  BadgeModel({
    this.id,
    this.name,
    this.description,
    this.icon,
    this.unlockType,
    this.conditionLogic,
    this.specificCategories,
    this.tiers,
    this.isSingleTier,
    this.isActive,
    this.priority,
    this.featured,
    this.seasonalPeriod,
    this.timeRange,
    this.minDonationAmount,
    this.maxDonationAmount,
    this.createdAt,
    this.updatedAt,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) => BadgeModel(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    icon: json["icon"],
    unlockType: json["unlockType"],
    conditionLogic: json["conditionLogic"],
    specificCategories: json["specificCategories"] == null
        ? []
        : List<String>.from(
            json["specificCategories"].map((x) => x.toString()),
          ),
    tiers: json["tiers"] == null
        ? []
        : List<TierModel>.from(json["tiers"].map((x) => TierModel.fromJson(x))),
    isSingleTier: json["isSingleTier"],
    isActive: json["isActive"],
    priority: json["priority"],
    featured: json["featured"],
    seasonalPeriod: json["seasonalPeriod"],
    timeRange: json["timeRange"] == null
        ? null
        : TimeRangeModel.fromJson(json["timeRange"]),
    minDonationAmount: (json["minDonationAmount"] as num?)?.toDouble(),
    maxDonationAmount: (json["maxDonationAmount"] as num?)?.toDouble(),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );
}

class TimeRangeModel {
  final int? start;
  final int? end;

  TimeRangeModel({this.start, this.end});

  factory TimeRangeModel.fromJson(Map<String, dynamic> json) => TimeRangeModel(
    start: (json["start"] as num?)?.toInt(),
    end: (json["end"] as num?)?.toInt(),
  );
}

class TierModel {
  final String? tier;
  final String? name;
  final String? icon;
  final String? animationUrl;
  final String? smallIconUrl;
  final bool? isUnlocked;
  final bool? isPreviewed;
  final int? requiredCount;
  final num? requiredAmount;

  TierModel({
    this.tier,
    this.name,
    this.icon,
    this.animationUrl,
    this.smallIconUrl,
    this.isUnlocked,
    this.isPreviewed,
    this.requiredCount,
    this.requiredAmount,
  });

  factory TierModel.fromJson(Map<String, dynamic> json) => TierModel(
    tier: json["tier"],
    name: json["name"],
    icon: json["icon"],
    animationUrl: json["animationUrl"],
    smallIconUrl: json["smallIconUrl"],
    isUnlocked: json["isUnlocked"],
    isPreviewed: json["isPreviewed"],
    requiredCount: (json["requiredCount"] as num?)?.toInt(),
    requiredAmount: (json["requiredAmount"] as num?),
  );

  Map<String, dynamic> toJson() => {
    "tier": tier,
    "name": name,
    "icon": icon,
    "animationUrl": animationUrl,
    "smallIconUrl": smallIconUrl,
    "isUnlocked": isUnlocked,
    "isPreviewed": isPreviewed,
    "requiredCount": requiredCount,
    "requiredAmount": requiredAmount,
  };
}

class UserBadge {
  final String? id;
  final String? user;
  final String? badge;
  final int? consecutiveMonths;
  final String? currentTier;
  final bool? isCompleted;
  final double? progressAmount;
  final int? progressCount;
  final List<TierUnlocked>? tiersUnlocked;
  final String? createdAt;
  final String? lastDonationDate;
  final List<dynamic>? uniqueCategoryNames;
  final String? updatedAt;

  UserBadge({
    this.id,
    this.user,
    this.badge,
    this.consecutiveMonths,
    this.currentTier,
    this.isCompleted,
    this.progressAmount,
    this.progressCount,
    this.tiersUnlocked,
    this.createdAt,
    this.lastDonationDate,
    this.uniqueCategoryNames,
    this.updatedAt,
  });

  factory UserBadge.fromJson(Map<String, dynamic> json) => UserBadge(
    id: json["_id"],
    user: json["user"],
    badge: json["badge"],
    consecutiveMonths: (json["consecutiveMonths"] as num?)?.toInt(),
    currentTier: json["currentTier"],
    isCompleted: json["isCompleted"],
    progressAmount: (json["progressAmount"] as num?)?.toDouble(),
    progressCount: (json["progressCount"] as num?)?.toInt(),
    tiersUnlocked: json["tiersUnlocked"] == null
        ? []
        : List<TierUnlocked>.from(
            json["tiersUnlocked"].map((x) => TierUnlocked.fromJson(x)),
          ),
    createdAt: json["createdAt"],
    lastDonationDate: json["lastDonationDate"],
    uniqueCategoryNames: json["uniqueCategoryNames"] == null
        ? []
        : List<dynamic>.from(json["uniqueCategoryNames"].map((x) => x)),
    updatedAt: json["updatedAt"],
  );
}

class TierUnlocked {
  final String? tier;
  final DateTime? unlockedAt;
  final String? id;

  TierUnlocked({this.tier, this.unlockedAt, this.id});

  factory TierUnlocked.fromJson(Map<String, dynamic> json) => TierUnlocked(
    tier: json["tier"],
    unlockedAt: json["unlockedAt"] == null
        ? null
        : DateTime.parse(json["unlockedAt"]),
    id: json["_id"],
  );
}

class NextTier {
  final String? tier;
  final String? name;
  final int? requiredCount;
  final double? requiredAmount;
  final String? icon;

  NextTier({
    this.tier,
    this.name,
    this.requiredCount,
    this.requiredAmount,
    this.icon,
  });

  factory NextTier.fromJson(Map<String, dynamic> json) => NextTier(
    tier: json["tier"],
    name: json["name"],
    requiredCount: (json["requiredCount"] as num?)?.toInt(),
    requiredAmount: (json["requiredAmount"] as num?)?.toDouble(),
    icon: json["icon"],
  );
}

/*
{
    "success": true,
    "message": "User badges progress retrieved",
    "meta": {
        "page": 1,
        "limit": 10,
        "total": 7,
        "totalPage": 1
    },
    "data": [
        {
            "badgeId": "6956107c4671e5d80da0ffd1",
            "name": "Marshall Lowery",
            "icon": "https://crecent-changes.s3.ap-southeast-2.amazonaws.com/badges/main/badge-main-1767247995859",
            "description": "bah",
            "type": "donation_amount",
            "isUnlocked": false,
            "tiers": [
                {
                    "tier": "colour",
                    "name": "Colour",
                    "icon": "https://crecent-changes.s3.ap-southeast-2.amazonaws.com/badges/tiers/badge-tier-colour-1767247995946",
                    "animationUrl": "https://crecent-changes.s3.ap-southeast-2.amazonaws.com/badges/tiers/badge-tier-colour-animation-1767247996029",
                    "smallIconUrl": "https://crecent-changes.s3.ap-southeast-2.amazonaws.com/badges/tiers/badge-tier-colour-small-1767247996107",
                    "isUnlocked": false,
                    "isPreviewed": false,
                    "requiredCount": 1,
                    "requiredAmount": 2
                },
                ...
            ],
            "isCompleted": false,
            "currentTier": "colour",
            "progress": {
                "percentage": 0,
                "remaining": 1,
                "unit": "donations",
                "nextTierName": "Bronze"
            },
            "rawProgress": {
                "count": 0,
                "amount": 0,
                "requiredCount": 1,
                "requiredAmount": 2
            }
        }
    ]
}
*/
