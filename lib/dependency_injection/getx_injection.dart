import 'package:get/get.dart';
import 'package:cresent_charge_user_app/global/general_controller/general_controller.dart';

void initGetx() {
  // ================== Global Controller ==================
  Get.lazyPut(() => GeneralController(), fenix: true);
}
