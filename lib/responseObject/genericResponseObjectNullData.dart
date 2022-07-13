import 'dart:collection';

class GenericResponseObjectNullData {
  final Map<String, dynamic> data;
  final int statusCode;
  final String errorMessage;

  GenericResponseObjectNullData({
    this.data,
    this.statusCode,
    this.errorMessage,
  });

  factory GenericResponseObjectNullData.fromJson(Map<String, dynamic> json) {
    return GenericResponseObjectNullData(
      data: json['data'],
      statusCode: json['statusCode'],
      errorMessage: json['errorMessage'],
    );
  }
}
