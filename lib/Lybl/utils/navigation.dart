import 'package:lybl_mobile/Lybl/ui/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../Screens/Home/home2.dart';
import '../ui/category_screen.dart';

void pushHomeScreen(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    PageTransition(
      child: CategoryScreen(),
      type: PageTransitionType.bottomToTop,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    ),
    (route) => false,
  );
}

void pushCoursesScreen(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    PageTransition(
      child: Lessons(),
      type: PageTransitionType.topToBottom,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    ),
    (route) => false,
  );
}

void pushSettingsScreen(BuildContext context) {
  //Navigator.of(context).push(
  //  MaterialPageRoute(builder: (context) => FfSettings()),
  //);
}

void pushAttributionsScreen(BuildContext context) {
  /*Navigator.of(context).push(
      //MaterialPageRoute(builder: (context) => AttributionsScreen()),
      );*/
}
