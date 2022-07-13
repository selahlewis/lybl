import 'dart:convert';

import 'package:intl/intl.dart';

userDatingAttributes datingFromJson(String str) =>
    userDatingAttributes.fromJson(json.decode(str));

String datingToJson(userDatingAttributes data) => json.encode(data.toJson());

class userDatingAttributes {
  int dating_attributes_id;
  int user_id;
  int age_range_min;
  int age_range_max;
  int location_range_max_miles;
  String address_line1;
  String address_line2;
  String address_city;
  String address_state;
  String match_preference1;
  String match_preference2;
  int intimacy_preference;
  String romantic_gesture1;
  String romantic_gesture2;
  String romantic_gesture3;
  String romantic_gesture4;
  String romantic_gesture5;
  double financial_stability_index;
  double intelligence_index;
  double humor_index;
  double confidence_index;
  String gender;
  String gender_looking;

  userDatingAttributes({
    this.dating_attributes_id = 0,
    this.user_id = 0,
    this.age_range_min = 0,
    this.age_range_max = 0,
    this.location_range_max_miles = 0,
    this.address_line1 = '',
    this.address_line2 = '',
    this.address_city = '',
    this.address_state = '',
    this.match_preference1 = '',
    this.match_preference2 = '',
    this.intimacy_preference = 0,
    this.romantic_gesture1 = '',
    this.romantic_gesture2 = '',
    this.romantic_gesture3 = '',
    this.romantic_gesture4 = '',
    this.romantic_gesture5 = '',
    this.financial_stability_index = 0.0,
    this.intelligence_index = 0.0,
    this.humor_index = 0.0,
    this.confidence_index = 0.0,
    this.gender = '',
    this.gender_looking = '',
  });

  factory userDatingAttributes.fromJson(Map<String, dynamic> json) =>
      userDatingAttributes(
          dating_attributes_id: json['dating_attributes_id'],
          user_id: json['user_id'],
          age_range_min: json['age_range_min'],
          age_range_max: json['age_range_max'],
          location_range_max_miles: json['location_range_max_miles'],
          address_line1: json['address_line1'],
          address_line2: json['address_line2'],
          address_city: json['address_city'],
          address_state: json['address_state'],
          match_preference1: json['match_preference1'],
          match_preference2: json['match_preference2'],
          intimacy_preference: json['intimacy_preference'],
          romantic_gesture1: json['romantic_gesture1'],
          romantic_gesture2: json['romantic_gesture2'],
          romantic_gesture3: json['romantic_gesture3'],
          romantic_gesture4: json['romantic_gesture4'],
          romantic_gesture5: json['romantic_gesture5'],
          financial_stability_index: json['financial_stability_index'],
          intelligence_index: json['intelligence_index'],
          humor_index: json['humor_index'],
          confidence_index: json['confidence_index'],
          gender: json['gender'],
          gender_looking: json['gender_looking']);

  Map<String, dynamic> toJson() => {
        'dating_attributes_id': dating_attributes_id,
        'user_id': user_id,
        'age_range_min': age_range_min,
        'age_range_max': age_range_max,
        'location_range_max_miles': location_range_max_miles,
        'address_line1': address_line1,
        'address_line2': address_line2,
        'address_city': address_city,
        'address_state': address_state,
        'match_preference1': match_preference1,
        'match_preference2': match_preference2,
        'intimacy_preference': intimacy_preference,
        'romantic_gesture1': romantic_gesture1,
        'romantic_gesture2': romantic_gesture2,
        'romantic_gesture3': romantic_gesture3,
        'romantic_gesture4': romantic_gesture4,
        'romantic_gesture5': romantic_gesture5,
        'financial_stability_index': financial_stability_index,
        'intelligence_index': intelligence_index,
        'humor_index': humor_index,
        'confidence_index': confidence_index,
        'gender': gender,
        'gender_looking': gender_looking
      };
}
