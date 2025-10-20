import 'package:cresent_charge_user_app/core/custom_assets/assets.gen.dart';
import 'package:cresent_charge_user_app/features/organization/models/organization_model.dart';
import 'package:cresent_charge_user_app/features/organization/widgets/donation_bottom_sheet.dart';
import 'package:get/get.dart';

class OrganizationDetailsController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<OrganizationModel?> organization = Rx<OrganizationModel?>(null);
  final RxString error = ''.obs;

  final causes = ['Youth', 'Utilities', 'Emam'];
  final donationAmounts = [
    '\$10',
    '\$25',
    '\$30',
    '\$40',
    '\$50',
    'Custom',
    'None',
  ];
  Rx<DonationType> selectedDonationType = DonationType.recurring.obs;
  RxString selectedCause = 'Youth'.obs;

  @override
  void onInit() {
    super.onInit();
    loadOrganizationData();
  }

  /// change selected donation type
  void changeDonationType(DonationType type) {
    selectedDonationType.value = type;
  }

  // change selected cause
  void changeSelectedCause(String cause) {
    selectedCause.value = cause;
  }

  /// Load organization data - this could be from API in the future
  void loadOrganizationData([String? organizationId]) {
    isLoading.value = true;
    error.value = '';

    try {
      // For now, using mock data. In real app, this would fetch from API
      organization.value = _getMockOrganizationData();
    } catch (e) {
      error.value = 'Failed to load organization data';
    } finally {
      isLoading.value = false;
    }
  }

  /// Get organization name safely
  String getOrganizationName() {
    return organization.value?.name ?? 'Organization';
  }

  /// Check if organization is verified
  bool isOrganizationVerified() {
    return organization.value?.verified ?? false;
  }

  /// Get organization location
  String getOrganizationLocation() {
    return organization.value?.location ?? '';
  }

  /// Get organization description
  String getOrganizationDescription() {
    return organization.value?.description ?? '';
  }

  /// Get organization mission/overview
  String getOrganizationMission() {
    return organization.value?.mission ?? '';
  }

  /// Get organization impact statement
  String getOrganizationImpact() {
    return organization.value?.impact ?? '';
  }

  /// Get organization causes
  List<CauseModel> getOrganizationCauses() {
    return organization.value?.causes ?? [];
  }

  /// Handle donation button tap
  void onDonateNowTapped() {
    // This method can be used to track analytics or perform any business logic
    // before showing the donation bottom sheet
    Get.log('Donate button tapped for organization: ${getOrganizationName()}');
  }

  /// Refresh organization data
  Future<void> refreshData() async {
    loadOrganizationData();
  }

  /// Mock data for development - replace with API call in production
  OrganizationModel _getMockOrganizationData() {
    return OrganizationModel(
      id: '1',
      name: 'Hope for Learning Foundation',
      description: 'Turning hope into opportunity through education.',
      location: 'South Asia',
      category: 'Education',
      logoUrl: Assets.home.donateCauseProfile2.path,
      bannerUrl: Assets.home.donateCauseBanner1.path,
      verified: true,
      rating: 4.8,
      totalDonations: '325,000',
      activeCampaigns: 5,
      beneficiaries: '3,25,000 students',
      establishedYear: 2021,
      website: 'https://hopeforlearning.org',
      email: 'contact@hopeforlearning.org',
      phone: '+1234567890',
      mission:
          'The Hope For Learning Foundation is committed to giving every child—no matter where they\'re from—a fair shot at success. By bridging education gaps, they empower underserved communities globally with access, tools, and opportunity.',
      impact: 'Supported over 3,25,000 students since 2021',
      causes: [
        CauseModel(
          emoji: '📘',
          title: 'Education Support',
          description:
              'Tutoring, mentorship, and youth development programs to help students thrive academically and emotionally.',
        ),
        CauseModel(
          emoji: '🏫',
          title: 'School Infrastructure',
          description:
              'Building and upgrading safe, inclusive learning environments equipped for modern education.',
        ),
        CauseModel(
          emoji: '💡',
          title: 'Essential Utilities',
          description:
              'Keeping schools running with electricity, water, and basic necessities—so learning never stops.',
        ),
      ],
      recentUpdates: [],
    );
  }
}
