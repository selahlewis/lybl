import 'dart:convert';

Romantic questionsFromJson(String str) => Romantic.fromJson(json.decode(str));

String questionsToJson(Romantic data) => json.encode(data.toJson());

class Romantic {
  Romantic({
    this.romantic_gesture_id = 0,
    this.romantic_gesture_string = "",
  });

  int romantic_gesture_id;
  String romantic_gesture_string;

  factory Romantic.fromJson(Map<String, dynamic> json) => Romantic(
        romantic_gesture_id: json["romantic_gesture_id"],
        romantic_gesture_string: json["romantic_gesture_string"],
      );

  Map<String, dynamic> toJson() => {
        "romantic_gesture_id": romantic_gesture_id,
        "romantic_gesture_string": romantic_gesture_string,
      };
}
