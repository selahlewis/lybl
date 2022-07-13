import 'package:json_annotation/json_annotation.dart';

part 'User1.g.dart';

@JsonSerializable()
class User1 extends Object with _$User1SerializerMixin {
  String username;
  String firstname;
  String lastname;
  String lang;
  int userid;
  String userpictureurl;

  User1(
      {this.username,
      this.firstname,
      this.lastname,
      this.lang,
      this.userid,
      this.userpictureurl});

  factory User1.fromJson(Map<String, dynamic> json) => _$User1FromJson(json);
}
