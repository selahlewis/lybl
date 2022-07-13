import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lybl_mobile/Lybl/ui/login_screen.dart';
import 'package:lybl_mobile/Lybl/utils/navigation.dart';
import 'package:lybl_mobile/Lybl/utils/app_shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatefulWidget {
  @override
  createState() => new StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  final globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    new Future.delayed(const Duration(seconds: 3), _handleTapEvent);
    return new Scaffold(
      key: globalKey,
      body: Container(
        padding: EdgeInsets.only(top: 200),
        child: Center(
          child: new ListView(
            children: <Widget>[
              new Image(
                height: 72.0,
                width: 72.0,
                image: new AssetImage("assets/images/icon.png"),
                fit: BoxFit.scaleDown,
              ),
              new Center(
                child: Text(
                  'Live your best life',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(top: 250),
                alignment: Alignment.bottomCenter,
                child: Text(
                  'demo from CenedeX',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTapEvent() async {
    bool isLoggedIn = await AppSharedPreferences.isUserLoggedIn();
    if (this.mounted) {
      setState(() {
        if (isLoggedIn != null && isLoggedIn) {
          pushHomeScreen(context);
        } else {
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(builder: (context) => new LoginScreen()),
          );
        }
      });
    }
  }
}
