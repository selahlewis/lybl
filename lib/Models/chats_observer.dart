import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lybl_mobile/Models/chat_with_user.dart';
import 'package:lybl_mobile/data/entity/chat.dart';
import 'package:lybl_mobile/data/remote/firebase_database_source.dart';

class ChatsObserver {
  final FirebaseDatabaseSource _databaseSource = FirebaseDatabaseSource();
  List<ChatWithUser> chatsList = [];
  List<StreamSubscription<DocumentSnapshot>> subscriptionList = [];

  ChatsObserver(this.chatsList);

  void startObservers(Function onChatUpdated) {
    chatsList.forEach((element) {
      StreamSubscription<DocumentSnapshot> chatSubscription =
          _databaseSource.observeChat(element.chat.id).listen((event) {
        Chat updatedChat = Chat.fromSnapshot(event);

        if (updatedChat.lastMessage == null ||
            element.chat.lastMessage == null ||
            (updatedChat.lastMessage.epochTimeMs !=
                element.chat.lastMessage.epochTimeMs)) {
          element.chat = updatedChat;
          onChatUpdated();
        }
      });

      subscriptionList.add(chatSubscription);
    });
  }

  void removeObservers() async {
    for (var i = 0; i < subscriptionList.length; i++) {
      await subscriptionList[i].cancel();
      subscriptionList.removeAt(i);
    }

    subscriptionList = [];
    chatsList = [];
  }
}
