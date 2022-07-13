import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lybl_mobile/Screens/Widgets/custom_modal_progress_hud.dart';
import 'package:lybl_mobile/Screens/Widgets/input_dialog.dart';
import 'package:lybl_mobile/Screens/Widgets/rounded_button.dart';
import 'package:lybl_mobile/Screens/Widgets/rounded_icon_button.dart';
import 'package:lybl_mobile/data/entity/app_user.dart';
import 'package:lybl_mobile/data/provider/user_provider.dart';
import 'package:lybl_mobile/util/constants.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void logoutPressed(UserProvider userProvider, BuildContext context) async {
    userProvider.logoutUser();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.pop(context);
    Navigator.pushNamed(context, 'login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 42.0,
          horizontal: 18.0,
        ),
        margin: EdgeInsets.only(bottom: 40),
        child: Consumer<UserProvider>(builder: (context, userProvider, child) {
          return FutureBuilder<AppUser>(
              future: userProvider.user,
              builder: (context, userSnapshot) {
                return CustomModalProgressHUD(
                    inAsyncCall:
                        userProvider.user == null || userProvider.isLoading,
                    child: userSnapshot.hasData
                        ? Column(children: [
                            getProfileImage(userSnapshot.data, userProvider),
                            SizedBox(height: 20),
                            Text(
                                '${userSnapshot.data.name}, ${userSnapshot.data.age}',
                                style: Theme.of(context).textTheme.headline4),
                            SizedBox(height: 40),
                            getBio(userSnapshot.data, userProvider),
                            Expanded(child: Container()),
                            RoundedButton(
                                text: 'LOGOUT',
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Logout'),
                                      content: const Text(
                                          'Are you sure you want to logout?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'Yes');
                                            logoutPressed(
                                                userProvider, context);
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                          ])
                        : Container());
              });
        }),
      ),
    );
  }

  Widget getBio(AppUser user, UserProvider userProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Bio', style: Theme.of(context).textTheme.headline4),
            RoundedIconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => InputDialog(
                    onSavePressed: (value) => userProvider.updateUserBio(value),
                    labelText: 'Bio',
                    startInputText: user.bio,
                  ),
                );
              },
              iconData: Icons.edit,
              iconSize: 18,
              paddingReduce: 4,
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          user.bio.length > 0 ? user.bio : "No bio.",
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget getProfileImage(AppUser user, UserProvider firebaseProvider) {
    return Stack(
      children: [
        Container(
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.profilePhotoPath),
            radius: 75,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: kAccentColor, width: 1.0),
          ),
        ),
        Positioned(
          right: 0.0,
          bottom: 0.0,
          child: RoundedIconButton(
            onPressed: () async {
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                firebaseProvider.updateUserProfilePhoto(
                    pickedFile.path, _scaffoldKey);
              }
            },
            iconData: Icons.edit,
            iconSize: 18,
          ),
        ),
      ],
    );
  }
}
