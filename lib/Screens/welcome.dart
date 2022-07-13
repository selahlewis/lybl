import 'package:flutter/material.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/screens/register.dart';
import 'package:page_transition/page_transition.dart';

import 'login/login.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /* Do something here if you want */
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorCodes.white,
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(
                  flex: 5,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 300, height: 300),
                  child: Image.asset('assets/images/tempLoginImage.PNG'),
                ),
                Text(
                  'Live Your',
                  style: TextStyle(
                      fontFamily: "Avenir",
                      fontWeight: FontWeight.bold,
                      color: ColorCodes.mainColorDark,
                      fontSize: 40),
                ),
                Text(
                  'Best Life',
                  style: TextStyle(
                      fontFamily: "BigCaslon",
                      color: ColorCodes.mainColorDark,
                      fontSize: 40),
                ),
                Spacer(),
                Text(
                  'Tag line ',
                  style: TextStyle(
                      fontFamily: "Big Caslon",
                      color: ColorCodes.mainColorDark,
                      fontSize: 20),
                ),
                Spacer(
                  flex: 3,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 300, height: 60),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.REGISTER);
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          fontFamily: "Avenir",
                          color: ColorCodes.white,
                          fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: ColorCodes.mainColorLight,
                    ),
                  ),
                ),
                Spacer(),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 300, height: 60),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: Login(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          fontFamily: "Avenir",
                          color: ColorCodes.black,
                          fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: ColorCodes.whiteButtonBg,
                    ),
                  ),
                ),
                Spacer(
                  flex: 5,
                ),
              ]),
        ),
      ),
    );
  }
}
