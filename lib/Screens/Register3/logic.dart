import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lybl_mobile/Lybl/models/base/EventObject.dart';
import 'package:lybl_mobile/Lybl/utils/app_shared_preferences.dart';
import 'package:lybl_mobile/Lybl/utils/constants.dart';
import 'package:lybl_mobile/Screens/Login/logic.dart';
import 'package:lybl_mobile/Screens/Login/logic.dart';
import 'package:lybl_mobile/Screens/Login/logic.dart';
import 'package:lybl_mobile/Services/QuestionService.dart';
import 'package:lybl_mobile/data/entity/app_user.dart';
import 'package:lybl_mobile/data/provider/user_provider.dart';
import 'package:lybl_mobile/data/remote/firebase_auth_source.dart';
import 'package:lybl_mobile/data/remote/firebase_database_source.dart';
import 'package:lybl_mobile/data/remote/firebase_storage_source.dart';
import 'package:lybl_mobile/data/remote/response1.dart';
import 'package:lybl_mobile/util/shared_preferences_utils.dart';
import 'package:lybl_mobile/util/utils.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helpers/MagicStrings.dart';
import '../../Services/HttpServices/Endpoints.dart';
import '../../Models/User2.dart';
import 'package:lybl_mobile/Lybl/helpers/app_futures.dart';

class RegisterLogic extends ChangeNotifier {
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();
  FirebaseAuthSource _authSource = FirebaseAuthSource();
  FirebaseStorageSource _storageSource = FirebaseStorageSource();
  FirebaseDatabaseSource _databaseSource = FirebaseDatabaseSource();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String userToken = "";
  UserProvider _userProvider = new UserProvider();
  selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2032),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      notifyListeners();
    }
  }

  registerApiCall(User2 user, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    user.authTokenExpirationDate = DateTime.now();
    Response1<dynamic> firebaseResponse =
        await _authSource.register(user.email, user.password);
    if (firebaseResponse is Success<UserCredential>) {
      String id = (firebaseResponse as Success<UserCredential>).value.user.uid;
      user.firebaseId = id;
      firebaseResponse = await _storageSource.uploadUserProfilePhoto(
          user.profile_image_main, id);

      if (firebaseResponse is Success<String>) {
        String profilePhotoUrl = firebaseResponse.value;
        AppUser user1 = AppUser(
            id: id,
            name: user.firstName,
            age: 20,
            profilePhotoPath: profilePhotoUrl);
        user.profile_image_main = profilePhotoUrl;

        _databaseSource.addUser(user1);
        SharedPreferencesUtil.setUserId(id);
        SharedPreferencesUtil.setUserPhotoUrl(profilePhotoUrl);

        Response response =
            await post(Endpoints.register, body: userToJson(user));
        switch (response.statusCode) {
          case 200:
            login(user.email, user.password, context);
          //Navigator.pushNamed(context, RouteNames.LOGIN);
        }

        return Response1.success(user1);
      }
    }

    isLoading = false;
    notifyListeners();
  }

  login(String username, String password, BuildContext context) async {
    isLoading = true;

    Response response = await get(Endpoints.login(username, password));
    Response1 response1 = await _userProvider
        .loginUser(username, password, _scaffoldKey)
        .then((response1) {
      if (response1 is Success<UserCredential>) {
        String id = response1.value.user.uid;
        SharedPreferencesUtil.setUserId(id);
        print(response1.value);
      }
      return response1;
    });

    switch (response.statusCode) {
      case 200:
        User2 user = userFromJson(response.body);
        SharedPreferences pref = context.read<SharedPreferences>();
        pref.setString(SharedPrefNames.USER, response.body);
        pref.setString(SharedPrefNames.TOKEN, user.authToken);
        print(user.id);

        if (user.status == "new") {
          await get(Endpoints.createattributes(user.id));
          QuestionsService logic = context.read<QuestionsService>();
          logic.setQuestion(context);
          //Navigator.pushReplacementNamed(context, RouteNames.QUESTIONS);
        } else {
          // username = username.replaceAll('@', 'x');

          _getUserToken(username, password);
          Navigator.pushReplacementNamed(context, RouteNames.HOME);
        }
        //pref.setString(SharedPrefNames.USER, userToJson(user));
        // Navigator.pushReplacementNamed(context, RouteNames.DASHBOARD);
        break;
      case 500:
        _showMyDialog("There has been a server error", context);
        break;
      case 404:
        _showMyDialog("User name or password do not match", context);
        break;
    }

    isLoading = false;
  }

  void _getUserToken(String username, String password) async {
    EventObject eventObject = await getTokenByLogin(username, password);
    print(eventObject.id);
    switch (eventObject.id) {
      case EventConstants.LOGIN_USER_SUCCESSFUL:
        {
          userToken = eventObject.object;
          print(userToken);
          AppSharedPreferences.setPrefs(
              SharedPreferenceKeys.USER_TOKEN, userToken);

          _userDetailsAction();
        }
        break;
      case EventConstants.LOGIN_USER_UN_SUCCESSFUL:
        {}
        break;
      case EventConstants.NO_INTERNET_CONNECTION:
        {}
        break;
    }
  }

  void _userDetailsAction() {
    _getUserDetails();
  }

  void _getUserDetails() async {
    EventObject eventObject = await fetchUserDetail(userToken);
    switch (eventObject.id) {
      case EventConstants.LOGIN_USER_SUCCESSFUL:
        {
          AppSharedPreferences.setUserLoggedIn(true);
          AppSharedPreferences.setUserProfile(eventObject.object);
        }
        break;
      case EventConstants.LOGIN_USER_UN_SUCCESSFUL:
        {}
        break;
      case EventConstants.NO_INTERNET_CONNECTION:
        {}
        break;
    }
  }

  Future<void> _showMyDialog(String error, BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorCodes.mainColorLight,
            title: Text(
              error,
              style: TextStyle(
                  fontFamily: "Avenir", color: ColorCodes.white, fontSize: 18),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Ok',
                  style: TextStyle(
                      fontFamily: "Avenir",
                      color: ColorCodes.white,
                      fontSize: 15),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
