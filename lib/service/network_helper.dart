import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cresent_charge_user_app/global/model/error_response_model.dart';
import 'package:cresent_charge_user_app/service/app_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';

/// Network service for handling HTTP requests with error handling and timeout support
class NetworkHelper extends GetxService {
  static final _logger = Logger();

  /// Default timeout duration for HTTP requests
  static const Duration defaultTimeout = Duration(seconds: 30);

  /// Generic request method with timeout and better error handling
  Future<Either<ErrorResponseModel, T>> request<T>(
    String method,
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool withAuth = true,
    T Function(dynamic data)? parser,
    Duration? timeout,
  }) async {
    try {
      final token = await AppStorageService.getAuthToken();

      final uri = Uri.parse(url);

      final finalHeaders = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        // if (withAuth && token != null) "Cookie": "token=$token",
        // ...?headers,
      };

      // Log request without sensitive data in production
      _logger.d(
        "[$method] $url\nHeaders: $finalHeaders\n"
        "Body: ${body != null ? (kDebugMode ? jsonEncode(body) : '***') : 'null'}",
      );
      // _logger.d("Body: ${body != null ? jsonEncode(body) : 'null'}");

      late http.Response response;
      final requestTimeout = timeout ?? defaultTimeout;

      switch (method.toUpperCase()) {
        case "GET":
          response = await http
              .get(uri, headers: finalHeaders)
              .timeout(requestTimeout);
          break;
        case "POST":
          response = await http
              .post(
                uri,
                headers: finalHeaders,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(requestTimeout);
          break;
        case "PUT":
          response = await http
              .put(
                uri,
                headers: finalHeaders,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(requestTimeout);
          break;
        case "PATCH":
          response = await http
              .patch(
                uri,
                headers: finalHeaders,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(requestTimeout);
          break;
        case "DELETE":
          response = await http
              .delete(uri, headers: finalHeaders)
              .timeout(requestTimeout);
          break;
        default:
          return Left(ErrorResponseModel(message: "Invalid HTTP method"));
      }

      return _handleResponse<T>(method, url, response, parser);
    } on TimeoutException catch (e, st) {
      _logger.d(
        "[$method] $url\n Body: ${body != null ? (kDebugMode ? jsonEncode(body) : '***') : 'null'}\n Request timeout: $e, stackTrace: $st",
      );
      // _logger.e("Request timeout: $e", stackTrace: st);
      return Left(
        ErrorResponseModel(
          status: "Timeout",
          message: "Request timed out. Please check your connection.",
          statusCode: 408,
        ),
      );
    } on SocketException catch (e, st) {
      _logger.e("[$method] $url\n Network error: $e", stackTrace: st);
      return Left(
        ErrorResponseModel(
          status: "Network Error",
          message: "No internet connection. Please try again.",
          statusCode: -1,
        ),
      );
    } on FormatException catch (e, st) {
      _logger.e("[$method] $url\n Invalid URL format: $e", stackTrace: st);
      return Left(
        ErrorResponseModel(
          status: "Invalid URL",
          message: "Invalid URL format.",
          statusCode: -1,
        ),
      );
    } catch (e, st) {
      _logger.e("[$method] $url\n Request failed: $e", stackTrace: st);
      return Left(
        ErrorResponseModel(
          status: "Failed",
          message: _getErrorMessage(e),
          statusCode: -1,
        ),
      );
    }
  }

  /// Handle HTTP response and parse data
  Either<ErrorResponseModel, T> _handleResponse<T>(
    String method,
    String url,
    http.Response response,
    T Function(dynamic data)? parser,
  ) {
    _logger.d("Status: ${response.statusCode}");
    _logger.d(
      "[$method] $url\n Response: ${response.body.length > 500 ? '${response.body.substring(0, 500)}...' : response.body}",
    );

    dynamic data;
    try {
      data = response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } catch (e) {
      _logger.e("Failed to parse JSON response: $e");
      data = null;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return Right(parser != null ? parser(data) : data as T);
      } catch (e, st) {
        _logger.e("Failed to parse success response: $e", stackTrace: st);
        return Left(
          ErrorResponseModel(
            status: "Parse Error",
            message: "Failed to parse server response.",
            statusCode: response.statusCode,
          ),
        );
      }
    } else {
      String errorMessage = 'Something went wrong';

      if (data is Map<String, dynamic>) {
        errorMessage =
            data['message'] ?? data['error'] ?? data['detail'] ?? errorMessage;
      } else if (data is String) {
        errorMessage = data;
      }

      return Left(
        ErrorResponseModel(
          status: "Failed",
          message: errorMessage,
          statusCode: response.statusCode,
        ),
      );
    }
  }

  /// Extract user-friendly error message from exceptions
  String _getErrorMessage(dynamic error) {
    if (error is SocketException) {
      return "No internet connection";
    } else if (error is TimeoutException) {
      return "Request timed out";
    } else if (error is FormatException) {
      return "Invalid data format";
    } else if (error is http.ClientException) {
      return "Network request failed";
    }
    return error.toString();
  }

  /// Convenience methods for common HTTP operations

  /// Perform a GET request
  Future<Either<ErrorResponseModel, T>> get<T>(
    String url, {
    Map<String, String>? headers,
    bool withAuth = true,
    T Function(dynamic data)? parser,
    Duration? timeout,
  }) => request(
    "GET",
    url,
    headers: headers,
    withAuth: withAuth,
    parser: parser,
    timeout: timeout,
  );

  /// Perform a POST request
  Future<Either<ErrorResponseModel, T>> post<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool withAuth = true,
    T Function(dynamic data)? parser,
    Duration? timeout,
  }) => request(
    "POST",
    url,
    body: body,
    headers: headers,
    withAuth: withAuth,
    parser: parser,
    timeout: timeout,
  );

  /// Perform a PUT request
  Future<Either<ErrorResponseModel, T>> put<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool withAuth = true,
    T Function(dynamic data)? parser,
    Duration? timeout,
  }) => request(
    "PUT",
    url,
    body: body,
    headers: headers,
    withAuth: withAuth,
    parser: parser,
    timeout: timeout,
  );

  /// Perform a PATCH request
  Future<Either<ErrorResponseModel, T>> patch<T>(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool withAuth = true,
    T Function(dynamic data)? parser,
    Duration? timeout,
  }) => request(
    "PATCH",
    url,
    body: body,
    headers: headers,
    withAuth: withAuth,
    parser: parser,
    timeout: timeout,
  );

  /// Perform a DELETE request
  Future<Either<ErrorResponseModel, T>> delete<T>(
    String url, {
    Map<String, String>? headers,
    bool withAuth = true,
    T Function(dynamic data)? parser,
    Duration? timeout,
  }) => request(
    "DELETE",
    url,
    headers: headers,
    withAuth: withAuth,
    parser: parser,
    timeout: timeout,
  );

  /// Multipart request for file uploads with timeout support
  Future<Either<ErrorResponseModel, T>> multipart<T>({
    required String url,
    required String method,
    Map<String, String>? fields,
    required List<MultipartBody> files,
    String? myToken,
    bool withAuth = true,
    T Function(dynamic data)? parser,
    Duration? timeout,
  }) async {
    try {
      final token = await AppStorageService.getAuthToken();
      final request = http.MultipartRequest(
        method.toUpperCase(),
        Uri.parse(url),
      );

      if (fields != null) request.fields.addAll(fields);

      if (withAuth && (myToken ?? token) != null) {
        request.headers['Authorization'] = 'Bearer ${myToken ?? token}';
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

      _logger.d("Multipart [$method] $url with ${files.length} file(s)");
      _logger.d("Fields: ${fields ?? {}}");

      final requestTimeout = timeout ?? defaultTimeout;
      final streamedResponse = await request.send().timeout(requestTimeout);
      final response = await http.Response.fromStream(streamedResponse);

      return _handleResponse<T>(method, url, response, parser);
    } on TimeoutException catch (e, st) {
      _logger.e("Multipart request timeout: $e", stackTrace: st);
      return Left(
        ErrorResponseModel(
          status: "Timeout",
          message: "Upload timed out. Please try again.",
          statusCode: 408,
        ),
      );
    } on SocketException catch (e, st) {
      _logger.e("Multipart network error: $e", stackTrace: st);
      return Left(
        ErrorResponseModel(
          status: "Network Error",
          message: "No internet connection. Please try again.",
          statusCode: -1,
        ),
      );
    } catch (e, st) {
      _logger.e("Multipart request failed: $e", stackTrace: st);
      return Left(
        ErrorResponseModel(
          status: "Failed",
          message: _getErrorMessage(e),
          statusCode: -1,
        ),
      );
    }
  }
}

/// Represents a file to be uploaded in a multipart request
class MultipartBody {
  /// The field name for the file in the multipart request
  final String key;

  /// The file to upload
  final File file;

  /// Optional filename override
  final String? filename;

  const MultipartBody({required this.key, required this.file, this.filename});
}
