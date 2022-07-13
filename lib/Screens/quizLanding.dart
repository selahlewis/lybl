import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lybl_mobile/requestObjects/genericAuthRequest.dart';
import 'package:lybl_mobile/responseObject/genericResponseObject.dart';
import 'package:http/http.dart' as http;
import 'package:lybl_mobile/responseObject/genericResponseObjectQuizList.dart';
import 'package:lybl_mobile/responseObject/quizObject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GLOBALVARS.dart';

class quizLanding extends StatefulWidget {
  const quizLanding({Key key}) : super(key: key);

  @override
  _quizLandingState createState() => _quizLandingState();
}

class _quizLandingState extends State<quizLanding> {
  List<QuizObject> quizObjects;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allQuestionsApiCall();
    userQuestionAnswerApiCall().then((value) => quizObjects = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }

  Future<GenericResponseObjectQuizList> allQuestionsApiCall() async {
    /*
    setState(() {
      buttonContent = Container(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
        CustomColors.white,
      )));
    });
    */

    var url = Uri.parse(
        GLOBALVARS().API_ENDPOINT + '/initialQuestion/getInitialQuestions');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    //encode Map to JSON
    var body = json.encode(GenericAuthRequest(
        apiKey: GLOBALVARS().API_KEY,
        email: prefs.getString(GLOBALVARS().EMAIL_SHARED_PREF) ?? "",
        authToken: prefs.getString(GLOBALVARS().AUTH_SHARED_PREF) ?? "",
        firebaseId: prefs.getString(GLOBALVARS().FIREBASE_SHARED_PREF) ?? "",
        userId: prefs.getInt(GLOBALVARS().USER_ID_SHARED_PREF) ?? 0));

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      try {
        GenericResponseObjectQuizList genericResponse =
            GenericResponseObjectQuizList.fromJson(jsonDecode(response.body));

        if (genericResponse.statusCode == 200) {
          /*
        setState(() {
          buttonContent = Container(
            child: Text(
              'Sign In',
              style: TextStyle(
                  fontFamily: "Avenir",
                  color: CustomColors.white,
                  fontSize: 20),
            ),
          );
        });
        */

          return genericResponse;
        } else {
          throw Exception('Failed to load');
        }
      } catch (e) {
        print(e);
        throw Exception('Failed to load');
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }

  Future<List<QuizObject>> userQuestionAnswerApiCall() async {
    /*
    setState(() {
      buttonContent = Container(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
        CustomColors.white,
      )));
    });
    */

    var url = Uri.parse(
        GLOBALVARS().API_ENDPOINT + '/initialQuestion/getUserAnswers');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    //encode Map to JSON
    var body = json.encode(GenericAuthRequest(
        apiKey: GLOBALVARS().API_KEY,
        email: prefs.getString(GLOBALVARS().EMAIL_SHARED_PREF) ?? "",
        authToken: prefs.getString(GLOBALVARS().AUTH_SHARED_PREF) ?? "",
        firebaseId: prefs.getString(GLOBALVARS().FIREBASE_SHARED_PREF) ?? "",
        userId: prefs.getInt(GLOBALVARS().USER_ID_SHARED_PREF) ?? 0));

    print(body);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    print("${response.statusCode}");
    print("${response.body}");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      try {
        GenericResponseObjectQuizList genericResponse =
            GenericResponseObjectQuizList.fromJson(jsonDecode(response.body));

        if (genericResponse.statusCode == 200) {
          /*
        setState(() {
          buttonContent = Container(
            child: Text(
              'Sign In',
              style: TextStyle(
                  fontFamily: "Avenir",
                  color: CustomColors.white,
                  fontSize: 20),
            ),
          );
        });
        */

          List<QuizObject> quizObjects = genericResponse.data.cast();

          return quizObjects;
        } else {
          throw Exception('Failed to load');
        }
      } catch (e) {
        print(e);
        throw Exception('Failed to load');
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }
}
