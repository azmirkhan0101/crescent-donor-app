import 'package:cresent_charge_user_app/core/helper/api_response.dart';
import 'package:cresent_charge_user_app/service/api_service.dart';
import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:get/get.dart';

class DeleteAccountController extends GetxController{
  
  RxBool isDeleting = false.obs;
  final ApiService apiService = Get.find<ApiService>();
  
  Future<bool> deleteAccount() async{
    isDeleting.value = true;
     ApiResponse response = await apiService.networkRequest(
        method: "DELETE",
        isAuthRequired: true,
        endPoint: ApiUrl.deleteAccount
    );
     isDeleting.value = false;

    if( response.statusCode >= 200 && response.statusCode < 300 ){
      return true;
    }else{
      return false;
    }
  }
}