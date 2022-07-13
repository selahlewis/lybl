import '../../Environment/Globals.dart';

class Endpoints {
  static Uri register = Uri.parse(GlobalVariables.dev_api + "/register");
  static Uri login(String username, String password) => Uri.parse(
      "${GlobalVariables.dev_api}/login?email=$username&password=$password");
  static Uri getQuestions =
      Uri.parse(GlobalVariables.dev_api + "/quiz/get_questions");
  static Uri createQuestionAnswers =
      Uri.parse(GlobalVariables.dev_api + "/quiz/create_questions_answer");
  static Uri updateUser =
      Uri.parse(GlobalVariables.dev_api + '/user/update_user');
  static Uri getProfile(int user) =>
      Uri.parse(GlobalVariables.dev_api + '/user/get_profile?id=$user');
  static Uri updateProfile =
      Uri.parse(GlobalVariables.dev_api + '/user/update_profile');
  static String uploadImage = GlobalVariables.dev_api + '/user/upload_image';
  static Uri getAllProfiles() =>
      Uri.parse(GlobalVariables.dev_api + '/user/get_all_profiles');
  static Uri getRomance() =>
      Uri.parse(GlobalVariables.dev_api + '/quiz/getromantic');
  static Uri getRomanceById(int gest_id) => Uri.parse(
      GlobalVariables.dev_api + '/quiz/getromanticbyid?gest_id=$gest_id');
  static Uri getMatchPrefsById(int prefsId) => Uri.parse(
      GlobalVariables.dev_api + '/quiz/getmatchprefsbyid?prefs_id=$prefsId');
  static Uri getDatingAttributes(int user) => Uri.parse(
      GlobalVariables.dev_api + '/quiz/getdatingattributes?user_id=$user');
  static Uri getFindMatch(int user) =>
      Uri.parse(GlobalVariables.dev_api + '/quiz/find_match?user_id=$user');
  static Uri getMatched(int userid, int otherid, int likedid) =>
      Uri.parse(GlobalVariables.dev_api +
          '/quiz/matched?user_id=$userid&other_id=$otherid&liked_id=$likedid');
  static Uri swipeYes = Uri.parse(GlobalVariables.dev_api + '/quiz/swipe_yes');
  static Uri createattributes(int user) => Uri.parse(
      GlobalVariables.dev_api + '/quiz/createattributes?user_id=$user');
  static Uri updateattributes(int user) => Uri.parse(
      GlobalVariables.dev_api + '/quiz/updateattributes?user_id=$user');
  static Uri getAllMatchPrefs() =>
      Uri.parse(GlobalVariables.dev_api + '/quiz/getmatchprefs');
  static Uri getRomanticAttList() =>
      Uri.parse(GlobalVariables.dev_api + '/quiz/getromanticstrings');
  static Uri editAttributes =
      Uri.parse(GlobalVariables.dev_api + '/quiz/editdatingattributes');
}
