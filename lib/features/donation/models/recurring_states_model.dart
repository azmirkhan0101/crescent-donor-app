/*
{
    "success": true,
    "message": "Recurring donation stats fetched successfully!",
    "data": {
        "todaysRecurringAmount": 48,
        "today": 10,
        "totalWeeklyRecurringAmount": 17,
        "organizationCount": 1,
        "donations": [
            {
                "_id": "69390c7024faa967ecb00c1f",
                "amount": 7,
                "frequency": "custom",
                "customInterval": {
                    "value": 1,
                    "unit": "weeks"
                },
                "startDate": "2025-12-10T17:40:00.000Z",
                "organizationDetails": {
                    "name": "Fahim ORG",
                    "coverImage": "/public/images/banner-1765001759395.png",
                    "registeredCharityName": "Eden Blankenship",
                    "logoImage": "/public/images/download-(4)-1765001783867.jpg"
                },
                "label": "Every 1 week(s) on Wednesday at 11:40 PM"
            },
            {
                "_id": "69390c6924faa967ecb00c18",
                "amount": 10,
                "frequency": "custom",
                "customInterval": {
                    "value": 1,
                    "unit": "weeks"
                },
                "startDate": "2025-12-10T17:40:00.000Z",
                "organizationDetails": {
                    "name": "Fahim ORG",
                    "coverImage": "/public/images/banner-1765001759395.png",
                    "registeredCharityName": "Eden Blankenship",
                    "logoImage": "/public/images/download-(4)-1765001783867.jpg"
                },
                "label": "Every 1 week(s) on Wednesday at 11:40 PM"
            },
            {
                "_id": "6939077412a907914fbfe27c",
                "amount": 10,
                "frequency": "daily",
                "startDate": "2025-12-10T17:40:00.000Z",
                "organizationDetails": {
                    "name": "Fahim ORG",
                    "coverImage": "/public/images/banner-1765001759395.png",
                    "registeredCharityName": "Eden Blankenship",
                    "logoImage": "/public/images/download-(4)-1765001783867.jpg"
                },
                "label": "Every day at 11:40 PM"
            },
            {
                "_id": "69380156af002a593cccd7ff",
                "amount": 10,
                "frequency": "custom",
                "customInterval": {
                    "value": 2,
                    "unit": "days"
                },
                "startDate": "2025-12-09T11:00:38.327Z",
                "organizationDetails": {
                    "name": "Fahim ORG",
                    "coverImage": "/public/images/banner-1765001759395.png",
                    "registeredCharityName": "Eden Blankenship",
                    "logoImage": "/public/images/download-(4)-1765001783867.jpg"
                },
                "label": "Every 2 day(s) at 5:00 PM"
            },
            {
                "_id": "6938014daf002a593cccd7f8",
                "amount": 10,
                "frequency": "custom",
                "customInterval": {
                    "value": 2,
                    "unit": "days"
                },
                "startDate": "2025-12-09T11:00:29.516Z",
                "organizationDetails": {
                    "name": "Fahim ORG",
                    "coverImage": "/public/images/banner-1765001759395.png",
                    "registeredCharityName": "Eden Blankenship",
                    "logoImage": "/public/images/download-(4)-1765001783867.jpg"
                },
                "label": "Every 2 day(s) at 5:00 PM"
            },
            {
                "_id": "6935734843499434c8854709",
                "amount": 10,
                "frequency": "daily",
                "startDate": "2025-12-07T12:30:00.917Z",
                "organizationDetails": {
                    "name": "Fahim ORG",
                    "coverImage": "/public/images/banner-1765001759395.png",
                    "registeredCharityName": "Eden Blankenship",
                    "logoImage": "/public/images/download-(4)-1765001783867.jpg"
                },
                "label": "Every day at 6:30 PM"
            },
            {
                "_id": "6935734043499434c88546fd",
                "amount": 10,
                "frequency": "daily",
                "startDate": "2025-12-07T12:29:52.575Z",
                "organizationDetails": {
                    "name": "Fahim ORG",
                    "coverImage": "/public/images/banner-1765001759395.png",
                    "registeredCharityName": "Eden Blankenship",
                    "logoImage": "/public/images/download-(4)-1765001783867.jpg"
                },
                "label": "Every day at 6:29 PM"
            },
            {
                "_id": "69316416b090c6ce66edf181",
                "amount": 2,
                "frequency": "daily",
                "startDate": "2025-12-04T10:36:06.411Z",
                "organizationDetails": {
                    "name": "Fahim ORG",
                    "coverImage": "/public/images/banner-1765001759395.png",
                    "registeredCharityName": "Eden Blankenship",
                    "logoImage": "/public/images/download-(4)-1765001783867.jpg"
                },
                "label": "Every day at 4:36 PM"
            },
            {
                "_id": "693163efb090c6ce66edf17a",
                "amount": 2,
                "frequency": "daily",
                "startDate": "2025-12-04T10:35:27.592Z",
                "organizationDetails": {
                    "name": "Fahim ORG",
                    "coverImage": "/public/images/banner-1765001759395.png",
                    "registeredCharityName": "Eden Blankenship",
                    "logoImage": "/public/images/download-(4)-1765001783867.jpg"
                },
                "label": "Every day at 4:35 PM"
            }
        ]
    }
}
*/

class RecurringStatesModel {
  final double todaysRecurringAmount;
  final int today;
  final double totalWeeklyRecurringAmount;
  final int organizationCount;
  final List<RecurringDonation> donations;

  RecurringStatesModel(
    this.todaysRecurringAmount,
    this.today,
    this.totalWeeklyRecurringAmount,
    this.organizationCount,
    this.donations,
  );

  factory RecurringStatesModel.fromJson(Map<String, dynamic> json) {
    return RecurringStatesModel(
      (json['todaysRecurringAmount'] as num).toDouble(),
      json['today'] as int,
      (json['totalWeeklyRecurringAmount'] as num).toDouble(),
      json['organizationCount'] as int,
      (json['donations'] as List<dynamic>)
          .map((e) => RecurringDonation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class RecurringStatesResponse {
  final bool success;
  final String message;
  final RecurringStatesModel data;

  RecurringStatesResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RecurringStatesResponse.fromJson(Map<String, dynamic> json) {
    return RecurringStatesResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: RecurringStatesModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class RecurringDonation {
  final String id;
  final double amount;
  final String frequency;
  final CustomInterval? customInterval;
  final DateTime startDate;
  final OrganizationDetails organizationDetails;
  final String label;

  RecurringDonation({
    required this.id,
    required this.amount,
    required this.frequency,
    this.customInterval,
    required this.startDate,
    required this.organizationDetails,
    required this.label,
  });

  factory RecurringDonation.fromJson(Map<String, dynamic> json) {
    return RecurringDonation(
      id: json['_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      frequency: json['frequency'] as String,
      customInterval: json['customInterval'] == null
          ? null
          : CustomInterval.fromJson(
              json['customInterval'] as Map<String, dynamic>,
            ),
      startDate: DateTime.parse(json['startDate'] as String),
      organizationDetails: OrganizationDetails.fromJson(
        json['organizationDetails'] as Map<String, dynamic>,
      ),
      label: json['label'] as String,
    );
  }
}

class CustomInterval {
  final int value;
  final String unit;

  CustomInterval({required this.value, required this.unit});

  factory CustomInterval.fromJson(Map<String, dynamic> json) {
    return CustomInterval(
      value: json['value'] as int,
      unit: json['unit'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value, 'unit': unit};
  }
}

class OrganizationDetails {
  final String id;
  final String name;
  final String coverImage;
  final String registeredCharityName;
  final String logoImage;

  OrganizationDetails({
    required this.id,
    required this.name,
    required this.coverImage,
    required this.registeredCharityName,
    required this.logoImage,
  });

  factory OrganizationDetails.fromJson(Map<String, dynamic> json) {
    return OrganizationDetails(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      coverImage: json['coverImage'] ?? '',
      registeredCharityName: json['registeredCharityName'] ?? '',
      logoImage: json['logoImage'] ?? '',
    );
  }
}
