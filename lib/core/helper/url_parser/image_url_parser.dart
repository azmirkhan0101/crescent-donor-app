import 'package:cresent_charge_user_app/service/api_url.dart';

String parseImageUrl(String imagePath) {
  return '${ApiUrl.imageBaseUrl}$imagePath';
}
