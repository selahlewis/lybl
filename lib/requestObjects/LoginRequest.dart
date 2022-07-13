class LoginRequest {
  final String apiKey;
  final String email;
  final String password;
  final String firebaseId;

  LoginRequest({
    this.apiKey,
    this.email,
    this.password,
    this.firebaseId,
  });

  Map<String, dynamic> toJson() => {
        'apiKey': apiKey,
        'email': email,
        'password': password,
        'firebaseId': firebaseId,
      };
}
