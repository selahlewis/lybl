import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static const String keyUserId = 'KEY_USER_ID';
  static const String photoUrl = 'PHOTO_URL';

  static Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUserId) ?? null;
  }

  static Future<void> setUserId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyUserId, id);
  }

  static Future<void> removeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyUserId);
  }

  static Future<void> setUserPhotoUrl(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(photoUrl, url);
  }

  static Future<String> getPhotoUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(photoUrl) ?? null;
  }
}
