class GenericAuthRequest {
  final String apiKey;
  final String email;
  final String authToken;
  final String firebaseId;
  final int userId;

  GenericAuthRequest({
    this.apiKey,
    this.email,
    this.authToken,
    this.firebaseId,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'email': email,
      'authToken': authToken,
      'firebaseId': firebaseId,
      'userId': userId,
    };
  }
}
