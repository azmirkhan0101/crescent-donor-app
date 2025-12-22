/*
{
    "success": true,
    "message": "Causes retrieved successfully!",
    "meta": {
        "page": 1,
        "limit": 10,
        "total": 2,
        "totalPage": 1
    },
    "data": [
        {
            "_id": "691fafc80a2c30ccc3298318",
            "name": "Free Education",
            "description": "Give free education to road side people",
            "category": "education",
            "status": "verified",
            "organization": {
                "_id": "69130150657488a9ad8460e8",
                "name": "Mostafizur Rahaman ORG",
                "serviceType": "Community Service",
                "coverImage": "public/images/glass-door-logo-1-1763739264952.png",
                "registeredCharityName": "Helping Hands Foundation",
                "aboutUs": "We are a trusted and innovative company committed to delivering high-quality services and exceptional customer experience.",
                "dateOfEstablishment": "2018-05-14T00:00:00.000Z",
                "isProfileVisible": true,
                "logoImage": "public/images/glass-door-logo-1-1763739693271.png"
            },
            "createdAt": "2025-11-21T00:18:16.003Z",
            "updatedAt": "2025-11-21T00:19:09.593Z",
            "totalDonationAmount": 5,
            "totalDonors": 1,
            "totalDonations": 1,
            "recentDonors": []
        },
        {
            "_id": "691fa5a60dba103068187fdb",
            "name": "backpacks and books",
            "description": "Providing quality education to underprivileged children around the world",
            "category": "education",
            "status": "verified",
            "organization": {
                "_id": "69130150657488a9ad8460e8",
                "name": "Mostafizur Rahaman ORG",
                "serviceType": "Community Service",
                "coverImage": "public/images/glass-door-logo-1-1763739264952.png",
                "registeredCharityName": "Helping Hands Foundation",
                "aboutUs": "We are a trusted and innovative company committed to delivering high-quality services and exceptional customer experience.",
                "dateOfEstablishment": "2018-05-14T00:00:00.000Z",
                "isProfileVisible": true,
                "logoImage": "public/images/glass-door-logo-1-1763739693271.png"
            },
            "createdAt": "2025-11-20T23:35:02.241Z",
            "updatedAt": "2025-11-20T23:35:02.241Z",
            "totalDonationAmount": 86.41,
            "totalDonors": 4,
            "totalDonations": 42,
            "recentDonors": [
                {
                    "_id": "692148851592829c1823c4dd",
                    "name": "CC Test 1",
                    "image": "public/images/cbdc76580c32e7f726905f5a07893bd457477501-1763789380218.png",
                    "donationDate": "2025-11-22T02:00:02.579Z",
                    "amount": 2,
                    "cause": "691fa5a60dba103068187fdb"
                },
                {
                    "_id": "69219eb8013d9c2cf75aed54",
                    "name": "CC Test 10",
                    "image": "public/images/scaled_24-1763811000065.jpg",
                    "donationDate": "2025-11-21T06:30:01.026Z",
                    "amount": 2,
                    "cause": "691fa5a60dba103068187fdb"
                },
                {
                    "_id": "6912d645ded449bd7a163fe0",
                    "name": "John Doe",
                    "image": "public/images/download-1762842181583.jpg",
                    "donationDate": "2025-11-21T06:00:52.572Z",
                    "amount": 4.41,
                    "cause": "691fa5a60dba103068187fdb"
                }
            ]
        }
    ]
}
*/

import 'package:cresent_charge_user_app/features/common/models/meta_model.dart';
import 'package:cresent_charge_user_app/features/home/models/donor_model.dart';
import 'package:cresent_charge_user_app/features/home/models/organization_model.dart';

class CauseResponseModel {
  final bool success;
  final String message;
  final MetaModel meta;
  final List<CauseData> data;

  CauseResponseModel({
    required this.success,
    required this.message,
    required this.meta,
    required this.data,
  });

  factory CauseResponseModel.fromJson(Map<String, dynamic> json) {
    return CauseResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      meta: MetaModel.fromJson(json['meta'] ?? {}),
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => CauseData.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class CauseData {
  final String id;
  final String name;
  final String description;
  final String category;
  final String status;
  final OrganizationModel organization;
  final String createdAt;
  final String updatedAt;
  final double totalDonationAmount;
  final int totalDonors;
  final int totalDonations;
  final List<DonorModel> recentDonors;

  CauseData({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.status,
    required this.organization,
    required this.createdAt,
    required this.updatedAt,
    required this.totalDonationAmount,
    required this.totalDonors,
    required this.totalDonations,
    required this.recentDonors,
  });

  factory CauseData.fromJson(Map<String, dynamic> json) {
    return CauseData(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      status: json['status'] ?? '',
      organization: OrganizationModel.fromJson(json['organization'] ?? {}),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      totalDonationAmount: (json['totalDonationAmount'] != null)
          ? (json['totalDonationAmount'] as num).toDouble()
          : 0.0,
      totalDonors: json['totalDonors'] ?? 0,
      totalDonations: json['totalDonations'] ?? 0,
      recentDonors:
          (json['recentDonors'] as List<dynamic>?)
              ?.map((item) => DonorModel.fromJson(item))
              .toList() ??
          [],
    );
  }
}
