import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:lybl_mobile/Lybl/helpers/app_futures.dart';
import 'package:lybl_mobile/Lybl/models/base/EventObject.dart';
import 'package:lybl_mobile/Lybl/ui/home_screen.dart';
import 'package:lybl_mobile/Lybl/utils/app_shared_preferences.dart';
import 'package:lybl_mobile/Lybl/utils/constants.dart';

import 'package:webview_flutter/webview_flutter.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen();

  @override
  createState() => new InfoScreenState();
}

class InfoScreenState extends State<InfoScreen> {
  final GlobalKey<ScaffoldState> globalKey = new GlobalKey<ScaffoldState>();

  String token = "";
  Map lesson;

  String lessonData = '<p>Loading info please wait....</p>';
  int pageNum;

  InfoScreenState();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getLesson(context));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: globalKey,
      body: Container(
        margin: EdgeInsets.only(top: 55),
        child: Center(
          child: new ListView(
            children: <Widget>[
              new Center(
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: HtmlWidget(
                        lessonData,
                        webView: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//Get the lessons to display on screen in a grid view.
  void _getLesson(BuildContext context) async {
    token =
        await AppSharedPreferences.getPrefs(SharedPreferenceKeys.USER_TOKEN);
    EventObject eventObject =
        await fetchSingleLesson(token, HomeScreenState.lessonids);
    switch (eventObject.id) {
      case EventConstants.REQUEST_SUCCESSFUL:
        {
          setState(() {
            // progressWidget.hideProgress();
            // lessons = [];
            lesson = eventObject.object;
            lessonData = lesson['intro'];
            lessonData = lessonData.replaceAll('.mp4', '.mp4?token=' + token);
            print(lesson['intro']);
          });
        }
        break;
      case EventConstants.NO_INTERNET_CONNECTION:
        {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text("Unable to connect please try again!"),
            ));
            // progressWidget.hideProgress();
          });
        }
        break;
    }
  }
}
