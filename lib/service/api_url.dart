class ApiUrl {
  // static const baseUrl = "http://10.10.20.42:5000/api/v1"; // LOCAL
  static const baseUrl = "http://localhost:5000/api/v1"; // LOCAL
  static const imageBaseUrl = '$baseUrl/';
  static socketUrl({String userID = ""}) => '$baseUrl?id=$userID';

  /// ======= Auth =======
  static const login = '$baseUrl/auth/signin';
}
