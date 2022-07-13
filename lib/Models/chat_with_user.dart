import 'package:lybl_mobile/data/entity/app_user.dart';
import 'package:lybl_mobile/data/entity/chat.dart';

class ChatWithUser {
  Chat chat;
  AppUser user;

  ChatWithUser(this.chat, this.user);
}
