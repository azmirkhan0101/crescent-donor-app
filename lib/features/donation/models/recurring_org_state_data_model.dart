/*
{
    "success": true,
    "message": "Recurring donation stats fetched successfully!",
    "data": {
        "organization": {
            "_id": "6930218bddbf3fdf987e870d",
            "name": "Fahim ORG",
            "serviceType": "non-profit",
            "address": "12 Main Road",
            "state": "VIC",
            "website": "https://greencare.org",
            "coverImage": "public/images/banner-1765001759395.png",
            "country": "",
            "aboutUs": "",
            "registeredCharityName": "Eden Blankenship",
            "logoImage": "public/images/download-(4)-1765001783867.jpg"
        },
        "upcommingDoantions": [
            {
                "_id": "693163efb090c6ce66edf17a",
                "amount": 2,
                "coverFees": true,
                "frequency": "daily",
                "startDate": "2025-12-04T10:35:27.592Z",
                "nextDonationDate": "2025-12-11T08:57:21.962Z"
            },
            {
                "_id": "693941adf03bd63660b877ff",
                "amount": 7,
                "coverFees": true,
                "frequency": "custom",
                "customInterval": {
                    "value": 1,
                    "unit": "weeks"
                },
                "startDate": "2025-12-10T09:48:00.000Z",
                "nextDonationDate": "2025-12-17T09:48:05.600Z"
            }
        ],
        "previousDonations": [
            {
                "_id": "693941d2f03bd63660b8780b",
                "donationType": "recurring",
                "amount": 7,
                "platformFee": 0.35,
                "gstOnFee": 0.03,
                "stripeFee": 0.44,
                "netAmount": 7,
                "totalAmount": 7.82,
                "donationDate": "2025-12-10T09:48:02.607Z",
                "scheduledDonationId": {
                    "customInterval": {
                        "value": 1,
                        "unit": "weeks"
                    },
                    "_id": "693941adf03bd63660b877ff",
                    "frequency": "custom",
                    "isActive": true
                }
            },
            {
                "_id": "693165015d6d6dadecab11f2",
                "donationType": "recurring",
                "amount": 2,
                "platformFee": 0.1,
                "gstOnFee": 0.01,
                "stripeFee": 0.34,
                "netAmount": 1.89,
                "totalAmount": 2.34,
                "donationDate": "2025-12-04T10:40:01.285Z",
                "scheduledDonationId": {
                    "_id": "69316416b090c6ce66edf181",
                    "frequency": "daily",
                    "isActive": true
                }
            }
        ]
    }
}
*/

class RecurringOrgStateDataModel {
  final RecurringOrganizationModel organization;
  final List<RecurringUpcomingModel> upcomingDonations;
  final List<RecurringPreviousModel> previousDonations;

  RecurringOrgStateDataModel({
    required this.organization,
    required this.upcomingDonations,
    required this.previousDonations,
  });

  factory RecurringOrgStateDataModel.fromJson(Map<String, dynamic> json) {
    return RecurringOrgStateDataModel(
      organization: RecurringOrganizationModel.fromJson(
        json['organization'] ?? {},
      ),
      upcomingDonations: ((json['upcommingDoantions'] ?? []) as List)
          .map((e) => RecurringUpcomingModel.fromJson(e))
          .toList(),
      previousDonations: ((json['previousDonations'] ?? []) as List)
          .map((e) => RecurringPreviousModel.fromJson(e))
          .toList(),
    );
  }
}

class RecurringOrganizationModel {
  final String id;
  final String name;
  final String serviceType;
  final String address;
  final String state;
  final String website;
  final String coverImage;
  final String country;
  final String aboutUs;
  final String registeredCharityName;
  final String logoImage;

  RecurringOrganizationModel({
    required this.id,
    required this.name,
    required this.serviceType,
    required this.address,
    required this.state,
    required this.website,
    required this.coverImage,
    required this.country,
    required this.aboutUs,
    required this.registeredCharityName,
    required this.logoImage,
  });

  factory RecurringOrganizationModel.fromJson(Map<String, dynamic> json) {
    return RecurringOrganizationModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      serviceType: json['serviceType'] ?? '',
      address: json['address'] ?? '',
      state: json['state'] ?? '',
      website: json['website'] ?? '',
      coverImage: json['coverImage'] ?? '',
      country: json['country'] ?? '',
      aboutUs: json['aboutUs'] ?? '',
      registeredCharityName: json['registeredCharityName'] ?? '',
      logoImage: json['logoImage'] ?? '',
    );
  }
}

class RecurringUpcomingModel {
  final String id;
  final double amount;
  final bool coverFees;
  final String frequency;
  final DateTime startDate;
  final DateTime nextDonationDate;
  final CustomInterval? customInterval;

  RecurringUpcomingModel({
    required this.id,
    required this.amount,
    required this.coverFees,
    required this.frequency,
    required this.startDate,
    required this.nextDonationDate,
    this.customInterval,
  });

  factory RecurringUpcomingModel.fromJson(Map<String, dynamic> json) {
    return RecurringUpcomingModel(
      id: json['_id'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      coverFees: json['coverFees'] ?? false,
      frequency: json['frequency'] ?? '',
      startDate: DateTime.parse(json['startDate'] ?? ''),
      nextDonationDate: DateTime.parse(json['nextDonationDate'] ?? ''),
      customInterval: json['customInterval'] != null
          ? CustomInterval.fromJson(json['customInterval'])
          : null,
    );
  }
}

class CustomInterval {
  final int value;
  final String unit;

  CustomInterval({required this.value, required this.unit});

  factory CustomInterval.fromJson(Map<String, dynamic> json) {
    return CustomInterval(
      value: (json['value'] ?? 0).toInt(),
      unit: json['unit'] ?? '',
    );
  }
}

class RecurringPreviousModel {
  final String id;
  final String donationType;
  final double amount;
  final double platformFee;
  final double gstOnFee;
  final double stripeFee;
  final double netAmount;
  final double totalAmount;
  final DateTime donationDate;
  final ScheduledDonation scheduledDonationId;
  final String status;

  RecurringPreviousModel({
    required this.id,
    required this.donationType,
    required this.amount,
    required this.platformFee,
    required this.gstOnFee,
    required this.stripeFee,
    required this.netAmount,
    required this.totalAmount,
    required this.donationDate,
    required this.scheduledDonationId,
    required this.status,
  });

  factory RecurringPreviousModel.fromJson(Map<String, dynamic> json) {
    return RecurringPreviousModel(
      id: json['_id'] ?? '',
      donationType: json['donationType'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      platformFee: (json['platformFee'] ?? 0).toDouble(),
      gstOnFee: (json['gstOnFee'] ?? 0).toDouble(),
      stripeFee: (json['stripeFee'] ?? 0).toDouble(),
      netAmount: (json['netAmount'] ?? 0).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      donationDate: DateTime.parse(json['donationDate'] ?? ''),
      scheduledDonationId: ScheduledDonation.fromJson(
        json['scheduledDonationId'] ?? {},
      ),
      status: json['status'] ?? '',
    );
  }
}

class ScheduledDonation {
  final String id;
  final String frequency;
  final bool isActive;
  final CustomInterval? customInterval;

  ScheduledDonation({
    required this.id,
    required this.frequency,
    required this.isActive,
    this.customInterval,
  });

  factory ScheduledDonation.fromJson(Map<String, dynamic> json) {
    return ScheduledDonation(
      id: json['_id'] ?? '',
      frequency: json['frequency'] ?? '',
      isActive: json['isActive'] ?? false,
      customInterval: json['customInterval'] != null
          ? CustomInterval.fromJson(json['customInterval'])
          : null,
    );
  }
}
