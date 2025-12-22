import 'package:cresent_charge_user_app/features/profile/models/profile_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class GetProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  Rx<ProfileModel?> profile = Rx<ProfileModel?>(null);

  Future<bool> fetchProfile() async {
    errorMessage.value = '';
    isLoading.value = true;
    final result = await Get.find<NetworkHelper>().request(
      'GET',
      ApiUrl.getProfile,
      parser: (data) => ProfileModel.fromJson(data["data"] ?? {}),
      withAuth: true,
    );

    isLoading.value = false;

    return result.fold(
      (err) {
        errorMessage.value = err.message ?? 'Failed to load profile';
        return false;
      },
      (data) {
        profile.value = data;
        if (data.id.isEmpty) {
          errorMessage.value = 'Profile data is empty';
          return false;
        }
        return true;
      },
    );
  }
}
