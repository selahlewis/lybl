import 'dart:collection';

class GenericResponseObject {
  final Map<String, dynamic> data;
  final int statusCode;
  final String errorMessage;

  GenericResponseObject({
    this.data,
    this.statusCode,
    this.errorMessage,
  });

  factory GenericResponseObject.fromJson(Map<String, dynamic> json) {
    return GenericResponseObject(
      data: json['data'],
      statusCode: json['statusCode'],
      errorMessage: json['errorMessage'],
    );
  }
}
