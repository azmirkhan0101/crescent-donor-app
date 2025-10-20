import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';

import '../global/model/error_response_model.dart';
import 'app_storage_service.dart';

class NetworkHelper {
  final _logger = Logger();

  /// Generic request method
  Future<Either<ErrorResponseModel, T>> request<T>(
    String method,
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool withAuth = true,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final token = await AppStorageService.getAuthToken();
      final uri = Uri.parse(url);

      final finalHeaders = {
        "Content-Type": "application/json",
        if (withAuth && token != null) "Authorization": "Bearer $token",
        ...?headers,
      };

      _logger.i("[$method] $url\nHeaders: $finalHeaders\nBody: $body");

      late http.Response response;

      switch (method.toUpperCase()) {
        case "GET":
          response = await http.get(uri, headers: finalHeaders);
          break;
        case "POST":
          response = await http.post(
            uri,
            headers: finalHeaders,
            body: jsonEncode(body),
          );
          break;
        case "PUT":
          response = await http.put(
            uri,
            headers: finalHeaders,
            body: jsonEncode(body),
          );
          break;
        case "PATCH":
          response = await http.patch(
            uri,
            headers: finalHeaders,
            body: jsonEncode(body),
          );
          break;
        case "DELETE":
          response = await http.delete(uri, headers: finalHeaders);
          break;
        default:
          return Left(ErrorResponseModel(message: "Invalid HTTP method"));
      }

      _logger.i("Status: ${response.statusCode}\nResponse: ${response.body}");

      final data = response.body.isNotEmpty ? jsonDecode(response.body) : {};

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(parser != null ? parser(data) : data as T);
      } else {
        return Left(
          ErrorResponseModel(
            status: "Failed",
            message: data['message'] ?? 'Something went wrong',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e, st) {
      _logger.e("Request failed: $e", stackTrace: st);
      return Left(
        ErrorResponseModel(
          status: "Failed",
          message: e.toString(),
          statusCode: -1,
        ),
      );
    }
  }

  /// Convenience methods
  Future<Either<ErrorResponseModel, T>> get<T>(
    String url, {
    Map<String, String>? headers,
    bool withAuth = true,
    T Function(dynamic data)? parser,
  }) =>
      request("GET", url, headers: headers, withAuth: withAuth, parser: parser);

  Future<Either<ErrorResponseModel, T>> post<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool withAuth = true,
    T Function(dynamic data)? parser,
  }) => request(
    "POST",
    url,
    body: body,
    headers: headers,
    withAuth: withAuth,
    parser: parser,
  );

  /// Multipart request for file uploads
  Future<Either<ErrorResponseModel, T>> multipart<T>({
    required String url,
    required String method,
    Map<String, String>? fields,
    required List<MultipartBody> files,
    bool withAuth = true,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final token = await AppStorageService.getAuthToken();
      final request = http.MultipartRequest(
        method.toUpperCase(),
        Uri.parse(url),
      );

      if (fields != null) request.fields.addAll(fields);

      if (withAuth && token != null) {
        request.headers["Authorization"] = "Bearer $token";
      }

      for (var file in files) {
        final mimeType =
            lookupMimeType(file.file.path)?.split('/') ??
            ['application', 'octet-stream'];
        request.files.add(
          await http.MultipartFile.fromPath(
            file.key,
            file.file.path,
            contentType: MediaType(mimeType[0], mimeType[1]),
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      _logger.i(
        "Multipart Status: ${response.statusCode}\nResponse: ${response.body}",
      );

      final data = response.body.isNotEmpty ? jsonDecode(response.body) : {};

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(parser != null ? parser(data) : data as T);
      } else {
        return Left(
          ErrorResponseModel(
            status: "Failed",
            message: data['message'] ?? 'Something went wrong',
            statusCode: response.statusCode,
          ),
        );
      }
    } catch (e, st) {
      _logger.e("Multipart request failed: $e", stackTrace: st);
      return Left(
        ErrorResponseModel(
          status: "Failed",
          message: e.toString(),
          statusCode: -1,
        ),
      );
    }
  }
}

class MultipartBody {
  final String key;
  final File file;
  MultipartBody(this.key, this.file);
}
