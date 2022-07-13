import 'package:firebase_auth/firebase_auth.dart';
import 'package:lybl_mobile/data/remote/response1.dart';

class FirebaseAuthSource {
  FirebaseAuth instance = FirebaseAuth.instance;

  Future<Response1<UserCredential>> signIn(
      String email, String password) async {
    try {
      UserCredential userCredential = await instance.signInWithEmailAndPassword(
          email: email, password: password);
      return Response1.success(userCredential);
    } catch (e) {
      return Response1.error(
          ((e as FirebaseException).message ?? e.toString()));
    }
  }

  Future<Response1<UserCredential>> register(
      String email, String password) async {
    try {
      UserCredential userCredential = await instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return Response1.success(userCredential);
    } catch (e) {
      return Response1.error(
          ((e as FirebaseException).message ?? e.toString()));
    }
  }
}
