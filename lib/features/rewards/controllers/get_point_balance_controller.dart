import 'package:cresent_charge_user_app/features/profile/controllers/get_profile_controller.dart';
import 'package:cresent_charge_user_app/features/rewards/models/point_balance_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class GetPointBalanceController extends GetxController {
  /// --------------- fetch points from api ---------------
  var isLoadingPoints = false.obs;
  var errorMessagePoints = ''.obs;
  var balance = Rx<PointBalanceModel?>(null);
  var userId = Get.find<GetProfileController>().profile.value?.id ?? '';

  Future<bool> fetchUserPoints() async {
    // print('Fetching points for userId: $userId');
    // return false;
    isLoadingPoints.value = true;
    errorMessagePoints.value = '';

    final response = await Get.find<NetworkHelper>().request(
      'GET',
      '${ApiUrl.baseUrl}/points/balance/$userId',
      withAuth: true,
    );

    isLoadingPoints.value = false;

    return response.fold(
      (err) {
        errorMessagePoints.value = err.message ?? 'Failed to fetch points';
        return false;
      },
      (data) {
        balance.value = PointBalanceModel.fromJson(data['data'] ?? {});
        return true;
      },
    );
  }
}
