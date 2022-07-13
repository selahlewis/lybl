import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/Screens/Profile/Upload/UploadLogic.dart';
import '/Models/Profile.dart';
import '/Services/HttpServices/Endpoints.dart';
import '../../Models/User2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'Upload/AppImages.dart';

class ProfileLogic extends ChangeNotifier {
  Widget img = AppImages(
    '',
    image: Image.asset('profile.png'),
  );
  List<Widget> addImages = [];

  User2 user;
  String name = '';
  Profile profile = Profile();
  TextEditingController bio = new TextEditingController();
  TextEditingController occupation = new TextEditingController();
  TextEditingController education = new TextEditingController();
  TextEditingController pronoun = new TextEditingController();

  ProfileLogic(SharedPreferences pref) {
    user =
        User2.fromJson(json.decode(pref.getString(SharedPrefNames.USER) ?? ''));
    getProfile(user);
  }

  viewImage(String url) {
    img = AppImages(url, image: Image.asset('profile.png'));
    notifyListeners();
    return img;
  }

  viewImages(Profile profile) {
    List<Widget> ig = [];

    addImages = ig;

    notifyListeners();
  }

  lineText(text, weight) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: weight,
        ),
      ),
    );
  }

  save(BuildContext context) async {
    profile.job = occupation.text;
    profile.educationLevel = education.text;
    user.perferredPronoun = pronoun.text;
    //await updateProfile(context, profile);
    await updateUser(context);
    notifyListeners();
  }

  getProfile(User2 user) async {
    // get user

    Response response = await get(Endpoints.getProfile(user.id));

    if (response.statusCode == 200) {
      profile = profileFromJson(response.body);
      bio.text = profile.bioText;
      pronoun.text = user.perferredPronoun;
      education.text = profile.educationLevel;
      occupation.text = profile.job;

      viewImage(profile.profileImageMain);
      viewImages(profile);
      notifyListeners();
      return profile;
    }
  }

  updateProfile(BuildContext context, Profile profileData) async {
    Response response =
        await post(Endpoints.updateProfile, body: profileToJson(profileData));

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Updated"),
        duration: Duration(milliseconds: 800),
      ));
    }
  }

  updateUser(BuildContext context) async {
    String data =
        context.read<SharedPreferences>().getString(SharedPrefNames.USER);
    String token =
        context.read<SharedPreferences>().getString(SharedPrefNames.TOKEN);
    User2 user = User2.fromJson(json.decode(data ?? ''));
    print(Endpoints.updateUser);
    print(json.encode(user.toJson()));
    print(token ?? '');
    Response response = await post(Endpoints.updateUser,
        body: userToJson(user), headers: {'Authorization': token ?? ''});

    print(response.body);
    print(response.statusCode);
    print(Endpoints.updateUser);
    if (response.statusCode == 401) {
      context.read<SharedPreferences>().clear();
      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.LOGIN, (route) => false);
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
