import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lybl_mobile/Lybl/ui/home_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lybl_mobile/Lybl/helpers/app_futures.dart';
import 'package:lybl_mobile/Lybl/models/User1.dart';
import 'package:lybl_mobile/Lybl/models/base/EventObject.dart';
import 'package:lybl_mobile/Lybl/models/lesson.dart';
import 'package:lybl_mobile/Lybl/ui/finish_screen.dart';
import 'package:lybl_mobile/Lybl/utils/app_shared_preferences.dart';
import 'package:lybl_mobile/Lybl/utils/constants.dart';

class AnswerReviewScreen extends StatefulWidget {
  final int lessonid;
  final int firstPage;
  final String answer;

  AnswerReviewScreen(this.lessonid, this.firstPage, this.answer);

  @override
  State<StatefulWidget> createState() {
    return AnswerReviewScreenState(this.lessonid, this.firstPage, this.answer);
  }
}

class AnswerReviewScreenState extends State<AnswerReviewScreen> {
  AnswerReviewScreenState(this.lessonid, this.firstPage, this.answer);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> globalKey = new GlobalKey<ScaffoldState>();
  User1 user;
  String token = "";
  Lesson courses;
  Map category;
  var pageData;
  String pagetype = '';
  String pageName = '';
  String answer;
  int pageNum = 0;
  int currentPage = 0;
  int lessonid;
  int firstPage;
  var videoSrc;
  TextEditingController passwordController =
      new TextEditingController(text: "");

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (user == null) {
      await initUserProfile();
    }
  }

  Future<void> initUserProfile() async {
    User1 _user = await AppSharedPreferences.getUserProfile();
    setState(() {
      user = _user;

      answer = Bidi.stripHtmlIfNeeded(answer);
      passwordController.text = answer;
      _getNextPageData(firstPage, lessonid);
    });
  }

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        moveToLastScreen();
        return new Future(() => false);
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: getAppBarWithBackBtn(
            ctx: context, title: HomeScreenState.pageTitle, fontSize: 20),
        body: Container(
          child: Stack(children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "Exercise",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Divider(),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 55),
              child: mainBody(),
            ),
          ]),
        ),
      ),
    );
  }

  AppBar getAppBarWithBackBtn(
      {BuildContext ctx,
      String title,
      Color bgColor,
      double fontSize,
      String titleTag,
      Widget icon}) {
    return AppBar(
      //backgroundColor: bgColor == null ? ColorConst.APP_COLOR : bgColor,
      leading: icon,
      centerTitle: true,
      title:
          Hero(tag: titleTag == null ? "" : titleTag, child: new Text(title)),
    );
  }

  Widget mainBody() {
    if (pagetype == "Content") {
      return new Center(
          child: Container(
              padding: EdgeInsets.all(5.0),
              child: new ListView(
                children: <Widget>[
                  new Center(
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: HtmlWidget(
                            pageData,
                            webView: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )));
    } else {
      return new Center(
          child: Container(
              child: new ListView(
        children: <Widget>[
          new Center(
            child: new Column(
              children: <Widget>[
                if (pagetype == 'Essay') _textHeading(),
                if (pagetype == 'Essay') _answerContainer(),
              ],
            ),
          ),
        ],
      )));
    }
  }

  Widget _textHeading() {
    if (pageData != null) {
      return new Center(child: Html(data: pageData));
    } else {
      return new Center(child: Text("This lesson has no content"));
    }
  }

  Widget _answerContainer() {
    return new Padding(
      padding: new EdgeInsets.all(25.0),
      child: Center(
        child: new FormBuilderTextField(
          name: 'Your answer',
          controller: passwordController,
          decoration: InputDecoration(
              labelText: 'Your answer',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                child: Icon(Icons.edit),
              )),
          readOnly: true,
          keyboardType: TextInputType.multiline,
          obscureText: false,
          textAlign: TextAlign.start,
          maxLines: 5,
        ),
      ),
    );
  }

  Widget _submitButtonContainer() {
    return new Padding(
        padding: new EdgeInsets.all(25.0),
        child: new Container(
          width: double.infinity,
          decoration: new BoxDecoration(
              color: Color(0xFF470223),
              borderRadius: BorderRadius.circular(5.0)),
          child: new MaterialButton(
            textColor: Colors.white,
            padding: EdgeInsets.all(15.0),
            onPressed: () {
              _submitAnswerButton();
            },
            child: new Text(
              'Update Answer',
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          margin: EdgeInsets.only(bottom: 30.0),
        ));
  }

  Future<void> _submitAnswerButton() async {
    token =
        await AppSharedPreferences.getPrefs(SharedPreferenceKeys.USER_TOKEN);
    if (passwordController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: new Text("Please submit an Answer!"),
      ));
      return;
    }
    FocusScope.of(context).requestFocus(new FocusNode());
    if (category['nextpageid'] == 0) {
      postAnswer(token, passwordController.text, currentPage, lessonid);
      //finishAttempt(token, lessonid);
      //navigateToFinish();
    } else {
      postAnswer(token, passwordController.text, currentPage, lessonid);
    }

    passwordController.text = "";
  }

  void _getNextPageData(int pageNums, int lessonid) async {
    token =
        await AppSharedPreferences.getPrefs(SharedPreferenceKeys.USER_TOKEN);
    EventObject eventObject = await fetchPages(token, pageNums, lessonid);
    switch (eventObject.id) {
      //Get the page content/html data together with the page type and title.
      // Also the nextpageid for scrolling to the next page.
      // Page type is needed to know if to display the submit answer input field and button. eg pageType 'Essay'
      case EventConstants.REQUEST_SUCCESSFUL:
        {
          setState(() {
            category = eventObject.object;

            pageData = category['contents'];

            // var textdata =
            //parse(pageData).body.getElementsByClassName('no-overflow');
            //  print(textdata[0].text);
            //A little magic to get the app to display images or videos of these formats.
            pageData = pageData.replaceAll(
                'pluginfile.php', 'webservice/pluginfile.php');
            pageData = pageData
                .replaceAll('.JPG', '.JPG?token=' + token)
                .replaceAll('.PNG', '.PNG?token=' + token)
                .replaceAll('.mp4', '.mp4?token=' + token);

            currentPage = category['id'];
            pagetype = category['typestring'];
            pageName = category['title'];
            if (category['nextpageid'] == 0) {
              pageNum = firstPage;
            } else {
              pageNum = category['nextpageid'];
            }
          });
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

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void navigateToFinish() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FinishScreen();
    }));
  }
}
