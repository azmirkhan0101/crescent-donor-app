import 'package:cresent_charge_user_app/features/organization/models/payment_method_model.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:cresent_charge_user_app/service/network_helper.dart';
import 'package:get/get.dart';

class PaymentMethodController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchPaymentMethods();
  }

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final NetworkHelper _networkHelper = Get.find<NetworkHelper>();

  /// List of payment methods
  final RxList<PaymentMethodModel> paymentMethods = <PaymentMethodModel>[].obs;

  /// Fetch payment methods from API
  Future<void> fetchPaymentMethods() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _networkHelper.request(
        'GET',
        ApiUrl.getPaymentMethods,
        parser: (data) {
          return data["data"]
              .map<PaymentMethodModel>(
                (item) => PaymentMethodModel.fromJson(item),
              )
              .toList();
        },
      );

      result.fold(
        (failure) {
          errorMessage.value =
              failure.message ?? 'Failed to load payment methods';
        },
        (response) {
          paymentMethods.value = response;
        },
      );
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred';
    } finally {
      isLoading.value = false;
    }
  }
}
