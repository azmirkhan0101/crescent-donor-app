/*
{
    "success": true,
    "message": "One time donation stats fetched successfully!",
    "data": {
        "totalDonated": 425,
        "todaysTotalDonation": 200,
        "recentDonations": [
            {
                "donations": [
                    {
                        "donationId": "69385cd5a0438a468b4a384b",
                        "amount": 100,
                        "orgName": "Fahim ORG",
                        "registeredCharityName": "Eden Blankenship",
                        "orgLogo": "public/images/download-(4)-1765001783867.jpg",
                        "timeAgo": "Just now",
                        "createdAt": "2025-12-09T17:31:01.079Z"
                    },
                    {
                        "donationId": "69385cc7a0438a468b4a3823",
                        "amount": 100,
                        "orgName": "Fahim ORG",
                        "registeredCharityName": "Eden Blankenship",
                        "orgLogo": "public/images/download-(4)-1765001783867.jpg",
                        "timeAgo": "Just now",
                        "createdAt": "2025-12-09T17:30:47.019Z"
                    }
                ],
                "title": "Today"
            },
            {
                "donations": [
                    {
                        "donationId": "6935740843499434c8854743",
                        "amount": 100,
                        "orgName": "Fahim ORG",
                        "registeredCharityName": "Eden Blankenship",
                        "orgLogo": "public/images/download-(4)-1765001783867.jpg",
                        "timeAgo": "2 days ago",
                        "createdAt": "2025-12-07T12:33:12.488Z"
                    },
                    {
                        "donationId": "6935739b43499434c8854713",
                        "amount": 100,
                        "orgName": "Fahim ORG",
                        "registeredCharityName": "Eden Blankenship",
                        "orgLogo": "public/images/download-(4)-1765001783867.jpg",
                        "timeAgo": "2 days ago",
                        "createdAt": "2025-12-07T12:31:23.155Z"
                    },
                    {
                        "donationId": "6935717893ccd0c0788fc0b7",
                        "amount": 10,
                        "orgName": "Fahim ORG",
                        "registeredCharityName": "Eden Blankenship",
                        "orgLogo": "public/images/download-(4)-1765001783867.jpg",
                        "timeAgo": "2 days ago",
                        "createdAt": "2025-12-07T12:22:16.398Z"
                    }
                ],
                "title": "7 Dec 2025"
            }
        ]
    }
}
*/

import 'package:cresent_charge_user_app/features/donation/models/recent_donations_groupe_model.dart';

class OneTimeStatesModel {
  final bool success;
  final String message;
  final OneTimeData data;

  OneTimeStatesModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory OneTimeStatesModel.fromJson(Map<String, dynamic> json) {
    return OneTimeStatesModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: OneTimeData.fromJson(json['data'] ?? {}),
    );
  }
}

class OneTimeData {
  final double totalDonated;
  final double todaysTotalDonation;
  final List<RecentDonationsGroupModel> recentDonations;

  OneTimeData({
    required this.totalDonated,
    required this.todaysTotalDonation,
    required this.recentDonations,
  });

  factory OneTimeData.fromJson(Map<String, dynamic> json) {
    return OneTimeData(
      totalDonated: (json['totalDonated'] ?? 0).toDouble(),
      todaysTotalDonation: (json['todaysTotalDonation'] ?? 0).toDouble(),
      recentDonations: (json['recentDonations'] as List? ?? const [])
          .map((e) => RecentDonationsGroupModel.fromJson(e))
          .toList(),
    );
  }
}
