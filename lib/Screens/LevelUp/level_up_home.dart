import 'package:flutter/material.dart';

import '../../Helpers/MagicStrings.dart';
import '../../common/color_constants.dart';
import '../../util/constants.dart';
import '../Home/home.dart';

class LevelHome extends StatefulWidget {
  @override
  _LevelHomeState createState() => _LevelHomeState();
}

class _LevelHomeState extends State<LevelHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kWhite,
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
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    List imgList = [
      'assets/images/therapy.jpg',
      'assets/images/heart_logo.png',
      'assets/images/mental.png',
      'assets/images/happy_people.jpg',
    ];
    List navList = [
      'home2',
      '',
      'category',
      '',
    ];

    List titleList = [
      'Continue',
      'My Favourites',
      'Start New Course',
      'My Achievements',
    ];

    return ListView(
      padding: EdgeInsets.only(bottom: 30),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Level Up",
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Avenir',
                  color: ColorConstants.kPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Basic",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Avenir',
                  color: Colors.black26,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: List.generate(4, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, navList[index]);
                },
                child: Container(
                  width: (size.width - 15) / 2,
                  height: 200,
                  child: Stack(
                    children: [
                      Container(
                        width: (size.width - 15) / 2,
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage(imgList[index]),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        width: (size.width - 15) / 2,
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: [
                                  ColorConstants.kBlack.withOpacity(0.25),
                                  ColorConstants.kBlack.withOpacity(0),
                                ],
                                end: Alignment.topCenter,
                                begin: Alignment.bottomCenter)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              titleList[index],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Container(
              width: size.width - 70,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    ColorConstants.yellow_one,
                    ColorConstants.yellow_two,
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  "SEE WHO LIKES YOU",
                  style: TextStyle(
                    color: ColorConstants.kWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
