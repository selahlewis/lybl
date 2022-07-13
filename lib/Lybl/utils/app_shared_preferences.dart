import 'dart:async';
import 'dart:convert';

import 'package:lybl_mobile/Lybl/models/User1.dart';
import 'package:lybl_mobile/Lybl/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static Future<SharedPreferences> getInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedPreferenceKeys.IS_USER_LOGGED_IN);
  }

  static setUserLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(SharedPreferenceKeys.IS_USER_LOGGED_IN, isLoggedIn);
  }

  static getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return User1.fromJson(
        json.decode(prefs.getString(SharedPreferenceKeys.APP_USER)));
  }

  static setUserProfile(User1 user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userProfile = json.encode(user);
    return prefs.setString(SharedPreferenceKeys.APP_USER, userProfile);
  }

  static setPrefs(String prefKey, String prefValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(prefKey, prefValue);
  }

  static getPrefs(String prefKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(prefKey);
  }
}
