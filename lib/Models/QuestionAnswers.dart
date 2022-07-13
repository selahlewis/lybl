// To parse this JSON data, do
//
//     final questionsAnswer = questionsAnswerFromJson(jsonString);

import 'dart:convert';

QuestionsAnswer questionsAnswerFromJson(String str) =>
    QuestionsAnswer.fromJson(json.decode(str));

String questionsAnswerToJson(QuestionsAnswer data) =>
    json.encode(data.toJson());

class QuestionsAnswer {
  QuestionsAnswer({
    this.id = 0,
    this.questionId,
    this.userId,
    this.answerString,
  });

  int id;
  int questionId;
  int userId;
  String answerString;

  factory QuestionsAnswer.fromJson(Map<String, dynamic> json) =>
      QuestionsAnswer(
        id: json["id"],
        questionId: json["question_id"],
        userId: json["user_id"],
        answerString: json["answer_string"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_id": questionId,
        "user_id": userId,
        "answer_string": answerString,
      };
}
