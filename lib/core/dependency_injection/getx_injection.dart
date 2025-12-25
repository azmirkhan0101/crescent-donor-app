import 'package:cresent_charge_user_app/core/theme/theme_controller.dart';
import 'package:cresent_charge_user_app/features/auth/controllers/profile_controller.dart';
import 'package:cresent_charge_user_app/features/common/controllers/roundup-management/save_roundup_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/donation_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_badge_history_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_badges_progress_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_recurring_org_state_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_round_up_bank_connection_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/one_time_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/recurring_states_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/round_up_controller.dart';
import 'package:cresent_charge_user_app/features/home/controllers/charities_controller.dart';
import 'package:cresent_charge_user_app/features/home/controllers/search_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/create_recurring_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/get_donation_full_status_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/business_website_count_update_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/cancel_redemption_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/claim_reward_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_all_business_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_all_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_business_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_my_claimed_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_point_balance_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_redemption_detail_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_reward_availability_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_reward_detail_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_store_profile_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/your_rewards_controller.dart';
import 'package:cresent_charge_user_app/global/general_controller/general_controller.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

void initGetx() {
  // ================== Services ==================
  Get.put(NetworkHelper(), permanent: true);

  // ================== Core Controllers ==================
  Get.lazyPut(() => ThemeController(), fenix: true);

  // ================== Global Controller ==================
  Get.lazyPut(() => GeneralController(), fenix: true);

  // ================== Home Controllers ==================
  Get.lazyPut(() => SearchController(), fenix: true);
  Get.lazyPut(() => CharitiesController(), fenix: true);

  // =================== Profile Controllers ==================
  Get.lazyPut(() => ProfileController(), fenix: true);

  // =================== Organization Controllers ==================
  // Get.lazyPut(() => OrganizationController(), fenix: true);

  // =================== Rewards Controllers ==================
  Get.lazyPut(() => GetPointBalanceController(), fenix: true);
  Get.lazyPut(() => YourRewardsController(), fenix: true);
  Get.lazyPut(() => GetAllRewardsController(), fenix: true);
  Get.lazyPut(() => GetBusinessRewardsController(), fenix: true);
  Get.lazyPut(() => ClaimRewardController(), fenix: true);
  Get.lazyPut(() => CancelRedemptionController(), fenix: true);
  Get.lazyPut(() => GetMyClaimedRewardsController(), fenix: true);
  Get.lazyPut(() => GetRedemptionDetailController(), fenix: true);
  Get.lazyPut(() => GetRewardAvailabilityController(), fenix: true);
  Get.lazyPut(() => GetRewardDetailController(), fenix: true);
  Get.lazyPut(() => GetAllBusinessController(), fenix: true);
  Get.lazyPut(() => GetStoreProfileController(), fenix: true);
  Get.lazyPut(() => BusinessWebsiteCountUpdateController(), fenix: true);

  // =================== Donation Controllers ==================
  Get.lazyPut(() => DonationController(), fenix: true);
  Get.lazyPut(() => RoundUpController(), fenix: true);
  Get.lazyPut(() => GetRoundUpBankConnection(), fenix: true);
  Get.lazyPut(() => SaveRoundupController(), fenix: true);
  Get.lazyPut(() => CreateRecurringController(), fenix: true);
  Get.lazyPut(() => OneTimeController(), fenix: true);
  Get.lazyPut(() => RecurringStatesController(), fenix: true);
  Get.lazyPut(() => GetBadgesProgressController(), fenix: true);
  Get.lazyPut(() => GetBadgeHistoryController(), fenix: true);
  Get.lazyPut(() => GetRecurringOrgStateController(), fenix: true);
  Get.lazyPut(() => GetDonationFullStatusController(), fenix: true);
}
