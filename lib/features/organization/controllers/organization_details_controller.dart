import 'package:cresent_charge_user_app/features/organization/models/organization_details_model.dart';
import 'package:cresent_charge_user_app/features/organization/models/organization_model.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/donation_bottom_sheet.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class OrganizationDetailsController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<OrganizationDetailsModel?> organizationDetails =
      Rx<OrganizationDetailsModel?>(null);
  final RxString error = ''.obs;
  final NetworkHelper _networkHelper = Get.find<NetworkHelper>();
  String? _organizationId;

  // RxString selectedCauseId = ''.obs;

  // final causes = ['Youth', 'Utilities', 'Emam'];
  // final donationAmounts = [
  //   '\$10',
  //   '\$25',
  //   '\$30',
  //   '\$40',
  //   '\$50',
  //   'Custom',
  //   'None',
  // ];

  // Rx<DonationType> selectedDonationType = DonationType.recurring.obs;
  // RxString selectedCause = ''.obs;
  // RxInt selectedAmountIndex = (-1).obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  /// Set organization ID and fetch data
  void setOrganizationId(String organizationId) {
    _organizationId = organizationId;
    fetchOrganizationDetails();
  }

  /// Fetch organization details from API
  Future<void> fetchOrganizationDetails() async {
    if (_organizationId == null || _organizationId!.isEmpty) {
      error.value = 'Organization ID is required';
      return;
    }

    isLoading.value = true;
    error.value = '';

    try {
      final result = await _networkHelper.request(
        'GET',
        ApiUrl.getOrganizationDetails(_organizationId!),
        parser: (data) => data,
      );

      result.fold(
        (failure) {
          error.value =
              failure.message ?? 'Failed to load organization details';
        },
        (response) {
          if (response is Map<String, dynamic> &&
              response['success'] == true &&
              response['data'] != null) {
            organizationDetails.value = OrganizationDetailsModel.fromJson(
              response['data'],
            );
            Get.log(
              'Organization details loaded: id=${organizationDetails.value?.id} name=${organizationDetails.value?.name}',
            );
            // Force a rebuild for any GetBuilder listeners
            update();
          } else {
            error.value = 'Invalid response from server';
          }
        },
      );
    } catch (e) {
      error.value = 'Failed to load organization details: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// change selected donation type
  // void changeDonationType(DonationType type) {
  //   selectedDonationType.value = type;
  // }

  // // change selected cause
  // void changeSelectedCause(String cause) {
  //   selectedCause.value = cause;
  // }

  /// Get organization name safely
  String getOrganizationName() {
    return organizationDetails.value?.name ?? 'Organization';
  }

  /// Check if organization is verified
  bool isOrganizationVerified() {
    return true; // All organizations are verified by default
  }

  /// Get organization location
  String getOrganizationLocation() {
    final org = organizationDetails.value;
    if (org == null) return '';
    return '${org.address}, ${org.state} ${org.postalCode}';
  }

  /// Get organization description
  String getOrganizationDescription() {
    return organizationDetails.value?.aboutUs ?? '';
  }

  /// Get organization mission/overview
  String getOrganizationMission() {
    return organizationDetails.value?.aboutUs ?? '';
  }

  /// Get organization impact statement
  String getOrganizationImpact() {
    return organizationDetails.value?.aboutUs ?? '';
  }

  /// Get organization causes
  List<CauseModel> getOrganizationCauses() {
    // Return empty list for now, can be populated if needed
    return [];
  }

  /// Handle donation button tap
  void onDonateNowTapped() {
    // This method can be used to track analytics or perform any business logic
    // before showing the donation bottom sheet
    Get.log('Donate button tapped for organization: ${getOrganizationName()}');
  }

  /// Refresh organization data
  Future<void> refreshData() async {
    await fetchOrganizationDetails();
  }
}
