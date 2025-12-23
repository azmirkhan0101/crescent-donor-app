class BadgeDataModel {
  final BadgeModel? badge;
  final UserBadge? userBadge;
  final bool? isUnlocked;
  final String? currentTier;
  final NextTier? nextTier;
  final int? progressCount;
  final double? progressAmount;
  final int? progressPercentage;
  final int? remainingForNextTier;

  BadgeDataModel({
    this.badge,
    this.userBadge,
    this.isUnlocked,
    this.currentTier,
    this.nextTier,
    this.progressCount,
    this.progressAmount,
    this.progressPercentage,
    this.remainingForNextTier,
  });

  factory BadgeDataModel.fromJson(Map<String, dynamic> json) => BadgeDataModel(
    badge: json["badge"] == null ? null : BadgeModel.fromJson(json["badge"]),
    userBadge: json["userBadge"] == null
        ? null
        : UserBadge.fromJson(json["userBadge"]),
    isUnlocked: json["isUnlocked"],
    currentTier: json["currentTier"],
    nextTier: json["nextTier"] == null
        ? null
        : NextTier.fromJson(json["nextTier"]),
    progressCount: (json["progressCount"] as num?)?.toInt(),
    progressAmount: (json["progressAmount"] as num?)?.toDouble(),
    progressPercentage: (json["progressPercentage"] as num?)?.toInt(),
    remainingForNextTier: (json["remainingForNextTier"] as num?)?.toInt(),
  );
}

class BadgeModel {
  final String? id;
  final String? name;
  final String? description;
  final String? icon;
  final String? unlockType;
  final String? conditionLogic;
  final List<dynamic>? specificCategories;
  final List<TierModel>? tiers;
  final bool? isSingleTier;
  final bool? isActive;
  final int? priority;
  final bool? featured;
  final String? seasonalPeriod;
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
        : List<dynamic>.from(json["specificCategories"].map((x) => x)),
    tiers: json["tiers"] == null
        ? []
        : List<TierModel>.from(json["tiers"].map((x) => TierModel.fromJson(x))),
    isSingleTier: json["isSingleTier"],
    isActive: json["isActive"],
    priority: json["priority"],
    featured: json["featured"],
    seasonalPeriod: json["seasonalPeriod"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
  );
}

class TierModel {
  final String? tier;
  final String? name;
  final int? requiredCount;
  final double? requiredAmount;

  TierModel({this.tier, this.name, this.requiredCount, this.requiredAmount});

  factory TierModel.fromJson(Map<String, dynamic> json) => TierModel(
    tier: json["tier"],
    name: json["name"],
    requiredCount: (json["requiredCount"] as num?)?.toInt(),
    requiredAmount: (json["requiredAmount"] as num?)?.toDouble(),
  );
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

  NextTier({this.tier, this.name, this.requiredCount, this.requiredAmount});

  factory NextTier.fromJson(Map<String, dynamic> json) => NextTier(
    tier: json["tier"],
    name: json["name"],
    requiredCount: (json["requiredCount"] as num?)?.toInt(),
    requiredAmount: (json["requiredAmount"] as num?)?.toDouble(),
  );
}

/*
{
    "success": true,
    "message": "User badges progress retrieved",
    "meta": {
        "page": 1,
        "limit": 10,
        "total": 21,
        "totalPage": 3
    },
    "data": [
        {
            "badge": {
                "_id": "693d27ef5dec7cea8e98213b",
                "name": "Monthly Mover",
                "description": "Maintain consistent monthly donations",
                "icon": "/images/1-1765615599686.jpg",
                "unlockType": "frequency",
                "conditionLogic": "or",
                "specificCategories": [],
                "tiers": [
                    {
                        "tier": "colour",
                        "name": "Monthly Starter",
                        "requiredCount": 1,
                        "requiredAmount": 0
                    },
                    {
                        "tier": "bronze",
                        "name": "Monthly Regular",
                        "requiredCount": 3,
                        "requiredAmount": 0
                    },
                    {
                        "tier": "silver",
                        "name": "Monthly Champion",
                        "requiredCount": 6,
                        "requiredAmount": 0
                    },
                    {
                        "tier": "gold",
                        "name": "Monthly Mover",
                        "requiredCount": 12,
                        "requiredAmount": 0
                    }
                ],
                "isSingleTier": false,
                "isActive": true,
                "priority": 0,
                "featured": false,
                "createdAt": "2025-12-13T08:46:39.804Z",
                "updatedAt": "2025-12-13T08:46:39.804Z"
            },
            "userBadge": {
                "_id": "69411eb1e04b40ceaa3a4a3c",
                "user": "69411932aee83632dca37e12",
                "badge": "693d27ef5dec7cea8e98213b",
                "consecutiveMonths": 0,
                "createdAt": "2025-12-16T08:56:14.288Z",
                "currentTier": "colour",
                "isCompleted": false,
                "lastDonationDate": "2025-12-17T06:49:58.716Z",
                "progressAmount": 56.17,
                "progressCount": 0,
                "tiersUnlocked": [
                    {
                        "tier": "colour",
                        "unlockedAt": "2025-12-16T08:56:14.286Z",
                        "_id": "69411eae3429fa17bf841107"
                    }
                ],
                "uniqueCategoryNames": [],
                "updatedAt": "2025-12-17T06:50:03.334Z"
            },
            "isUnlocked": true,
            "currentTier": "colour",
            "nextTier": {
                "tier": "bronze",
                "name": "Monthly Regular",
                "requiredCount": 3,
                "requiredAmount": 0
            },
            "progressCount": 0,
            "progressAmount": 56.17,
            "progressPercentage": 0,
            "remainingForNextTier": 3
        }
        
    ]
}
*/
