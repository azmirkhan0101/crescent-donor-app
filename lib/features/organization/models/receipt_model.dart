// /// Receipt Models
// /// Response model for GET /receipt/:receiptId



// class ReceiptResponse {
//   final bool success;
//   final String message;
//   final ReceiptModel data;

//   ReceiptResponse({
//     required this.success,
//     required this.message,
//     required this.data,
//   });

//   factory ReceiptResponse.fromJson(Map<String, dynamic> json) {
//     return ReceiptResponse(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//       data: ReceiptModel.fromJson(json['data'] ?? {}),
//     );
//   }
// }

// class ReceiptModel {
//   final String id;
//   final String donation;
//   final ReceiptDonor donor;
//   final ReceiptOrganization organization;
//   final ReceiptCause cause;
//   final String receiptNumber;
//   final double amount;
//   final double platformFee;
//   final double gstOnFee;
//   final double stripeFee;
//   final double totalAmount;
//   final String currency;
//   final String donationType;
//   final String donationDate;
//   final String paymentMethod;
//   final bool taxDeductible;
//   final String? abnNumber;
//   final bool zakatEligible;
//   final String pdfUrl;
//   final String pdfKey;
//   final bool emailSent;
//   final int emailAttempts;
//   final String donorName;
//   final String donorEmail;
//   final String organizationName;
//   final String organizationEmail;
//   final String organizationAddress;
//   final String? specialMessage;
//   final String status;
//   final String generatedAt;
//   final String createdAt;
//   final String updatedAt;
//   final String? emailSentAt;

//   ReceiptModel({
//     required this.id,
//     required this.donation,
//     required this.donor,
//     required this.organization,
//     required this.cause,
//     required this.receiptNumber,
//     required this.amount,
//     required this.platformFee,
//     required this.gstOnFee,
//     required this.stripeFee,
//     required this.totalAmount,
//     required this.currency,
//     required this.donationType,
//     required this.donationDate,
//     required this.paymentMethod,
//     required this.taxDeductible,
//     this.abnNumber,
//     required this.zakatEligible,
//     required this.pdfUrl,
//     required this.pdfKey,
//     required this.emailSent,
//     required this.emailAttempts,
//     required this.donorName,
//     required this.donorEmail,
//     required this.organizationName,
//     required this.organizationEmail,
//     required this.organizationAddress,
//     this.specialMessage,
//     required this.status,
//     required this.generatedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     this.emailSentAt,
//   });

//   factory ReceiptModel.fromJson(Map<String, dynamic> json) {
//     return ReceiptModel(
//       id: json['_id'] ?? '',
//       donation: json['donation'] ?? '',
//       donor: ReceiptDonor.fromJson(json['donor'] ?? {}),
//       organization: ReceiptOrganization.fromJson(json['organization'] ?? {}),
//       cause: ReceiptCause.fromJson(json['cause'] ?? {}),
//       receiptNumber: json['receiptNumber'] ?? '',
//       amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
//       platformFee: (json['platformFee'] as num?)?.toDouble() ?? 0.0,
//       gstOnFee: (json['gstOnFee'] as num?)?.toDouble() ?? 0.0,
//       stripeFee: (json['stripeFee'] as num?)?.toDouble() ?? 0.0,
//       totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0.0,
//       currency: json['currency'] ?? '',
//       donationType: json['donationType'] ?? '',
//       donationDate: json['donationDate'] ?? '',
//       paymentMethod: json['paymentMethod'] ?? '',
//       taxDeductible: json['taxDeductible'] ?? false,
//       abnNumber: json['abnNumber'],
//       zakatEligible: json['zakatEligible'] ?? false,
//       pdfUrl: json['pdfUrl'] ?? '',
//       pdfKey: json['pdfKey'] ?? '',
//       emailSent: json['emailSent'] ?? false,
//       emailAttempts: json['emailAttempts'] ?? 0,
//       donorName: json['donorName'] ?? '',
//       donorEmail: json['donorEmail'] ?? '',
//       organizationName: json['organizationName'] ?? '',
//       organizationEmail: json['organizationEmail'] ?? '',
//       organizationAddress: json['organizationAddress'] ?? '',
//       specialMessage: json['specialMessage'],
//       status: json['status'] ?? '',
//       generatedAt: json['generatedAt'] ?? '',
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//       emailSentAt: json['emailSentAt'],
//     );
//   }
// }

// class ReceiptDonor {
//   final String id;
//   final String name;
//   final String? image;

//   ReceiptDonor({required this.id, required this.name, this.image});

//   factory ReceiptDonor.fromJson(Map<String, dynamic> json) {
//     return ReceiptDonor(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       image: json['image'],
//     );
//   }
// }

// class ReceiptOrganization {
//   final String id;
//   final String name;
//   final String? logoImage;

//   ReceiptOrganization({required this.id, required this.name, this.logoImage});

//   factory ReceiptOrganization.fromJson(Map<String, dynamic> json) {
//     return ReceiptOrganization(
//       id: json['_id'] ?? json['id'] ?? '',
//       name: json['name'] ?? '',
//       logoImage: json['logoImage'],
//     );
//   }
// }

// class ReceiptCause {
//   final String id;
//   final String name;
//   final String? category;

//   ReceiptCause({required this.id, required this.name, this.category});

//   factory ReceiptCause.fromJson(Map<String, dynamic> json) {
//     return ReceiptCause(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       category: json['category'],
//     );
//   }
// }
