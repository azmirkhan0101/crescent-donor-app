import 'package:cresent_charge_user_app/core/theme/theme_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/donation_controller.dart';
import 'package:cresent_charge_user_app/features/donation/controllers/round_up_controller.dart';
import 'package:cresent_charge_user_app/features/home/controllers/charities_controller.dart';
import 'package:cresent_charge_user_app/features/home/controllers/search_controller.dart';
import 'package:cresent_charge_user_app/features/notification/controllers/notification_controller.dart';
import 'package:cresent_charge_user_app/features/organization/controllers/organization_details_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/controllers/your_rewards_controller.dart';
import 'package:cresent_charge_user_app/global/general_controller/general_controller.dart';
import 'package:get/get.dart';

void initGetx() {
  // ================== Core Controllers ==================
  Get.lazyPut(() => ThemeController(), fenix: true);

  // ================== Global Controller ==================
  Get.lazyPut(() => GeneralController(), fenix: true);

  // ================== Home Controllers ==================
  Get.lazyPut(() => SearchController(), fenix: true);
  Get.lazyPut(() => CharitiesController(), fenix: true);
  Get.lazyPut(() => NotificationController(), fenix: true);

  // =================== Organization Controllers ==================
  Get.lazyPut(() => OrganizationDetailsController(), fenix: true);

  // =================== Rewards Controllers ==================
  Get.lazyPut(() => YourRewardsController(), fenix: true);

  // =================== Donation Controllers ==================
  Get.lazyPut(() => DonationController(), fenix: true);
  Get.lazyPut(() => RoundUpController(), fenix: true);
}
