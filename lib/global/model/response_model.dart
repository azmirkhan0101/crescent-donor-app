enum NetworkErrorType { noInternet, timeout, unauthorized, server, unknown }

class NetworkError {
  final NetworkErrorType type;
  final String? message;

  NetworkError(this.type, {this.message});
}

class ResponseModel<T> {
  final T? data;
  final bool isSuccess;
  final NetworkError? error;

  ResponseModel._({this.data, required this.isSuccess, this.error});

  factory ResponseModel.success(T data) =>
      ResponseModel._(data: data, isSuccess: true);

  factory ResponseModel.failure(NetworkError error) =>
      ResponseModel._(isSuccess: false, error: error);
}
