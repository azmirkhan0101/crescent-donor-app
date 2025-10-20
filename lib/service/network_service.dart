import 'package:cresent_charge_user_app/service/network_caller.dart';
import 'package:get/get.dart';

class NetworkService extends GetxService {
  late final NetworkHelper networkHelper;

  // This runs when the service is initialized
  Future<NetworkService> init() async {
    networkHelper = NetworkHelper();
    return this;
  }
}
