import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class CreatePlaidLinkToken extends GetxController {
  /// ---------------------------------------------------------------
  /// Generate Link Token
  /// ---------------------------------------------------------------
  final RxString _linkToken = ''.obs;
  final RxBool _isLinkTokenLoading = false.obs;
  final RxString _linkTokenError = ''.obs;

  String get linkToken => _linkToken.value;
  bool get isLinkTokenLoading => _isLinkTokenLoading.value;
  String get linkTokenError => _linkTokenError.value;

  Future<bool> generateLinkToken() async {
    _isLinkTokenLoading.value = true;
    _linkTokenError.value = '';

    final result = await Get.find<NetworkHelper>().request(
      'POST',
      ApiUrl.generatePlaidLinkToken,
      parser: (data) => data?['data']?['link_token'] as String,
    );

    _isLinkTokenLoading.value = false;

    return result.fold(
      (failure) {
        _linkTokenError.value =
            failure.message ?? 'Failed to generate link token';
        return false;
      },
      (response) {
        _linkToken.value = response;
        return true;
      },
    );
  }
}
