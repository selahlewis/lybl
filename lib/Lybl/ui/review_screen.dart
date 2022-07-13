import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lybl_mobile/Lybl/helpers/app_futures.dart';
import 'package:lybl_mobile/Lybl/models/User1.dart';
import 'package:lybl_mobile/Lybl/models/base/EventObject.dart';
import 'package:lybl_mobile/Lybl/utils/app_shared_preferences.dart';
import 'package:lybl_mobile/Lybl/utils/constants.dart';

import 'answer_review.dart';
import 'courses_screen.dart';

import 'package:lybl_mobile/Lybl/ui/courses_screen.dart';

class ReviewScreen extends StatefulWidget {
  final int answerNumber;
  ReviewScreen(this.answerNumber);

  @override
  State<StatefulWidget> createState() {
    return ReviewScreenState(this.answerNumber);
  }
}

class ReviewScreenState extends State<ReviewScreen> {
  final globalKey = new GlobalKey<ScaffoldState>();
  ReviewScreenState(this.answerNumber);
  int answerNumber;
  String token = "";
  int userId = 0;
  User1 _user;
  List pageList;
  List answerList;
  var lessonid = 15;
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
      appBar: getAppBarWithBackBtn(
          ctx: context, title: 'Answers', subTitle: 'Review your answers'),
      body: Container(
        margin: EdgeInsets.only(top: 5),
        child: Center(
          child: new ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: answerList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    navigateToAnswerReview(15, answerList[index]['page']['id'],
                        answerList[index]['answerdata']['answers'][0][0]);
                  },
                  title: Text((index + 1).toString() +
                      '.  ' +
                      answerList[index]['title']),
                  subtitle: Text('Tap to view your answers'),
                );
              }),
        ),
      ),
    );
  }

  AppBar getAppBarWithBackBtn(
      {@required BuildContext ctx,
      @required String title,
      String subTitle = "",
      Color bgColor,
      double fontSize,
      String titleTag,
      Widget icon}) {
    return AppBar(
      //backgroundColor: bgColor == null ? ColorConst.APP_COLOR : bgColor,
      leading: icon,
      centerTitle: true,
      title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            Text(
              subTitle,
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          ]),
    );
  }

  void getAnswers(int lessonid, BuildContext context) async {
    token =
        await AppSharedPreferences.getPrefs(SharedPreferenceKeys.USER_TOKEN);
    _user = await AppSharedPreferences.getUserProfile();
    userId = _user.userid;
    EventObject eventObject =
        await getAnswersList(token, lessonid, userId, answerNumber);
    switch (eventObject.id) {
      //Get the page content/html data together with the page type and title.
      // Also the nextpageid for scrolling to the next page.
      // Page type is needed to know if to display the submit answer input field and button. eg pageType 'Essay'
      case EventConstants.REQUEST_SUCCESSFUL:
        {
          setState(() {
            pageList = eventObject.object;

            // Map pageTitle = pageList['page'];
            print(pageList);
          });
          for (int i = 0; i < pageList.length; i++) {
            if (pageList[i]['qtype'].toString() == 'Essay') {
              answerList.add(pageList.elementAt(i));
            }
          }
          // String ans = answerList[0]['answerdata']['answers'][0][0];
          // print(ans);
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

  void navigateToAnswerReview(
      int lessonid, int firstPage, String answer) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AnswerReviewScreen(lessonid, firstPage, answer);
    }));
  }
}
