class SignupRequestModel {
  final String email;
  final String password;

  SignupRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
