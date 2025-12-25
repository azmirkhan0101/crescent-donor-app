import 'package:cresent_charge_user_app/core/helper/tost_message/toast_message.dart';
import 'package:cresent_charge_user_app/features/organization/models/donation_full_status_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Get Donation Full Status Controller
///
/// Handles fetching and managing donation status details
class GetDonationFullStatusController extends GetxController {
  var donationFullStatus = Rx<DonationFullStatusData?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  /// Fetch donation full status from API
  Future<bool> fetchDonationFullStatus(String donationId) async {
    isLoading.value = true;
    errorMessage.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      ApiUrl.getDonationFullStatus(donationId),
      withAuth: true,
    );

    isLoading.value = false;

    return response.fold(
      (error) {
        errorMessage.value = error.message ?? 'Failed to fetch donation status';
        debugPrint('Error fetching donation status: ${error.message}');
        ToastMsg.error(errorMessage.value);
        return false;
      },
      (data) {
        final donationStatusResponse = DonationFullStatusResponse.fromJson(
          data,
        );
        donationFullStatus.value = donationStatusResponse.data;
        debugPrint('Donation status fetched successfully');
        return true;
      },
    );
  }
}
