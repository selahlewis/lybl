import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lybl_mobile/Lybl/utils/navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class FinishScreen extends StatefulWidget {
  @override
  createState() => new FinishScreenState();
}

class FinishScreenState extends State<FinishScreen> {
  final globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 3), _handleTapEvent);
    return new Scaffold(
      key: globalKey,
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Center(
          child: new ListView(
            children: <Widget>[
              new Center(
                child: Text(
                  'Lesson Complete',
                  style: GoogleFonts.roboto(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              new Image(
                height: 300.0,
                width: 300.0,
                image: new AssetImage("assets/images/happy_people.jpg"),
                fit: BoxFit.fill,
              ),
              new Center(
                child: Text(
                  'Redirecting you to the start page',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTapEvent() {
    if (this.mounted) {
      setState(() {
        pushCoursesScreen(context);
      });
    }
  }
}
