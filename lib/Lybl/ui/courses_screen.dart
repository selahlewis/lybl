import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lybl_mobile/Lybl/ui/login_screen.dart';
import 'package:lybl_mobile/Lybl/ui/modules_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lybl_mobile/Lybl/helpers/app_futures.dart';
import 'package:lybl_mobile/Lybl/models/User1.dart';
import 'package:lybl_mobile/Lybl/models/base/EventObject.dart';
import 'package:lybl_mobile/Lybl/models/lesson.dart';
import 'package:lybl_mobile/Lybl/ui/finish_screen.dart';
import 'package:lybl_mobile/Lybl/utils/app_shared_preferences.dart';
import 'package:lybl_mobile/Lybl/utils/constants.dart';

import 'home_screen.dart';

class CoursesScreen extends StatefulWidget {
  final int lessonid;
  final int firstPage;
  final String answer;

  CoursesScreen(this.lessonid, this.firstPage, this.answer);

  @override
  State<StatefulWidget> createState() {
    return CourseScreenState(this.lessonid, this.firstPage, this.answer);
  }
}

class CourseScreenState extends State<CoursesScreen> {
  CourseScreenState(this.lessonid, this.firstPage, this.answer);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> globalKey = new GlobalKey<ScaffoldState>();
  User1 user;
  String token = "";
  Lesson courses;
  Map category;
  var pageData;
  String pagetype = "";
  String pageName = "";
  String answer;
  int pageNum = 0;
  int currentPage = 0;
  int lessonid;
  int firstPage;
  var videoSrc;
  String pageSubTitle = '';
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
      pageSubTitle = ModulesScreenState.subtitle;
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
            ctx: context,
            title: HomeScreenState.pageTitle,
            subTitle: pageSubTitle),
        body: Container(
          child: Stack(children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "Attempt",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Divider(),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: mainBody(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF470223)),
                ),
                onPressed: () {
                  if (category['prevpageid'] != 0) {
                    pageData = "Please Wait...";

                    _getNextPageData(category['prevpageid'], lessonid);
                  }
                },
                child: Text('Prev Page'),
              ),
            )
          ]),
        ),
      ),
    );
  }

  AppBar getAppBarWithBackBtn(
      {BuildContext ctx,
      String title,
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
                        Divider(),
                        _finishButtonContainer()
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
                if (pagetype == 'Essay') _submitButtonContainer(),
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
      child: new FormBuilderTextField(
        name: 'answer',
        textAlignVertical: TextAlignVertical.top,
        controller: passwordController,
        decoration: InputDecoration(
            labelText: 'answer',
            alignLabelWithHint: true,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            prefixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
              child: Icon(Icons.edit),
            )),
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        obscureText: false,
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _finishButtonContainer() {
    if (category['nextpageid'] == 0) {
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
                _finishlessonButton();
              },
              child: new Text(
                'Finish Lesson',
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            margin: EdgeInsets.only(bottom: 30.0),
          ));
    } else {
      return Align(
        alignment: Alignment.bottomCenter,
        child: new MaterialButton(
          minWidth: double.infinity,
          textColor: Colors.white,
          padding: EdgeInsets.all(15.0),
          color: Color(0xFF470223),
          onPressed: () {
            pageData = "Please Wait...";

            _getNextPageData(category['nextpageid'], lessonid);
          },
          child: Text('Next Page'),
        ),
      );
    }
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
              'Submit Answer',
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

      await finishAttempt(token, lessonid);
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: new Text("Lesson complete!"),
      ));
      Timer(Duration(seconds: 2), () {
        navigateToFinish();
      });
    } else {
      postAnswer(token, passwordController.text, currentPage, lessonid);
      _getNextPageData(category['nextpageid'], lessonid);
    }

    passwordController.text = "";
  }

  Future<void> _finishlessonButton() async {
    token =
        await AppSharedPreferences.getPrefs(SharedPreferenceKeys.USER_TOKEN);

    FocusScope.of(context).requestFocus(new FocusNode());
    if (category['nextpageid'] == 0) {
      finishAttempt(token, lessonid);
      navigateToFinish();
    } else {
      _getNextPageData(category['nextpageid'], lessonid);
    }
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
            print(pageData);
            // var textdata =
            //parse(pageData).body.getElementsByClassName('no-overflow');
            //  print(textdata[0].text);
            //A little magic to get the app to display images or videos of these formats.
            pageData = pageData.replaceAll(
                'pluginfile.php', 'webservice/pluginfile.php');
            pageData = pageData
                .replaceAll('.JPG', '.JPG?token=' + token)
                .replaceAll('.mp4', '.mp4?token=' + token);

            currentPage = category['id'];
            pagetype = category['typestring'];
            pageName = category['title'];
            pageSubTitle = pageName;
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
