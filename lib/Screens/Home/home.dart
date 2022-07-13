import 'package:flutter/material.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/Lybl/ui/home_screen.dart';
import 'package:lybl_mobile/Screens/chats_screen.dart';
import 'package:lybl_mobile/Screens/explore_page.dart';
import 'package:lybl_mobile/Screens/explore_screen.dart';
import 'package:lybl_mobile/Screens/like_screen.dart';
import 'package:lybl_mobile/util/constants.dart';

import '../LevelUp/level_up_home.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  int selected = 1;

  static List<Widget> _widgetOptions = <Widget>[
    ExplorePage(),
    //LikesScreen(),
    ChatsScreen(),
    HomeScreen(),
  ];

  navigateBottomBar(int value) {
    setState(() {
      selected = value;
    });
  }

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
          color: Colors.red,
          child: _widgetOptions.elementAt(selected),
        ),
        bottomNavigationBar: Container(
          color: Colors.red,
          child: BottomNavigationBar(
            backgroundColor: ColorCodes.mainColorDark,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              //  BottomNavigationBarItem(icon: Icon(Icons.local_florist), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.equalizer), label: ''),
            ],
            currentIndex: selected,
            onTap: navigateBottomBar,
            selectedItemColor: ColorCodes.mainColorLight,
            unselectedItemColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
        ),
      ),
    );
  }
}
