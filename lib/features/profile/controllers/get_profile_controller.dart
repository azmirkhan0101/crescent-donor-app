import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class GetProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxMap<String, dynamic> profile = <String, dynamic>{}.obs;

  Future<bool> fetchProfile() async {
    try {
      errorMessage.value = '';
      isLoading.value = true;
      final network = Get.find<NetworkHelper>();
      final result = await network.request<dynamic>(
        'GET',
        ApiUrl.getProfile,
        parser: (d) => d,
        withAuth: true,
      );
      return result.fold(
        (l) {
          errorMessage.value = l.message ?? 'Failed to load profile';
          return false;
        },
        (r) {
          if (r is Map<String, dynamic>) {
            profile.assignAll(r);
          }
          return true;
        },
      );
    } catch (e) {
      errorMessage.value = 'Profile error';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
