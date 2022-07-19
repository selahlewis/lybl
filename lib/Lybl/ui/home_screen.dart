import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lybl_mobile/Lybl/helpers/app_futures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lybl_mobile/Lybl/models/base/EventObject.dart';
import 'package:lybl_mobile/Lybl/models/User1.dart';
import 'package:lybl_mobile/Lybl/ui/breakdown_screen.dart';
import 'package:lybl_mobile/Lybl/ui/courses_screen.dart';
import 'package:lybl_mobile/Lybl/ui/views/nav_drawer.dart';
import 'package:lybl_mobile/Lybl/utils/app_shared_preferences.dart';
import 'package:lybl_mobile/Lybl/utils/constants.dart';
import 'package:lybl_mobile/Lybl/utils/themes.dart';
import 'package:html/parser.dart' as parser;
import 'package:lybl_mobile/Lybl/widgets/card_widget.dart';
import 'package:lybl_mobile/Lybl/widgets/progress_widget.dart';

class HomeScreen extends StatefulWidget {
  int courseid;

  HomeScreen(this.courseid);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState(this.courseid);
  }
}

class HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> globalKey = new GlobalKey<ScaffoldState>();
  HomeScreenState(this.courseid);
  User1 user;
  String token = "";
  int courseid;
  //BuildContext _context;
  List lessons;
  ProgressWidget progressWidget = ProgressWidget(
    text: '',
  );
  int lessonid;
  static int lessonids = 0;
  static String pageTitle = "";
  int pageNum;

  Future<void> initUserProfile() async {
    User1 _user = await AppSharedPreferences.getUserProfile();
    setState(() {
      user = _user;
    });
  }

  @override
  Widget build(BuildContext context) {
    //_context = context;
    if (user == null) {
      initUserProfile();
      lessons = [];
      _getLessons();
    }

    return Scaffold(
      key: globalKey,
      body: Container(
        //decoration: BoxDecoration(color: Colors.grey),
        child: Stack(children: [
          Column(
            children: [],
          ),
          Container(
            child: mainBody(),
          ),
          progressWidget
        ]),
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
      backgroundColor: bgColor == null ? Color(0xD5EEEEEE) : bgColor,
      leading: icon,
      centerTitle: true,
      elevation: 0,
      title: Hero(
        tag: titleTag == null ? "" : titleTag,
        child: new Text(
          title,
          style: TextStyle(
            color: Color(0xFF470223),
          ),
        ),
      ),
    );
  }

  Widget mainBody() {
    return new ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // lessonids = lessons[index]['id'];
            pageTitle = lessons[index]['shortname'];

            _getFirstPage(lessons[index]['id']);
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              child: Column(
                children: [
                  CardCourses(
                    image: lessons[index]["overviewfiles"][0]["fileurl"] +
                        "?token=" +
                        token,
                    color: Colors.white,
                    title: lessons[index]["shortname"],
                    hours: "",
                    progress: "50%",
                    percentage: 0.5,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget gridView(List levels) {
    return GridView.count(
      crossAxisCount: 1,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      childAspectRatio: MediaQuery.of(context).size.height / 600,
      children: List.generate(
        levels.length,
        (index) {
          final item = levels[index];
          return GestureDetector(
            onTap: () {
              //  lessonids = item['id'];
              pageTitle = item['shortname'];

              _getFirstPage(item['id']);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 4,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          item["name"],
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: new AssetImage("assets/images/mind.png")),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

//Get the lessons to display on screen in a grid view.
  void _getLessons() async {
    token =
        await AppSharedPreferences.getPrefs(SharedPreferenceKeys.USER_TOKEN);
    EventObject eventObject = await fetchAllCourses(token);
    switch (eventObject.id) {
      case EventConstants.REQUEST_SUCCESSFUL:
        {
          setState(() {
            progressWidget.hideProgress();
            lessons = [];
            lessons = eventObject.object;
            //  print(parser
            //     .parse(lessons[0]['intro'])
            //     .getElementsByTagName('img')[0]
            //    .attributes['src']);
          });
        }
        break;
      case EventConstants.NO_INTERNET_CONNECTION:
        {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text("Unable to connect please try again!"),
            ));
            progressWidget.hideProgress();
          });
        }
        break;
    }
  }

//Because moodle's first page number may not always start at 0 we need to always get the first page id.
  void _getFirstPage(int lessonid) async {
    token =
        await AppSharedPreferences.getPrefs(SharedPreferenceKeys.USER_TOKEN);
    EventObject eventObject = await fetchAllPages(token, lessonid);
    switch (eventObject.id) {
      case EventConstants.REQUEST_SUCCESSFUL:
        {
          setState(() {
            pageNum = eventObject.object;
            navigateToBreakDown();
            //navigateToCourses(lessonid, pageNum);
          });
        }
        break;
      case EventConstants.NO_INTERNET_CONNECTION:
        {
          setState(() {
            ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text("Unable to connect please try again!"),
            ));
            progressWidget.hideProgress();
          });
        }
        break;
    }
  }

  void navigateToCourses(int lessonid, int firstPage) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CoursesScreen(lessonid, firstPage, '');
    }));
  }

  void navigateToBreakDown() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BreakDown();
    }));
  }
}
