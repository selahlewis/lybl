import 'package:json_annotation/json_annotation.dart';

part 'Token.g.dart';

@JsonSerializable()
class Token extends Object with _$TokenSerializerMixin {
  String token = "";
  String privatetoken = "";

  Token({token, privatetoken});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}
