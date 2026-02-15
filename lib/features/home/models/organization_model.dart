/*
{
    "success": true,
    "message": "All organizations retrieved successfully!",
    "meta": {
        "page": 1,
        "limit": 10,
        "total": 2,
        "totalPage": 1
    },
    "data": [
        {
            "_id": "6920518d1ccf4652ca34317a",
            "auth": {
                "_id": "69204dc98ac233b596779a37",
                "email": "dev.mostafiz04@gmail.com",
                "role": "ORGANIZATION",
                "isActive": true,
                "status": "active"
            },
            "name": "Mostafizur Rahaman ORG",
            "serviceType": "Community Service",
            "address": "Moynamati, Joyanalganj -3701",
            "state": "Dhaka",
            "postalCode": "1207",
            "website": "https://www.examplecompany.com",
            "phoneNumber": "+8801700000000",
            "coverImage": null,
            "tfnOrAbnNumber": "12345678901",
            "zakatLicenseHolderNumber": "ZKT-552310",
            "boardMemberName": "John Doe",
            "boardMemberEmail": "john.doe@greencare.org",
            "boardMemberPhoneNumber": "+61 490 777 222",
            "drivingLicenseURL": null,
            "country": "Bangladesh",
            "aboutUs": "We are a trusted and innovative company committed to delivering high-quality services and exceptional customer experience.",
            "dateOfEstablishment": "2018-05-14T00:00:00.000Z",
            "registeredCharityName": "Helping Hands Foundation",
            "isProfileVisible": true,
            "createdAt": "2025-11-21T11:48:29.769Z",
            "updatedAt": "2025-11-21T12:03:02.753Z"
        },
        {
            "_id": "69130150657488a9ad8460e8",
            "auth": {
                "_id": "6912fc90ded449bd7a1640b5",
                "email": "narole2449@fantastu.com",
                "role": "ORGANIZATION",
                "isActive": true
            },
            "name": "Mostafizur Rahaman ORG",
            "serviceType": "Community Service",
            "address": "Moynamati, Joyanalganj -3701",
            "state": "Dhaka",
            "postalCode": "1207",
            "website": "https://www.examplecompany.com",
            "phoneNumber": "+8801700000000",
            "coverImage": "public/images/glass-door-logo-1-1763739264952.png",
            "tfnOrAbnNumber": "12345678901",
            "zakatLicenseHolderNumber": "ZKT-552310",
            "boardMemberName": "John Doe",
            "boardMemberEmail": "john.doe@greencare.org",
            "boardMemberPhoneNumber": "+61 490 777 222",
            "drivingLicenseURL": "public/documents/dummy-pdf_2-1762853200905.pdf",
            "createdAt": "2025-11-11T09:26:40.958Z",
            "updatedAt": "2025-11-21T15:41:33.358Z",
            "stripeConnectAccountId": "acct_1SRmd8GWHts5wdPl",
            "registeredCharityName": "Helping Hands Foundation",
            "aboutUs": "We are a trusted and innovative company committed to delivering high-quality services and exceptional customer experience.",
            "country": "Bangladesh",
            "dateOfEstablishment": "2018-05-14T00:00:00.000Z",
            "isProfileVisible": true,
            "logoImage": "public/images/glass-door-logo-1-1763739693271.png"
        }
    ]
}
*/

import 'package:cresent_charge_user_app/features/common/models/auth_model.dart';
import 'package:cresent_charge_user_app/features/common/models/meta_model.dart';

class OrganizationResponseModel {
  final bool success;
  final String message;
  final MetaModel meta;
  final List<OrganizationModel> data;

  OrganizationResponseModel({
    required this.success,
    required this.message,
    required this.meta,
    required this.data,
  });

  factory OrganizationResponseModel.fromJson(Map<String, dynamic> json) {
    return OrganizationResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      meta: MetaModel.fromJson(json['meta'] ?? {}),
      data: (json['data'] as List<dynamic>? ?? [])
          .map((item) => OrganizationModel.fromJson(item))
          .toList(),
    );
  }
}

class OrganizationModel {
  final String id;
  final String name;
  final String serviceType;
  final String coverImage;
  final String registeredCharityName;
  final String aboutUs;
  final String dateOfEstablishment;
  final bool isProfileVisible;
  final String logoImage;

  final AuthModel? auth;
  final String? address;
  final String? state;
  final String? postalCode;
  final String? website;
  final String? phoneNumber;
  final String? tfnOrAbnNumber;
  final String? zakatLicenseHolderNumber;
  final String? boardMemberName;
  final String? boardMemberEmail;
  final String? boardMemberPhoneNumber;
  final String? drivingLicenseURL;
  final String? createdAt;
  final String? updatedAt;
  final String? stripeConnectAccountId;
  final String? country;

  OrganizationModel({
    required this.id,
    required this.name,
    required this.serviceType,
    required this.coverImage,
    required this.registeredCharityName,
    required this.aboutUs,
    required this.dateOfEstablishment,
    required this.isProfileVisible,
    required this.logoImage,
    this.address,
    this.state,
    this.postalCode,
    this.website,
    this.phoneNumber,
    this.auth,
    this.tfnOrAbnNumber,
    this.zakatLicenseHolderNumber,
    this.boardMemberName,
    this.boardMemberEmail,
    this.boardMemberPhoneNumber,
    this.drivingLicenseURL,
    this.createdAt,
    this.updatedAt,
    this.stripeConnectAccountId,
    this.country,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      serviceType: json['serviceType'] ?? '',
      coverImage: json['coverImage'] ?? '',
      registeredCharityName: json['registeredCharityName'] ?? '',
      aboutUs: json['aboutUs'] ?? '',
      dateOfEstablishment: json['dateOfEstablishment'] ?? '',
      isProfileVisible: json['isProfileVisible'] ?? false,
      logoImage: json['logoImage'] ?? '',
      address: json['address'],
      state: json['state'],
      postalCode: json['postalCode'],
      website: json['website'],
      phoneNumber: json['phoneNumber'],
      auth: json['auth'] != null ? AuthModel.fromJson(json['auth']) : null,
      tfnOrAbnNumber: json['tfnOrAbnNumber'],
      zakatLicenseHolderNumber: json['zakatLicenseHolderNumber'],
      boardMemberName: json['boardMemberName'],
      boardMemberEmail: json['boardMemberEmail'],
      boardMemberPhoneNumber: json['boardMemberPhoneNumber'],
      drivingLicenseURL: json['drivingLicenseURL'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      stripeConnectAccountId: json['stripeConnectAccountId'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'serviceType': serviceType,
      'coverImage': coverImage,
      'registeredCharityName': registeredCharityName,
      'aboutUs': aboutUs,
      'dateOfEstablishment': dateOfEstablishment,
      'isProfileVisible': isProfileVisible,
      'logoImage': logoImage,
      'address': address,
      'state': state,
      'postalCode': postalCode,
      'website': website,
      'phoneNumber': phoneNumber,
      'auth': auth?.toJson(),
      'tfnOrAbnNumber': tfnOrAbnNumber,
      'zakatLicenseHolderNumber': zakatLicenseHolderNumber,
      'boardMemberName': boardMemberName,
      'boardMemberEmail': boardMemberEmail,
      'boardMemberPhoneNumber': boardMemberPhoneNumber,
      'drivingLicenseURL': drivingLicenseURL,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'stripeConnectAccountId': stripeConnectAccountId,
      'country': country,
    };
  }
}
