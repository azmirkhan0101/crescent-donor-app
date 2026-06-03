import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:cresent_charge_user_app/service/api_url.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../core/helper/api_response.dart';
import 'app_storage_service.dart';

class ApiService extends GetxService {

  Future<ApiService> init() async {
    return this;
  }

  //API REQUEST
  Future<ApiResponse> networkRequest({
    required String method,
    required bool isAuthRequired,
    required String endPoint,
    Map<String, dynamic>? body,
    int timeout = 25,
    bool shouldPrint = false
  }) async {
    var result;
    var code;
    try {
      Uri uri = Uri.parse(ApiUrl.baseUrl + endPoint);
      late Map<String, String> headers;
      final token = await AppStorageService.getAuthToken();

      if (isAuthRequired) {
        headers = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        };
      } else {
        headers = {
          "Content-Type": "application/json",
          "Accept": "application/json",
        };
      }

      http.Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          {
            response = await http
                .get(uri, headers: headers)
                .timeout(Duration(seconds: timeout));
          }
          break;
        case 'POST':
          {
            response = await http
                .post(uri, body: jsonEncode(body), headers: headers)
                .timeout(Duration(seconds: timeout));
          }
          break;
        case 'PUT':
          {
            response = await http
                .put(uri, body: jsonEncode(body), headers: headers)
                .timeout(Duration(seconds: timeout));
          }
          break;
        case 'PATCH':
          {
            response = await http
                .patch(uri, body: jsonEncode(body), headers: headers)
                .timeout(Duration(seconds: timeout));
          }
          break;
        case 'DELETE':
          {
            response = await http
                .delete(uri, headers: headers)
                .timeout(Duration(seconds: timeout));
          }
          break;
        default:
          {
            return ApiResponse(statusCode: -9, data: {});
          }
      }
      result = response.body;
      code = response.statusCode;

      return ApiResponse(
        statusCode: response.statusCode,
        data: jsonDecode(response.body),
      );
    } on SocketException {
      return ApiResponse(statusCode: 503);
    } on TimeoutException {
      return ApiResponse(statusCode: 408);
    } catch (e) {
      if( shouldPrint ) print("🛑 Error: $e");
      return ApiResponse(statusCode: 500);
    }finally{
      if( shouldPrint ){
        print("🌐 Endpoint: $endPoint");
        print("🟢 Code: $code");
        //developer.log("✅ Result: $result");
        logPrettyJson(result.toString());
      }
    }
  }

  //MULTIPART REQUEST
  Future<ApiResponse> multipartRequest({
    required String method,
    required String endPoint,
    required bool isAuthRequired,
    required Map<String, dynamic> fields,
    File? coverImage,
    File? logoImage,
    File? rewardImage,
    File? csvFile,
    int timeout = 20,
    String fieldName = "data",
  }) async {
    var result;
    try {
      Uri uri = Uri.parse(ApiUrl.baseUrl + endPoint);
      final token = await AppStorageService.getAuthToken();
      var request = http.MultipartRequest( method, uri);

      request.fields[fieldName] = jsonEncode(fields);
      if( isAuthRequired ){
        Map<String, String> headers = {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        };
        request.headers.addAll(headers);
      }

      if( coverImage != null ) {
        final compressedCoverImage = await compressImage(coverImage);
        if (compressedCoverImage != null) {
          final mimeType =
              lookupMimeType(compressedCoverImage.path)?.split('/') ??
                  ['application', 'octet-stream'];

          request.files.add(
              await http.MultipartFile.fromPath(
                "coverImage",
                compressedCoverImage.path,
                contentType: http.MediaType(
                  mimeType[0],
                  mimeType[1],
                ),
              )
          );
        }
      }

        // Add optional logo image
        if( logoImage != null ){
          final compressedLogoImage = await compressImage( logoImage );
          if( compressedLogoImage != null ) {
            final mimeType =
                lookupMimeType(compressedLogoImage.path)?.split('/') ??
                    ['application', 'octet-stream'];

            request.files.add(
                await http.MultipartFile.fromPath(
                  "logoImage",
                  compressedLogoImage.path,
                  contentType: http.MediaType(
                    mimeType[0],
                    mimeType[1],
                  ),
                )
            );
          }
        }

      //REWARD IMAGE
      if( rewardImage != null ) {
        final compressedImage = await compressImage(rewardImage);
        if (compressedImage != null) {
          final mimeType =
              lookupMimeType(compressedImage.path)?.split('/') ??
                  ['application', 'octet-stream'];

          request.files.add(
              await http.MultipartFile.fromPath(
                "rewardImage",
                compressedImage.path,
                contentType: http.MediaType(
                  mimeType[0],
                  mimeType[1],
                ),
              )
          );
        }
      }

      if( csvFile != null ){
        request.files.add(
          await http.MultipartFile.fromPath(
            "codesFiles",
            csvFile.path,
            contentType: http.MediaType("text", "csv"),
          ),
        );

      }

      // Send request
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      result = responseBody;

      return ApiResponse(
        statusCode: response.statusCode,
        data: jsonDecode(responseBody),
      );
    } on SocketException {
      return ApiResponse(statusCode: 503);
    } on TimeoutException {
      return ApiResponse(statusCode: 408);
    } catch (e) {
      print("🛑 Error: $e");
      return ApiResponse(statusCode: 500);
    }finally{
      print("🌐 Endpoint: $endPoint");
      print("✅ Result: $result");

    }
  }

  //COMPRESS IMAGE
  //COMPRESS IMAGE
  Future<File?> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = p.join(
      dir.path,
      '${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 50,// 0 - 100
      format: CompressFormat.jpeg,
    );

    return result != null ? File(result.path) : null;
  }

  void logPrettyJson(String responseBody) {
    try {
      // 1. Parse the string into an object (Map or List)
      final dynamic decoded = json.decode(responseBody);

      // 2. Encode it back to a string with 2-space indentation
      final String prettyString = const JsonEncoder.withIndent('  ').convert(decoded);

      // 3. Log the result
      developer.log(prettyString, name: 'API_RESPONSE');
    } catch (e) {
      // If it's not valid JSON, just log the raw string
      developer.log("Invalid JSON: $responseBody", name: 'ERROR');
    }
  }
}
