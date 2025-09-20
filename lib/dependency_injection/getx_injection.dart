import 'package:cresent_charge_user_app/features/home/controllers/charities_controller.dart';
import 'package:cresent_charge_user_app/features/home/controllers/search_controller.dart';
import 'package:cresent_charge_user_app/features/notification/controllers/notification_controller.dart';
import 'package:cresent_charge_user_app/global/general_controller/general_controller.dart';
import 'package:get/get.dart';

void initGetx() {
  // ================== Global Controller ==================
  Get.lazyPut(() => GeneralController(), fenix: true);

  // ================== Home Controllers ==================
  Get.lazyPut(() => SearchController(), fenix: true);
  Get.lazyPut(() => CharitiesController(), fenix: true);
  Get.lazyPut(() => NotificationController(), fenix: true);
}
