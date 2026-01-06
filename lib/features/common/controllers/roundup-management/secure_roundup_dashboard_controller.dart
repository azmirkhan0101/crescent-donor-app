// import 'package:cresent_charge_user_app/service/api_url.dart';
// import 'package:cresent_charge_user_app/service/network_helper.dart';
// import 'package:get/get.dart';

// /// Model for Secure Roundup Dashboard Response
// class SecureRoundupDashboardResponse {
//   final bool success;
//   final String message;
//   final SecureRoundupDashboardData data;

//   SecureRoundupDashboardResponse({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   factory SecureRoundupDashboardResponse.fromJson(Map<String, dynamic> json) {
//     return SecureRoundupDashboardResponse(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//       data: SecureRoundupDashboardData.fromJson(json['data']),
//     );
//   }
// }

// /// Model for Secure Roundup Dashboard Data
// class SecureRoundupDashboardData {
//   final bool hasRoundUp;
//   final Config? config;
//   final Stats? stats;
//   final BankConnection? bankConnection;
//   final Organization? organization;
//   final Cause? cause;

//   SecureRoundupDashboardData({
//     required this.hasRoundUp,
//     this.config,
//     this.stats,
//     this.bankConnection,
//     this.organization,
//     this.cause,
//   });

//   factory SecureRoundupDashboardData.fromJson(Map<String, dynamic> json) {
//     return SecureRoundupDashboardData(
//       hasRoundUp: json['hasRoundUp'] ?? false,
//       config: json['config'] != null ? Config.fromJson(json['config']) : null,
//       stats: json['stats'] != null ? Stats.fromJson(json['stats']) : null,
//       bankConnection: json['bankConnection'] != null
//           ? BankConnection.fromJson(json['bankConnection'])
//           : null,
//       organization: json['organization'] != null
//           ? Organization.fromJson(json['organization'])
//           : null,
//       cause: json['cause'] != null ? Cause.fromJson(json['cause']) : null,
//     );
//   }
// }

// /// Model for Config
// class Config {
//   final bool coverFees;
//   final String id;
//   final String user;
//   final String organization;
//   final String? cause;
//   final String bankConnection;
//   final String paymentMethod;
//   final bool isTaxable;
//   final double monthlyThreshold;
//   final String? specialMessage;
//   final String status;
//   final bool isActive;
//   final bool enabled;
//   final double totalAccumulated;
//   final double currentMonthTotal;
//   final String? lastMonthReset;
//   final String createdAt;
//   final String updatedAt;
//   final int v;
//   final String? lastDonationAttempt;
//   final String? lastSuccessfulDonation;
//   final bool isThresholdMet;
//   final dynamic daysSinceLastCharitySwitch;

//   Config({
//     required this.coverFees,
//     required this.id,
//     required this.user,
//     required this.organization,
//     this.cause,
//     required this.bankConnection,
//     required this.paymentMethod,
//     required this.isTaxable,
//     required this.monthlyThreshold,
//     this.specialMessage,
//     required this.status,
//     required this.isActive,
//     required this.enabled,
//     required this.totalAccumulated,
//     required this.currentMonthTotal,
//     this.lastMonthReset,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     this.lastDonationAttempt,
//     this.lastSuccessfulDonation,
//     required this.isThresholdMet,
//     this.daysSinceLastCharitySwitch,
//   });

//   factory Config.fromJson(Map<String, dynamic> json) {
//     return Config(
//       coverFees: json['coverFees'] ?? false,
//       id: json['_id'] ?? '',
//       user: json['user'] ?? '',
//       organization: json['organization'] ?? '',
//       cause: json['cause'],
//       bankConnection: json['bankConnection'] ?? '',
//       paymentMethod: json['paymentMethod'] ?? '',
//       isTaxable: json['isTaxable'] ?? false,
//       monthlyThreshold: (json['monthlyThreshold'] as num?)?.toDouble() ?? 0.0,
//       specialMessage: json['specialMessage'],
//       status: json['status'] ?? '',
//       isActive: json['isActive'] ?? false,
//       enabled: json['enabled'] ?? false,
//       totalAccumulated: (json['totalAccumulated'] as num?)?.toDouble() ?? 0.0,
//       currentMonthTotal: (json['currentMonthTotal'] as num?)?.toDouble() ?? 0.0,
//       lastMonthReset: json['lastMonthReset'],
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//       v: json['__v'] ?? 0,
//       lastDonationAttempt: json['lastDonationAttempt'],
//       lastSuccessfulDonation: json['lastSuccessfulDonation'],
//       isThresholdMet: json['isThresholdMet'] ?? false,
//       daysSinceLastCharitySwitch: json['daysSinceLastCharitySwitch'],
//     );
//   }
// }

// /// Model for Stats
// class Stats {
//   final double totalDonated;
//   final int totalRoundUps;
//   final int monthsDonated;
//   final double currentMonthTotal;
//   final CurrentCharity? currentCharity;

//   Stats({
//     required this.totalDonated,
//     required this.totalRoundUps,
//     required this.monthsDonated,
//     required this.currentMonthTotal,
//     this.currentCharity,
//   });

//   factory Stats.fromJson(Map<String, dynamic> json) {
//     return Stats(
//       totalDonated: (json['totalDonated'] as num?)?.toDouble() ?? 0.0,
//       totalRoundUps: json['totalRoundUps'] ?? 0,
//       monthsDonated: json['monthsDonated'] ?? 0,
//       currentMonthTotal: (json['currentMonthTotal'] as num?)?.toDouble() ?? 0.0,
//       currentCharity: json['currentCharity'] != null
//           ? CurrentCharity.fromJson(json['currentCharity'])
//           : null,
//     );
//   }
// }

// /// Model for CurrentCharity
// class CurrentCharity {
//   final String name;
//   final double totalFromUser;

//   CurrentCharity({required this.name, required this.totalFromUser});

//   factory CurrentCharity.fromJson(Map<String, dynamic> json) {
//     return CurrentCharity(
//       name: json['name'] ?? '',
//       totalFromUser: (json['totalFromUser'] as num?)?.toDouble() ?? 0.0,
//     );
//   }
// }

// /// Model for BankConnection
// class BankConnection {
//   final String id;
//   final String user;
//   final String itemId;
//   final String accountId;
//   final String accountName;
//   final String accountType;
//   final String institutionName;
//   final String institutionId;
//   final String consentGivenAt;
//   final bool isActive;
//   final String createdAt;
//   final String updatedAt;
//   final int v;
//   final String? lastSyncAt;
//   final String? lastSyncCursor;

//   BankConnection({
//     required this.id,
//     required this.user,
//     required this.itemId,
//     required this.accountId,
//     required this.accountName,
//     required this.accountType,
//     required this.institutionName,
//     required this.institutionId,
//     required this.consentGivenAt,
//     required this.isActive,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     this.lastSyncAt,
//     this.lastSyncCursor,
//   });

//   factory BankConnection.fromJson(Map<String, dynamic> json) {
//     return BankConnection(
//       id: json['_id'] ?? '',
//       user: json['user'] ?? '',
//       itemId: json['itemId'] ?? '',
//       accountId: json['accountId'] ?? '',
//       accountName: json['accountName'] ?? '',
//       accountType: json['accountType'] ?? '',
//       institutionName: json['institutionName'] ?? '',
//       institutionId: json['institutionId'] ?? '',
//       consentGivenAt: json['consentGivenAt'] ?? '',
//       isActive: json['isActive'] ?? false,
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//       v: json['__v'] ?? 0,
//       lastSyncAt: json['lastSyncAt'],
//       lastSyncCursor: json['lastSyncCursor'],
//     );
//   }
// }

// /// Model for Organization
// class Organization {
//   final String id;
//   final String? auth;
//   final String name;
//   final String serviceType;
//   final String? address;
//   final String? state;
//   final String? postalCode;
//   final String? website;
//   final String? phoneNumber;
//   final String? coverImage;
//   final String? tfnOrAbnNumber;
//   final String? zakatLicenseHolderNumber;
//   final String? boardMemberName;
//   final String? boardMemberEmail;
//   final String? boardMemberPhoneNumber;
//   final String? drivingLicenseURL;
//   final String? country;
//   final String aboutUs;
//   final String dateOfEstablishment;
//   final String registeredCharityName;
//   final bool isProfileVisible;
//   final String createdAt;
//   final String updatedAt;
//   final String? stripeConnectAccountId;
//   final String? logoImage;

//   Organization({
//     required this.id,
//     this.auth,
//     required this.name,
//     required this.serviceType,
//     this.address,
//     this.state,
//     this.postalCode,
//     this.website,
//     this.phoneNumber,
//     this.coverImage,
//     this.tfnOrAbnNumber,
//     this.zakatLicenseHolderNumber,
//     this.boardMemberName,
//     this.boardMemberEmail,
//     this.boardMemberPhoneNumber,
//     this.drivingLicenseURL,
//     this.country,
//     required this.aboutUs,
//     required this.dateOfEstablishment,
//     required this.registeredCharityName,
//     required this.isProfileVisible,
//     required this.createdAt,
//     required this.updatedAt,
//     this.stripeConnectAccountId,
//     this.logoImage,
//   });

//   factory Organization.fromJson(Map<String, dynamic> json) {
//     return Organization(
//       id: json['_id'] ?? '',
//       auth: json['auth'],
//       name: json['name'] ?? '',
//       serviceType: json['serviceType'] ?? '',
//       address: json['address'],
//       state: json['state'],
//       postalCode: json['postalCode'],
//       website: json['website'],
//       phoneNumber: json['phoneNumber'],
//       coverImage: json['coverImage'],
//       tfnOrAbnNumber: json['tfnOrAbnNumber'],
//       zakatLicenseHolderNumber: json['zakatLicenseHolderNumber'],
//       boardMemberName: json['boardMemberName'],
//       boardMemberEmail: json['boardMemberEmail'],
//       boardMemberPhoneNumber: json['boardMemberPhoneNumber'],
//       drivingLicenseURL: json['drivingLicenseURL'],
//       country: json['country'],
//       aboutUs: json['aboutUs'] ?? '',
//       dateOfEstablishment: json['dateOfEstablishment'] ?? '',
//       registeredCharityName: json['registeredCharityName'] ?? '',
//       isProfileVisible: json['isProfileVisible'] ?? false,
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//       stripeConnectAccountId: json['stripeConnectAccountId'],
//       logoImage: json['logoImage'],
//     );
//   }
// }

// /// Model for Cause
// class Cause {
//   final String id;
//   final String name;
//   final String description;
//   final String category;
//   final String status;
//   final String organization;
//   final String createdAt;
//   final String updatedAt;

//   Cause({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.category,
//     required this.status,
//     required this.organization,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Cause.fromJson(Map<String, dynamic> json) {
//     return Cause(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       description: json['description'] ?? '',
//       category: json['category'] ?? '',
//       status: json['status'] ?? '',
//       organization: json['organization'] ?? '',
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//     );
//   }
// }

// class SecureRoundupDashboardController extends GetxController {
//   RxBool isLoading = false.obs;
//   RxString errorMessage = ''.obs;
//   Rx<SecureRoundupDashboardData?> dashboardData =
//       Rx<SecureRoundupDashboardData?>(null);

//   @override
//   void onInit() {
//     super.onInit();
//     fetchDashboard();
//   }

//   Future<void> fetchDashboard() async {
//     isLoading.value = true;
//     errorMessage.value = '';

//     final result = await Get.find<NetworkHelper>().request(
//       'GET',
//       ApiUrl.secureRoundupDashboard,
//       withAuth: true,
//       parser: (data) => SecureRoundupDashboardResponse.fromJson(data),
//     );

//     isLoading.value = false;

//     result.fold(
//       (failure) {
//         errorMessage.value = failure.message ?? 'Failed to load dashboard';
//       },
//       (response) {
//         dashboardData.value = response.data;
//       },
//     );
//   }
// }
