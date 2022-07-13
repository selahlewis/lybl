import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lybl_mobile/data/remote/response1.dart';

class FirebaseStorageSource {
  FirebaseStorage instance = FirebaseStorage.instance;

  Future<Response1<String>> uploadUserProfilePhoto(
      String filePath, String userId) async {
    String userPhotoPath = "user_photos/$userId/profile_photo";

    try {
      await instance.ref(userPhotoPath).putFile(File(filePath));
      String downloadUrl = await instance.ref(userPhotoPath).getDownloadURL();
      return Response1.success(downloadUrl);
    } catch (e) {
      return Response1.error(
          ((e as FirebaseException).message ?? e.toString()));
    }
  }
}
