import 'package:flutter/material.dart';
import 'package:lybl_mobile/GLOBALVARS.dart';
import '../Helpers/MagicStrings.dart';
import 'package:lybl_mobile/responseObject/loginReturn.dart';
import 'package:lybl_mobile/screens/quizLanding.dart';
import 'package:page_transition/page_transition.dart';

class MainLanding extends StatefulWidget {
  final LoginReturn userData;

  MainLanding({Key key, @required this.userData}) : super(key: key);

  @override
  _MainLandingState createState() => _MainLandingState();
}

class _MainLandingState extends State<MainLanding> {
  int _fragmentIndex = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  void onTabTapped(int index) {
    setState(() {
      if (index == 3) {
        _scaffoldKey.currentState?.openEndDrawer();
      } else {
        _fragmentIndex = index;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      if (widget.userData.ingestComplete == false) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: quizLanding(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    LoginReturn userData = widget.userData;

    final List<Widget> _fragments = [
      Text(userData.toString()),
      Text("Page 2"),
      Text("Page 3"),
      Text("Page 4"),
    ];

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'user',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: SafeArea(child: _fragments[_fragmentIndex]),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: ColorCodes.mainColorDark,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            //primaryColor: Colors.red,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.yellow))),
        child: BottomNavigationBar(
          currentIndex: _fragmentIndex,
          onTap: ((onTabTapped)),
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'My Journey',
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Discovery',
            ),
            new BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_outlined),
                label: 'My Matches'),
            new BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                ),
                label: 'Menu')
          ],
        ),
      ),
    );
  }
}
