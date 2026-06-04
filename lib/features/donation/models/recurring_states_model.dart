
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
