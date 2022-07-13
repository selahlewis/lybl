import 'dart:collection';

class GenericResponseObjectQuizList {
  final List<dynamic> data;
  final int statusCode;
  final String errorMessage;

  GenericResponseObjectQuizList({
    this.data,
    this.statusCode,
    this.errorMessage,
  });

  factory GenericResponseObjectQuizList.fromJson(Map<String, dynamic> json) {
    return GenericResponseObjectQuizList(
      data: json['data'],
      statusCode: json['statusCode'],
      errorMessage: json['errorMessage'],
    );
  }
}
