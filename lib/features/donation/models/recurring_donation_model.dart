/*
{
    "success": true,
    "message": "Scheduled donations retrieved successfully",
    "meta": {
        "page": 1,
        "limit": 10,
        "total": 4,
        "totalPage": 1
    },
    "data": [
        {
            "_id": "6941904582174c460738173d",
            "user": "69411932aee83632dca37e12",
            "organization": {
                "_id": "69411a87aee83632dca37e54",
                "name": "Test ORG"
            },
            "amount": 1,
            "coverFees": true,
            "currency": "USD",
            "cause": {
                "_id": "69412fbeeaa7c8a7c9ca04b7",
                "name": "Test",
                "description": "Maiores ad repudiand"
            },
            "specialMessage": "Weekly support for this amazing cause!",
            "stripeCustomerId": "cus_Tc7nT6WJBnfpai",
            "paymentMethod": "69411a39aee83632dca37e46",
            "frequency": "daily",
            "startDate": "2025-12-16T17:02:52.610Z",
            "nextDonationDate": "2025-12-17T17:06:03.025Z",
            "isActive": true,
            "status": "active",
            "totalExecutions": 1,
            "createdAt": "2025-12-16T17:00:53.065Z",
            "updatedAt": "2025-12-20T11:55:00.785Z",
            "__v": 0,
            "lastExecutedDate": "2025-12-16T17:06:03.025Z"
        },
        {
            "_id": "6941891e991f7ff37b0df2bc",
            "user": "69411932aee83632dca37e12",
            "organization": {
                "_id": "69411a87aee83632dca37e54",
                "name": "Test ORG"
            },
            "amount": 4,
            "coverFees": true,
            "currency": "USD",
            "cause": {
                "_id": "69412fbeeaa7c8a7c9ca04b7",
                "name": "Test",
                "description": "Maiores ad repudiand"
            },
            "specialMessage": "Weekly support for this amazing cause!",
            "stripeCustomerId": "cus_Tc7nT6WJBnfpai",
            "paymentMethod": "69411a39aee83632dca37e46",
            "frequency": "daily",
            "startDate": "2025-12-16T16:32:22.423Z",
            "nextDonationDate": "2025-12-17T16:51:03.067Z",
            "isActive": true,
            "status": "active",
            "totalExecutions": 2,
            "createdAt": "2025-12-16T16:30:22.858Z",
            "updatedAt": "2025-12-20T11:55:00.789Z",
            "__v": 0,
            "lastExecutedDate": "2025-12-16T16:51:03.067Z"
        },
        {
            "_id": "69414643a4532242abd6ad11",
            "user": "69411932aee83632dca37e12",
            "organization": {
                "_id": "69411a87aee83632dca37e54",
                "name": "Test ORG"
            },
            "amount": 4,
            "coverFees": true,
            "currency": "USD",
            "cause": {
                "_id": "69412fbeeaa7c8a7c9ca04b7",
                "name": "Test",
                "description": "Maiores ad repudiand"
            },
            "specialMessage": "Weekly support for this amazing cause!",
            "stripeCustomerId": "cus_Tc7nT6WJBnfpai",
            "paymentMethod": "69411a39aee83632dca37e46",
            "frequency": "daily",
            "startDate": "2025-12-16T11:50:00.000Z",
            "nextDonationDate": "2025-12-17T16:46:03.004Z",
            "isActive": true,
            "status": "active",
            "totalExecutions": 1,
            "createdAt": "2025-12-16T11:45:07.983Z",
            "updatedAt": "2025-12-20T11:55:00.764Z",
            "__v": 0,
            "lastExecutedDate": "2025-12-16T16:46:03.004Z"
        },
        {
            "_id": "6941458aa4532242abd6ad04",
            "user": "69411932aee83632dca37e12",
            "organization": {
                "_id": "69411a87aee83632dca37e54",
                "name": "Test ORG"
            },
            "amount": 4,
            "coverFees": true,
            "currency": "USD",
            "cause": {
                "_id": "69412fbeeaa7c8a7c9ca04b7",
                "name": "Test",
                "description": "Maiores ad repudiand"
            },
            "specialMessage": "Weekly support for this amazing cause!",
            "stripeCustomerId": "cus_Tc7nT6WJBnfpai",
            "paymentMethod": "69411a39aee83632dca37e46",
            "frequency": "daily",
            "startDate": "2025-12-16T12:24:00.000Z",
            "nextDonationDate": "2025-12-16T12:24:00.000Z",
            "isActive": true,
            "status": "processing",
            "totalExecutions": 0,
            "createdAt": "2025-12-16T11:42:02.090Z",
            "updatedAt": "2025-12-16T15:32:01.219Z",
            "__v": 0
        }
    ]
}
*/

import 'package:cresent_charge_user_app/features/donation/models/recurring_org_state_data_model.dart';

class RecurringDonationModel {
  String id;
  String userId;
  OrganizationDetails organization;
  double amount;
  bool coverFees;
  String currency;
  CauseDetails? cause;
  String specialMessage;
  String stripeCustomerId;
  String paymentMethodId;
  String frequency;
  String startDate;
  String nextDonationDate;
  bool isActive;
  String status;
  int totalExecutions;
  String createdAt;
  String updatedAt;
  String? lastExecutedDate;
  CustomInterval? customInterval;

  RecurringDonationModel({
    required this.id,
    required this.userId,
    required this.organization,
    required this.amount,
    required this.coverFees,
    required this.currency,
    this.cause,
    required this.specialMessage,
    required this.stripeCustomerId,
    required this.paymentMethodId,
    required this.frequency,
    required this.startDate,
    required this.nextDonationDate,
    required this.isActive,
    required this.status,
    required this.totalExecutions,
    required this.createdAt,
    required this.updatedAt,
    this.lastExecutedDate,
    this.customInterval,
  });

  factory RecurringDonationModel.fromJson(Map<String, dynamic> json) {
    return RecurringDonationModel(
      id: json['_id'] as String,
      userId: json['user'] as String,
      organization: OrganizationDetails.fromJson(
        json['organization'] as Map<String, dynamic>,
      ),
      amount: (json['amount'] as num).toDouble(),
      coverFees: json['coverFees'] as bool,
      currency: json['currency'] as String,
      cause: json['cause'] != null
          ? CauseDetails.fromJson(json['cause'] as Map<String, dynamic>)
          : null,
      specialMessage: (json['specialMessage'] ?? '') as String,
      stripeCustomerId: json['stripeCustomerId'] as String,
      paymentMethodId: json['paymentMethod'] as String,
      frequency: json['frequency'] as String,
      startDate: json['startDate'] as String,
      nextDonationDate: json['nextDonationDate'] as String,
      isActive: json['isActive'] as bool,
      status: json['status'] as String,
      totalExecutions: json['totalExecutions'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      lastExecutedDate: json['lastExecutedDate'] as String?,
      customInterval: json['customInterval'] != null
          ? CustomInterval.fromJson(
              json['customInterval'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class OrganizationDetails {
  String id;
  String name;

  OrganizationDetails({required this.id, required this.name});

  factory OrganizationDetails.fromJson(Map<String, dynamic> json) {
    return OrganizationDetails(
      id: json['_id'] as String,
      name: json['name'] as String,
    );
  }
}

class CauseDetails {
  String id;
  String name;
  String description;

  CauseDetails({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CauseDetails.fromJson(Map<String, dynamic> json) {
    return CauseDetails(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }
}
