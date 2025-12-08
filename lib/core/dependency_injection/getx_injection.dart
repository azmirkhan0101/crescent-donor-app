import 'package:cresent_charge_user_app/core/theme/theme_controller.dart';
import 'package:cresent_charge_user_app/features/common/controllers/roundup-management/save_roundup_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/donation_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/get_conected_bank_acounts_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/round_up_controller.dart';
import 'package:cresent_charge_user_app/features/home/controllers/charities_controller.dart';
import 'package:cresent_charge_user_app/features/home/controllers/search_controller.dart';
import 'package:cresent_charge_user_app/features/notification/controllers/notification_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/cancel_redemption_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/claim_reward_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_all_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_business_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_my_claimed_rewards_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_redemption_detail_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_reward_availability_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/get_reward_detail_controller.dart';
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
  Get.lazyPut(() => NotificationController(), fenix: true);

  // =================== Organization Controllers ==================
  // Get.lazyPut(() => OrganizationController(), fenix: true);

  // =================== Rewards Controllers ==================
  Get.lazyPut(() => YourRewardsController(), fenix: true);
  Get.lazyPut(() => GetAllRewardsController(), fenix: true);
  Get.lazyPut(() => GetBusinessRewardsController(), fenix: true);
  Get.lazyPut(() => ClaimRewardController(), fenix: true);
  Get.lazyPut(() => CancelRedemptionController(), fenix: true);
  Get.lazyPut(() => GetMyClaimedRewardsController(), fenix: true);
  Get.lazyPut(() => GetRedemptionDetailController(), fenix: true);
  Get.lazyPut(() => GetRewardAvailabilityController(), fenix: true);
  Get.lazyPut(() => GetRewardDetailController(), fenix: true);

  // =================== Donation Controllers ==================
  Get.lazyPut(() => DonationController(), fenix: true);
  Get.lazyPut(() => RoundUpController(), fenix: true);
  Get.lazyPut(() => GetConnectedBankAccounts(), fenix: true);
  Get.lazyPut(() => SaveRoundupController(), fenix: true);
}
