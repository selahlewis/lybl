import 'dart:convert';

SwipeYes swipeFromJson(String str) => SwipeYes.fromJson(json.decode(str));

String swipeToJson(SwipeYes data) => json.encode(data.toJson());

class SwipeYes {
  SwipeYes({
    this.swipeid = 0,
    this.otherFirebaseId = '',
    this.user_id = 0,
    this.other_id = 0,
    this.liked_id = 0,
  });
  int swipeid;
  String otherFirebaseId;
  int user_id;
  int other_id;
  int liked_id;

  factory SwipeYes.fromJson(Map<String, dynamic> json) => SwipeYes(
        swipeid: json["swipeid"] ?? 0,
        otherFirebaseId: json["firebase_id"],
        user_id: json["user_id"] ?? 0,
        other_id: json["other_id"] ?? 0,
        liked_id: json["liked_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "swipeid": swipeid,
        "otherFirebaseId": otherFirebaseId,
        "user_id": user_id,
        "other_id": other_id,
        "liked_id": liked_id,
      };
}
