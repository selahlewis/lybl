// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.bioText = '',
    this.educationLevel = '',
    this.id = 0,
    this.job = '',
    this.profileImage1 = '',
    this.profileImage2 = '',
    this.profileImage3 = '',
    this.profileImage4 = '',
    this.profileImageMain = '',
    this.user = 0,
  });

  String bioText;
  String educationLevel = "";
  int id;
  String job;
  String profileImage1;
  String profileImage2;
  String profileImage3;
  String profileImage4;
  String profileImageMain;
  int user;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    bioText: json["bio_text"] ?? '',
    educationLevel: json["education_level"] ?? '',
    id: json["id"] ?? 0,
    job: json["job"] ?? '',
    profileImage1: json["profile_image1"] ?? '',
    profileImage2: json["profile_image2"] ?? '',
    profileImage3: json["profile_image3"] ?? '',
    profileImage4: json["profile_image4"] ?? '',
    profileImageMain: json["profile_image_main"] ?? '',
    user: json["user"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "bio_text": bioText,
    "education_level": educationLevel,
    "id": id,
    "job": job,
    "profile_image1": profileImage1,
    "profile_image2": profileImage2,
    "profile_image3": profileImage3,
    "profile_image4": profileImage4,
    "profile_image_main": profileImageMain,
    "user": user,
  };
}
