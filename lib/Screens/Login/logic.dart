import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/Lybl/helpers/app_futures.dart';

import 'package:lybl_mobile/Lybl/models/base/EventObject.dart';
import 'package:lybl_mobile/Lybl/utils/app_shared_preferences.dart';
import 'package:lybl_mobile/Lybl/utils/constants.dart';
import 'package:lybl_mobile/Models/User2.dart';
import 'package:lybl_mobile/Services/QuestionService.dart';
import 'package:lybl_mobile/Services/HttpServices/Endpoints.dart';
import 'package:lybl_mobile/data/provider/user_provider.dart';
import 'package:lybl_mobile/data/remote/firebase_auth_source.dart';
import 'package:lybl_mobile/data/remote/response1.dart';
import 'package:lybl_mobile/util/shared_preferences_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLogic extends ChangeNotifier {
  FirebaseAuthSource _authSource = FirebaseAuthSource();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  String userToken = "";
  UserProvider _userProvider = new UserProvider();

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
      },
    );
  }
}
