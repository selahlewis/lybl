import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:lybl_mobile/Screens/Widgets/custom_modal_progress_hud.dart';
import 'package:lybl_mobile/Screens/Widgets/rounded_icon_button.dart';
import 'package:lybl_mobile/Screens/matched_screen.dart';
import 'package:lybl_mobile/common/color_constants.dart';
import 'package:lybl_mobile/data/entity/app_user.dart';
import 'package:lybl_mobile/data/entity/chat.dart';
import 'package:lybl_mobile/data/entity/match.dart';
import 'package:lybl_mobile/data/entity/message.dart';
import 'package:lybl_mobile/data/entity/swipe.dart';
import 'package:lybl_mobile/data/explore_json.dart';
import 'package:lybl_mobile/data/icons.dart';
import 'package:lybl_mobile/data/provider/user_provider.dart';
import 'package:lybl_mobile/data/remote/firebase_database_source.dart';
import 'package:lybl_mobile/util/constants.dart';
import 'package:lybl_mobile/util/utils.dart';
import 'package:provider/provider.dart';

/*
Title:ExploreScreen
Purpose:ExploreScreen
Created By:Kalpesh Khandla
*/

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with TickerProviderStateMixin {
  CardController controller;
  final FirebaseDatabaseSource _databaseSource = FirebaseDatabaseSource();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> _ignoreSwipeIds;

  var itemLength = 0;

  Future<AppUser> loadPerson(String myUserId) async {
    if (_ignoreSwipeIds == null) {
      _ignoreSwipeIds = [];
      var swipes = await _databaseSource.getSwipes(myUserId);
      itemLength = swipes.size;
      for (var i = 0; i < swipes.size; i++) {
        Swipe swipe = Swipe.fromSnapshot(swipes.docs[i]);
        _ignoreSwipeIds.add(swipe.id);
      }
      _ignoreSwipeIds.add(myUserId);
    }
    var res = await _databaseSource.getPersonsToMatchWith(1, _ignoreSwipeIds);
    if (res.docs.length > 0) {
      var userToMatchWith = AppUser.fromSnapshot(res.docs.first);
      return userToMatchWith;
    } else {
      return null;
    }
  }

  void personSwiped(AppUser myUser, AppUser otherUser, bool isLiked) async {
    _databaseSource.addSwipedUser(myUser.id, Swipe(otherUser.id, isLiked));
    _ignoreSwipeIds.add(otherUser.id);

    if (isLiked == true) {
      if (await isMatch(myUser, otherUser) == true) {
        _databaseSource.addMatch(myUser.id, Match1(otherUser.id));
        _databaseSource.addMatch(otherUser.id, Match1(myUser.id));
        String chatId = compareAndCombineIds(myUser.id, otherUser.id);
        _databaseSource.addChat(Chat(chatId, null));

        Navigator.pushNamed(context, MatchedScreen.id, arguments: {
          "my_user_id": myUser.id,
          "my_profile_photo_path": myUser.profilePhotoPath,
          "other_user_profile_photo_path": otherUser.profilePhotoPath,
          "other_user_id": otherUser.id
        });
      }
    }
    setState(() {});
  }

  Future<bool> isMatch(AppUser myUser, AppUser otherUser) async {
    DocumentSnapshot swipeSnapshot =
        await _databaseSource.getSwipe(otherUser.id, myUser.id);
    if (swipeSnapshot.exists) {
      Swipe swipe = Swipe.fromSnapshot(swipeSnapshot);

      if (swipe.liked == true) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.kWhite,
      body: getBody(),
      bottomSheet: getBottomSheet(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: Container(child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return FutureBuilder<AppUser>(
            future: userProvider.user,
            builder: (context, userSnapshot) {
              return CustomModalProgressHUD(
                inAsyncCall:
                    userProvider.user == null || userProvider.isLoading,
                child: (userSnapshot.hasData)
                    ? FutureBuilder<AppUser>(
                        future: loadPerson(userSnapshot.data.id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              !snapshot.hasData) {
                            return Center(
                              child: Container(
                                  child: Text('No users',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4)),
                            );
                          }
                          if (!snapshot.hasData) {
                            return CustomModalProgressHUD(
                              inAsyncCall: true,
                              child: Container(),
                            );
                          }
                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: 120, top: 20),
                            child: Container(
                              height: size.height,
                              child: TinderSwapCard(
                                totalNum: itemLength,
                                maxWidth: MediaQuery.of(context).size.width,
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.75,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.75,
                                minHeight:
                                    MediaQuery.of(context).size.height * 0.6,
                                cardBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: ColorConstants.kBlack
                                                .withOpacity(0.3),
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
                                          color: ColorConstants.kWhite,
                                        ),
                                        Container(
                                          width: size.width,
                                          height: 245,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data.profilePhotoPath),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Container(
                                          width: size.width,
                                          height: size.height,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: size.width * 0.72,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                snapshot
                                                                    .data.name,
                                                                style: TextStyle(
                                                                    color: ColorConstants
                                                                        .kPurple,
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                snapshot
                                                                    .data.age
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorConstants
                                                                      .kPurple,
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
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      ColorConstants
                                                                          .kGreen,
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                "Recently Active",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      ColorConstants
                                                                          .kGrey,
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
                                                      child: Container(
                                                        width: size.width * 0.2,
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.info,
                                                            color:
                                                                ColorConstants
                                                                    .kGrey,
                                                            size: 28,
                                                          ),
                                                        ),
                                                      ),
                                                    )
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
                                swipeUpdateCallback: (DragUpdateDetails details,
                                    Alignment align) {
                                  /// Get swiping card's alignment
                                  if (align.x < 0) {
                                    //Card is LEFT swiping
                                    personSwiped(userSnapshot.data,
                                        snapshot.data, false);
                                  } else if (align.x > 0) {
                                    //Card is RIGHT swiping
                                    personSwiped(
                                        userSnapshot.data, snapshot.data, true);
                                  }
                                  // print(itemsTemp.length);
                                },
                                swipeCompleteCallback:
                                    (CardSwipeOrientation orientation,
                                        int index) {
                                  /// Get orientation & index of swiped card!
                                  if (index == (itemLength - 1)) {
                                    setState(() {
                                      itemLength = itemLength - 1;
                                    });
                                  }
                                },
                              ),
                            ),
                          );
                        })
                    : Container(),
              );
            },
          );
        },
      )),
      bottomSheet: getBottomSheet(),
    );
  }

  Widget getBottomSheet() {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: 100,
        decoration: BoxDecoration(color: ColorConstants.kWhite),
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedIconButton(
                  onPressed: () {},
                  iconData: Icons.clear,
                  buttonColor: Color(0xFFE7E6E6),
                  iconSize: 30,
                ),
                RoundedIconButton(
                  onPressed: () {},
                  buttonColor: Color(0xFFD60606),
                  iconData: Icons.favorite,
                  iconSize: 30,
                ),
              ],
            )));
  }
}
