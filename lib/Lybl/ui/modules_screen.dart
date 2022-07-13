import 'package:flutter/material.dart';

import 'package:lybl_mobile/Lybl/helpers/app_futures.dart';
import 'package:lybl_mobile/Lybl/models/User1.dart';
import 'package:lybl_mobile/Lybl/models/base/EventObject.dart';
import 'package:lybl_mobile/Lybl/ui/home_screen.dart';
import 'package:lybl_mobile/Lybl/utils/app_shared_preferences.dart';
import 'package:lybl_mobile/Lybl/utils/constants.dart';

import 'courses_screen.dart';

import 'package:lybl_mobile/Lybl/ui/courses_screen.dart';

class ModulesScreen extends StatefulWidget {
  @override
  createState() => new ModulesScreenState();
}

class ModulesScreenState extends State<ModulesScreen> {
  final globalKey = new GlobalKey<ScaffoldState>();
  String token = "";
  List pageList;

  User1 _user;
  int userId;
  static String subtitle = '';
  @override
  void initState() {
    super.initState();
    pageList = [];
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _getPagesList(HomeScreenState.lessonids, context));
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
              itemCount: pageList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    navigateToCourses(HomeScreenState.lessonids,
                        pageList[index]['page']['id']);
                    subtitle = pageList[index]['title'];
                  },
                  title: Text((index + 1).toString() +
                      '.  ' +
                      pageList[index]['title']),
                );
              }),
        ),
      ),
    );
  }

  void _getPagesList(int lessonid, BuildContext context) async {
    token =
        await AppSharedPreferences.getPrefs(SharedPreferenceKeys.USER_TOKEN);
    _user = await AppSharedPreferences.getUserProfile();
    userId = _user.userid;
    EventObject eventObject = await getAnswersList(token, lessonid, userId, 0);
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

  void navigateToCourses(int lessonid, int firstPage) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CoursesScreen(lessonid, firstPage, '');
    }));
  }
}
