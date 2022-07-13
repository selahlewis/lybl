import 'dart:convert';

class QuizObject {
  final int questionId;
  final String questionType;
  final String questionResponseJson;
  final String questionText;

  QuizObject({
    this.questionId,
    this.questionType,
    this.questionResponseJson,
    this.questionText,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionType': questionType,
      'questionResponseJson': questionResponseJson,
      'questionText': questionText,
    };
  }

  factory QuizObject.fromJson(Map<String, dynamic> map) {
    return QuizObject(
      questionId: map['questionId'],
      questionType: map['questionType'],
      questionResponseJson: map['questionResponseJson'],
      questionText: map['questionText'],
    );
  }

  @override
  String toString() {
    return 'QuizObject(questionId: $questionId, questionType: $questionType, questionResponseJson: $questionResponseJson, questionText: $questionText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuizObject &&
        other.questionId == questionId &&
        other.questionType == questionType &&
        other.questionResponseJson == questionResponseJson &&
        other.questionText == questionText;
  }

  @override
  int get hashCode {
    return questionId.hashCode ^
        questionType.hashCode ^
        questionResponseJson.hashCode ^
        questionText.hashCode;
  }
}
