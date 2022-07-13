import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:http/http.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/Models/User2.dart';
import 'package:lybl_mobile/Models/swipe_yes.dart';
import 'package:lybl_mobile/Screens/Account/profile_details.dart';
import 'package:lybl_mobile/Screens/matched_screen.dart';
import 'package:lybl_mobile/Services/HttpServices/Endpoints.dart';
import 'package:lybl_mobile/data/entity/app_user.dart';
import 'package:lybl_mobile/data/entity/chat.dart';
import 'package:lybl_mobile/data/entity/match.dart';
import 'package:lybl_mobile/data/icons.dart';
import 'package:lybl_mobile/data/remote/firebase_database_source.dart';
import 'package:lybl_mobile/util/shared_preferences_utils.dart';
import 'package:lybl_mobile/util/utils.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  CardController controller;
  List itemsTemp = [];
  int itemLength = 0;
  var matchList = [];
  bool ready = false;
  AppUser user;
  SwipeYes rightSwipe;
  int userid = 0;
  final FirebaseDatabaseSource _databaseSource = FirebaseDatabaseSource();
  String photoUrl;

  String myPhotoUrl = '';

  var myFirebaseId;

  var otherId;

  var otherPhotoUrl;

  List itemsTemp2 = [];

  int itemLength2 = 0;

  String myGender = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getMatch(context);
      rightSwipe = new SwipeYes();

      // itemsTemp = explore_json;
      // itemLength = explore_json.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: getBody(),
      bottomSheet: getBottomSheet(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
      child: Container(
        height: size.height,
        child: TinderSwapCard(
          totalNum: itemLength2,
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height * 0.75,
          minWidth: MediaQuery.of(context).size.width * 0.75,
          minHeight: MediaQuery.of(context).size.height * 0.6,
          cardBuilder: (context, index) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              itemsTemp2[index]['profile_image_main']),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          black.withOpacity(0.25),
                          black.withOpacity(0),
                        ],
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Container(
                                width: size.width * 0.72,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          itemsTemp2[index]['name'],
                                          style: TextStyle(
                                              color: white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          itemsTemp2[index]['age'],
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              color: green,
                                              shape: BoxShape.circle),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Recently Active",
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProfileDetails(
                                          itemsTemp2[index]['user_id'],
                                          itemsTemp2[index]
                                              ['profile_image_main'])));
                                },
                                child: Container(
                                  width: size.width * 0.2,
                                  child: Center(
                                    child: Icon(
                                      Icons.info,
                                      color: white,
                                      size: 48,
                                    ),
                                  ),
                                ),
                              )),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          cardController: controller = CardController(),
          swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
            /// Get swiping card's alignment
            if (align.x < 0) {
              //Card is LEFT swiping
            } else if (align.x > 0) {
              //Card is RIGHT swiping

            }
            // print(itemsTemp.length);
          },
          swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
            /// Get orientation & index of swiped card!
            if (orientation == CardSwipeOrientation.RIGHT) {
              photoUrl = itemsTemp2[index]['profile_image_main'];
              otherId = itemsTemp2[index]['user_id'];
              otherPhotoUrl = itemsTemp2[index]['profile_image_main'];
              rightSwipe = new SwipeYes();
              rightSwipe.user_id = userid;
              rightSwipe.other_id = itemsTemp[index]['user_id'];
              rightSwipe.otherFirebaseId = itemsTemp2[index]['firebase_id'];
              rightSwipe.liked_id = 1;
              swipeRight(context, rightSwipe);
            } else if (orientation == CardSwipeOrientation.LEFT) {
              photoUrl = itemsTemp2[index]['profile_image_main'];
              otherId = itemsTemp2[index]['user_id'];
              otherPhotoUrl = itemsTemp2[index]['profile_image_main'];
              rightSwipe = new SwipeYes();
              rightSwipe.user_id = userid;
              rightSwipe.other_id = itemsTemp2[index]['user_id'];
              rightSwipe.otherFirebaseId = itemsTemp2[index]['firebase_id'];
              rightSwipe.liked_id = 0;
              swipeRight(context, rightSwipe);
            }
            if (index == (itemsTemp2.length - 1)) {
              setState(() {
                itemLength2 = itemsTemp2.length - 1;
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Swiped Yes"),
                duration: Duration(milliseconds: 800),
              ));
            }
          },
        ),
      ),
    );
  }

  Widget getBottomSheet() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      decoration: BoxDecoration(color: white),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(item_icons.length, (index) {
            return InkWell(
              onTap: () {
                if (index == 1) {
                  controller.triggerRight();
                } else {
                  controller.triggerLeft();
                }
              },
              child: Container(
                width: item_icons[index]['size'],
                height: item_icons[index]['size'],
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 10,
                        // changes position of shadow
                      ),
                    ]),
                child: Center(
                  child: SvgPicture.asset(
                    item_icons[index]['icon'],
                    width: item_icons[index]['icon_size'],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> getMatch(BuildContext context) async {
    var data1 =
        context.read<SharedPreferences>().getString(SharedPrefNames.USER);
    User2 user = User2.fromJson(json.decode(data1 ?? ''));
    Response response = await get(Endpoints.getFindMatch(user.id));

    print(response.request);
    var data = json.decode(response.body)['Match Found'];

    print(response.body);
    setState(() {
      userid = user.id;
      itemsTemp = data;
      if (itemsTemp.isNotEmpty) {
        ready = true;
        itemsTemp = data;
        itemLength = itemsTemp.length;
        for (int i = 0; i < itemsTemp.length; i++) {
          if (itemsTemp[i]['user_id'] == userid) {
            myPhotoUrl = itemsTemp[i]['profile_image_main'];
            myFirebaseId = itemsTemp[i]['firebase_id'];
            myGender = itemsTemp[i]['gender'];
            print(myGender);
          }
        }
        for (int x = 0; x < itemsTemp.length; x++) {
          if (itemsTemp[x]['user_id'] != userid &&
              itemsTemp[x]['gender'] != myGender) {
            print(myGender + ' vs ' + itemsTemp[x]['gender']);
            itemsTemp2.add(itemsTemp[x]);
          }
          itemLength2 = itemsTemp2.length;
        }
      }
    });
  }

  void swipeRight(BuildContext context, SwipeYes swipeData) async {
    Response response =
        await post(Endpoints.swipeYes, body: swipeToJson(swipeData));
    print(response.body);
    print(response.statusCode);

    Response res = await get(
        Endpoints.getMatched(userid, swipeData.other_id, swipeData.liked_id));
    print(res.body);
    if (!res.body.contains('null')) {
      _databaseSource.addMatch(myFirebaseId, Match1(swipeData.otherFirebaseId));
      _databaseSource.addMatch(swipeData.otherFirebaseId, Match1(myFirebaseId));
      String chatId =
          compareAndCombineIds(myFirebaseId, swipeData.otherFirebaseId);
      _databaseSource.addChat(Chat(chatId, null));
      Navigator.pushNamed(context, MatchedScreen.id, arguments: {
        "my_user_id": myFirebaseId,
        "my_profile_photo_path": myPhotoUrl.toString(),
        "other_user_profile_photo_path": photoUrl.toString(),
        "other_user_id": swipeData.otherFirebaseId.toString(),
      });
    }

    if (response.statusCode == 500) {
      print('no more users');
    }
  }
}
