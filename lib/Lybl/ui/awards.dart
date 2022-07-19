import 'package:flutter/material.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/util/constants.dart';

import '../../Screens/Home/home.dart';
import '../../Screens/LevelUp/level_up_home.dart';

class AwardsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AwardsScreenState();
}

class AwardsScreenState extends State<AwardsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        /* Do something here if you want */
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kAccentColor,
          elevation: 0,
        ),
        drawer: Container(
          width: 250,
          child: Drawer(
            child: ListView(
              children: [
                DrawerHeader(child: Text('Menu')),
                ListTile(
                  title: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.home),
                      ),
                      Text('Home')
                    ],
                  ),
                  onTap: () {
                    //return LevelHome.route();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Home()));
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.personal_video),
                      ),
                      Text('My Profile')
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.Account);
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.arrow_circle_up_rounded),
                      ),
                      Text('Level Up')
                    ],
                  ),
                  onTap: () {
                    //return LevelHome.route();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LevelHome()));
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.settings),
                      ),
                      Text('Settings')
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.Attributes);
                  },
                ),
              ],
            ),
          ),
        ),
        body: Container(
          child: Text('You have no awards...yet!', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
