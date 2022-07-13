import 'dart:convert';

class registerRequest {
  final String apiKey;
  final String email;
  final String password;
  final String firebaseId;

  final String firstName;
  final String lastName;
  final String nickName;
  final String preferred_pronoun;

  final int birthday;
  registerRequest(
      {this.apiKey,
      this.email,
      this.password,
      this.firebaseId,
      this.firstName,
      this.lastName,
      this.nickName,
      this.birthday,
      this.preferred_pronoun});

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'email': email,
      'password': password,
      'firebaseId': firebaseId,
      'firstName': firstName,
      'lastName': lastName,
      'nickName': nickName,
      'birthday': birthday,
      'preferred_pronoun': preferred_pronoun,
    };
  }
}
