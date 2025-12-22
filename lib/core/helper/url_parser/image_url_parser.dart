import 'package:cresent_charge_user_app/service/api_url.dart';

String parseImageUrl(String imagePath) {
  // Return as-is if it's already a complete URL
  if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
    return imagePath;
  }

  // Remove leading slash to prevent double slashes
  final cleanPath = imagePath.startsWith('/')
      ? imagePath.substring(1)
      : imagePath;

  return '${ApiUrl.imageBaseUrl}/$cleanPath';
}
