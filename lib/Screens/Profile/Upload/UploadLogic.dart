import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lybl_mobile/Environment/Globals.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/Models/Profile.dart';
import 'package:lybl_mobile/Models/User2.dart';
import 'package:lybl_mobile/Screens/Profile/logic.dart';
import 'package:lybl_mobile/Services/HttpServices/Endpoints.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppImages.dart';

class UploadLogic extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  Profile profile = Profile();
  List<Widget> addImages = [];
  User2 user;
  FirebaseStorage storage = FirebaseStorage.instance;
  Widget img = Image.asset('profile.png');
  UploadLogic(SharedPreferences pref) {
    init(pref);
  }

  init(SharedPreferences pref) async {
    user =
        User2.fromJson(json.decode(pref.getString(SharedPrefNames.USER) ?? ''));
    profile = await ProfileLogic(pref).getProfile(user);
    viewImage(profile.profileImageMain);
    viewImages(profile);
  }

  uploadMain(BuildContext context) async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);

    File file = File(image?.path);
    try {
      TaskSnapshot uploaded =
          await storage.ref("profile/${image?.name}").putFile(file);

      profile.profileImageMain = await uploaded.ref.getDownloadURL();
      context.read<ProfileLogic>().updateProfile(context, profile);
      viewImage(profile.profileImageMain);
      notifyListeners();
    } on FirebaseException {}
  }

  viewImage(String url) {
    print("viewImage $url");
    img = image(url);
    notifyListeners();
    return img;
  }

  viewImages(Profile profile) {
    List<Widget> ig = [];

    addImages = ig;

    notifyListeners();
  }

  Widget image(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        width: 130,
        height: 130,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(80))),
        child: Image.network(url, fit: BoxFit.cover),
      ),
    );
  }

  uploadImages(BuildContext context) async {
    final List<XFile> images = await _picker.pickMultiImage();

    if (images == null) return;

    for (int i = 0; i < 4; i++) {
      File file = File(images[i].path);

      switch (i) {
        case 0:
          print('profile0/${images[i].name}');
          TaskSnapshot uploaded =
              await storage.ref("profile/${images[i].name}").putFile(file);
          profile.profileImage1 = await uploaded.ref.getDownloadURL();
          break;
        case 1:
          TaskSnapshot uploaded =
              await storage.ref("profile/${images[i].name}").putFile(file);
          profile.profileImage2 = await uploaded.ref.getDownloadURL();
          break;
        case 2:
          TaskSnapshot uploaded =
              await storage.ref("profile/${images[i].name}").putFile(file);
          profile.profileImage3 = await uploaded.ref.getDownloadURL();
          break;
        case 3:
          TaskSnapshot uploaded =
              await storage.ref("profile/${images[i].name}").putFile(file);
          profile.profileImage4 = await uploaded.ref.getDownloadURL();
          break;
      }
    }

    viewImages(profile);
    context.read<ProfileLogic>().updateProfile(context, profile);
    notifyListeners();
  }
}
