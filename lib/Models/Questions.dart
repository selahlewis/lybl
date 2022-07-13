import 'dart:convert';

Question questionsFromJson(String str) => Question.fromJson(json.decode(str));

String questionsToJson(Question data) => json.encode(data.toJson());

class Question {
  Question({
    this.id = 0,
    this.question = "",
    this.response = const [],
    this.type = "",
  });

  int id;
  String question;
  List<String> response;
  String type;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    question: json["question"],
    response: List<String>.from(json["response"].map((x) => x)),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "response": List<dynamic>.from(response.map((x) => x)),
    "type": type,
  };
}
