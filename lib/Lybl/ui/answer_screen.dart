import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lybl_mobile/Lybl/helpers/app_futures.dart';
import 'package:lybl_mobile/Lybl/models/User1.dart';
import 'package:lybl_mobile/Lybl/models/base/EventObject.dart';
import 'package:lybl_mobile/Lybl/ui/home_screen.dart';
import 'package:lybl_mobile/Lybl/ui/review_screen.dart';
import 'package:lybl_mobile/Lybl/utils/app_shared_preferences.dart';
import 'package:lybl_mobile/Lybl/utils/constants.dart';

class AnswerScreen extends StatefulWidget {
  @override
  createState() => new AnswerScreenState();
}

class AnswerScreenState extends State<AnswerScreen> {
  final globalKey = new GlobalKey<ScaffoldState>();
  String token = "";
  int userId = 0;
  User1 _user;
  Map pageList;
  List answerList;
  List finishedList = [];
  var lessonid = HomeScreenState.lessonids;
  List students = [];
  Future<void> initUserProfile() async {
    _user = await AppSharedPreferences.getUserProfile();
    setState(() {
      userId = _user.userid;
    });
  }

  @override
  void initState() {
    super.initState();
    answerList = [];
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getAnswers(lessonid, context));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: globalKey,
      body: Container(
        margin: EdgeInsets.only(top: 55),
        child: Center(
          child: new ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: finishedList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    navigateToReview(finishedList[index]['try']);
                  },
                  title: Text('Lesson attempt #' + (index + 1).toString()),
                  subtitle: Text('Tap to view answers'),
                );
              }),
        ),
      ),
    );
  }

  void getAnswers(int lessonid, BuildContext context) async {
    token =
        await AppSharedPreferences.getPrefs(SharedPreferenceKeys.USER_TOKEN);
    _user = await AppSharedPreferences.getUserProfile();
    userId = _user.userid;
    EventObject eventObject = await getAnswerNumbers(token, lessonid);
    switch (eventObject.id) {
      //Get the page content/html data together with the page type and title.
      // Also the nextpageid for scrolling to the next page.
      // Page type is needed to know if to display the submit answer input field and button. eg pageType 'Essay'
      case EventConstants.REQUEST_SUCCESSFUL:
        {
          setState(() {
            pageList = eventObject.object;

            var attNums = pageList['students'][0]['attempts'][0]['try'];
            // Map pageTitle = pageList['page'];
            print(attNums);
            students = pageList['students'];
            if (students.length == 1) {
              if (students[0]['id'] == userId) {
                answerList = students[0]['attempts'];
                for (int i = 0; i < answerList.length; i++) {
                  if (answerList[i]['grade'] == 0) {
                    finishedList.add(answerList[i]);
                  }
                }
              }
            } else {
              for (int i = 0; i < students.length; i++) {
                if (students[i]['id'] == userId) {
                  answerList = students[i]['attempts'];
                  for (int i = 0; i < answerList.length; i++) {
                    if (answerList[i]['grade'] == 0) {
                      finishedList.add(answerList[i]);
                    }
                  }
                }
              }
            }
          });
          // print(students[0]['attempts']);

        }
        break;
      case EventConstants.NO_INTERNET_CONNECTION:
        {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text("Unable to connect please try again!"),
            ));
          });
        }
        break;
    }
  }

  void navigateToReview(int ans) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ReviewScreen(ans);
    }));
  }
}
