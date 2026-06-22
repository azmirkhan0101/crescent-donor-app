
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
