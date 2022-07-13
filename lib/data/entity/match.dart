import 'package:cloud_firestore/cloud_firestore.dart';

class Match1 {
  String id = '';

  Match1(this.id);

  Match1.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id};
  }
}
