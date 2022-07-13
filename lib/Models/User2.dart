// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

User2 userFromJson(String str) => User2.fromJson(json.decode(str));

String userToJson(User2 data) => json.encode(data.toJson());

class User2 {
  int id;
  int moodle_id;
  String firstName;
  String lastName;
  String nickName;
  String firebaseId;
  String email;
  String password;
  bool emailVerified;
  bool ingestComplete;
  bool notificationsEnabled;
  DateTime birthday;
  String perferredPronoun;
  String authToken;
  DateTime authTokenExpirationDate;
  String status;
  String profile_image_main;

  User2(
      {this.id = 0,
      this.moodle_id = 0,
      this.firstName = '',
      this.lastName = '',
      this.nickName = '',
      this.firebaseId = '',
      this.email = '',
      this.password = '',
      this.emailVerified = false,
      this.ingestComplete = false,
      this.birthday,
      this.perferredPronoun = '',
      this.notificationsEnabled = false,
      this.authToken =
          '1kmoDU56gAI9wTyNGJrgadGBeW85yNEe3F1zbVeLjhW6reM8m1eSamP4JBeV',
      this.authTokenExpirationDate,
      this.status = 'new',
      this.profile_image_main = ''});

  factory User2.fromJson(Map<String, dynamic> json) => User2(
      id: json["id"],
      moodle_id: json['moodle_id'],
      firstName: json["firstName"],
      lastName: json["lastName"],
      nickName: json["nickName"],
      firebaseId: json["firebaseId"],
      email: json["email"],
      password: json["password"] == null ? "" : json["password"],
      emailVerified: json["emailVerified"],
      ingestComplete: json["ingestComplete"],
      birthday: DateTime.parse(json["birthday"]),
      perferredPronoun: json["perferred_pronoun"],
      notificationsEnabled: json["notificationsEnabled"],
      authToken: json["authToken"],
      authTokenExpirationDate: DateTime.parse(json["authTokenExpirationDate"]),
      status: json["status"],
      profile_image_main: json["profile_image_main"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "moodle_id": moodle_id,
        "firstName": firstName,
        "lastName": lastName,
        "nickName": nickName,
        "firebaseId": firebaseId,
        "email": email,
        "password": password,
        "emailVerified": emailVerified,
        "ingestComplete": ingestComplete,
        "birthday": DateFormat('yyyy-MM-dd').format(birthday),
        "perferred_pronoun": perferredPronoun,
        "notificationsEnabled": notificationsEnabled,
        "authToken": authToken,
        "authTokenExpirationDate":
            DateFormat('yyyy-MM-dd').format(authTokenExpirationDate),
        "status": status,
        "profile_image_main": profile_image_main,
      };
}
