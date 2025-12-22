/*
{
    "success": true,
    "message": "Badge history retrieved",
    "data": {
        "badge": {
            "name": "First Drop",
            "icon": "/images/1-1765615580154.jpg",
            "description": "Welcome! You've made your first donation"
        },
        "progress": {
            "currentTier": "one-tier",
            "nextTier": "Completed",
            "remaining": 0,
            "unit": "amount",
            "percentage": 100
        },
        "recentDonations": [
            {
                "title": "Yesterday",
                "data": [
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "22 hours ago",
                        "amount": "+$2"
                    }
                ]
            },
            {
                "title": "Dec 16, 2025",
                "data": [
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$1"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$4"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$4"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$4"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$4"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$4"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$4"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$4.41"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$4"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$2"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$1"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$1"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$10"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$1"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$1"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$1"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+$1.38"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+1.38"
                    },
                    {
                        "orgName": "Test ORG",
                        "orgLogo": "public/images/screenshot_65-1765879606348.png",
                        "timeAgo": "1 days ago",
                        "amount": "+1",
                        "tierUnlocked": "one-tier"
                    }
                ]
            }
        ]
    }
}
*/

import 'package:cresent_charge_user_app/features/donation/models/recent_donations_groupe_model.dart';

class BadgeHistoryModel {
  final bool success;
  final String message;
  final BadgeHistoryData data;

  BadgeHistoryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BadgeHistoryModel.fromJson(Map<String, dynamic> json) {
    return BadgeHistoryModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: BadgeHistoryData.fromJson(json['data'] ?? {}),
    );
  }
}

class BadgeHistoryData {
  final Badge badge;
  final Progress progress;
  final List<RecentDonationsGroupModel>? recentDonations;

  BadgeHistoryData({
    required this.badge,
    required this.progress,
    this.recentDonations,
  });

  factory BadgeHistoryData.fromJson(Map<String, dynamic> json) {
    return BadgeHistoryData(
      badge: Badge.fromJson(json['badge'] ?? {}),
      progress: Progress.fromJson(json['progress'] ?? {}),
      recentDonations: (json['recentDonations'] as List?)
          ?.map((e) => RecentDonationsGroupModel.fromJson(e))
          .toList(),
    );
  }
}

class Badge {
  final String name;
  final String icon;
  final String description;

  Badge({required this.name, required this.icon, required this.description});

  factory Badge.fromJson(Map<String, dynamic> json) {
    return Badge(
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Progress {
  final String currentTier;
  final String nextTier;
  final int remaining;
  final String unit;
  final int percentage;

  Progress({
    required this.currentTier,
    required this.nextTier,
    required this.remaining,
    required this.unit,
    required this.percentage,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      currentTier: json['currentTier'] ?? '',
      nextTier: json['nextTier'] ?? '',
      remaining: json['remaining'] ?? 0,
      unit: json['unit'] ?? '',
      percentage: json['percentage'] ?? 0,
    );
  }
}
