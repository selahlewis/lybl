import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lybl_mobile/Lybl/models/lesson.dart';
import 'package:lybl_mobile/Lybl/ui/awards.dart';
import 'package:lybl_mobile/Lybl/ui/category_screen.dart';
import 'package:lybl_mobile/Lybl/ui/continue_courses.dart';
import 'package:lybl_mobile/Models/Questions.dart';
import 'package:lybl_mobile/Screens/Account/dating_attributes.dart';
import 'package:lybl_mobile/Screens/Account/profile_details.dart';
import 'package:lybl_mobile/Screens/Home/home2.dart';
import 'package:lybl_mobile/Screens/Home/recent_courses.dart';
import 'package:lybl_mobile/Screens/Profile/Profile.dart';
import 'package:lybl_mobile/Screens/Profile/Upload/UploadUI.dart';
import 'package:lybl_mobile/Screens/Questions/MultiSelect/MultiSelect5.dart';
import 'package:lybl_mobile/Screens/Questions/MultiSelect/MultiSelectLogic.dart';
import 'package:lybl_mobile/Screens/Questions/MultiSelect/MultiSelectQuestion.dart';
import 'package:lybl_mobile/Screens/Questions/MultipleChoice/MultipleChoiceQuestion.dart';
import 'package:lybl_mobile/Screens/Questions/Scale/ScaleLogic.dart';
import 'package:lybl_mobile/Screens/Questions/Scale/ScaleQuestions.dart';
import 'package:lybl_mobile/Screens/chat_screen.dart';
import 'package:lybl_mobile/Screens/chats_screen.dart';
import 'package:lybl_mobile/Screens/matched_screen.dart';
import 'package:lybl_mobile/Screens/profile_screen.dart';
import 'package:lybl_mobile/Screens/register_sub_screens/add_photo_screen.dart';
import 'package:lybl_mobile/Screens/top_navigation_screen.dart';
import 'package:lybl_mobile/data/entity/app_user.dart';
import 'package:lybl_mobile/data/provider/user_provider.dart';
import 'package:lybl_mobile/screens/register.dart';
import 'package:lybl_mobile/screens/welcome.dart';
import 'Screens/Home/home.dart';
import 'Screens/Profile/Upload/UploadLogic.dart';
import 'Screens/Profile/logic.dart';
import 'Screens/Questions/MultipleChoice/MultipleChoiceLogic.dart';
import 'Services/QuestionService.dart';
import 'Screens/login/logic.dart';
import 'Screens/login/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Helpers/MagicStrings.dart';
import 'Models/User2.dart';
import 'screens/Register3/logic.dart';
import 'screens/register2.dart';
import 'screens/Register3/register3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBUEOM-7qCU912bxsYr781Tqx1Q-vhelfQ",
      appId: "1:873685717403:android:2de5c624c6c39080f3513e",
      messagingSenderId: "XXX",
      projectId: "lybl-a7f51",
      storageBucket: "lybl-a7f51.appspot.com",
    ),
  );

  runApp(ProviderSetup(pref));
}

class ProviderSetup extends StatefulWidget {
  final SharedPreferences pref;
  ProviderSetup(this.pref);
  @override
  State<StatefulWidget> createState() => ProviderSetupState();
}

class ProviderSetupState extends State<ProviderSetup> {
  bool isNew = false, isLoggedIn = false;
  User2 user;
  AppUser appUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    var u = widget.pref.getString(SharedPrefNames.USER);
    if (u == null) return;
    User2 user2 = userFromJson(u == null ? '' : u);
    print("************checking login************");
    print(user2.status);
    if (user2.authToken.isNotEmpty) {
      if (user2.status == 'new')
        isNew = true;
      else
        isLoggedIn = true;
    } else {
      if (appUser.id == null) {
        Navigator.popAndPushNamed(context, RouteNames.LOGIN);
      }
    }
  }

  void getUser() async {
    appUser = await Provider.of<UserProvider>(context, listen: false).user;
    if (appUser.id == null) {
      Navigator.popAndPushNamed(context, RouteNames.LOGIN);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider<RegisterLogic>(create: (_) => RegisterLogic()),
        ChangeNotifierProvider<LoginLogic>(create: (_) => LoginLogic()),
        ChangeNotifierProvider<MultipleChoiceLogic>(
            create: (_) => MultipleChoiceLogic()),
        ChangeNotifierProvider<ScaleLogic>(create: (_) => ScaleLogic()),
        ChangeNotifierProvider<MultiSelectLogic>(
            create: (_) => MultiSelectLogic()),
        ChangeNotifierProvider<ProfileLogic>(
            create: (_) => ProfileLogic(widget.pref)),
        ChangeNotifierProvider<UploadLogic>(
            create: (_) => UploadLogic(widget.pref)),
        Provider<QuestionsService>(
          create: (_) => QuestionsService(),
          lazy: false,
        ),
        Provider<SharedPreferences>(
          create: (_) => widget.pref,
          lazy: false,
        )
      ],
      child: MaterialApp(
        home: SafeArea(
            child: isNew
                ? Login()
                : isLoggedIn
                    ? Home()
                    : Welcome()),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case RouteNames.REGISTER:
              return PageTransition(
                  child: Register(),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 100));
            case RouteNames.REGISTER1:
              user = settings.arguments as User2;
              return PageTransition(
                  child: Register2(user),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 100));
            case RouteNames.REGISTER2:
              user = settings.arguments as User2;
              return PageTransition(
                  child: AddPhotoScreen(
                    onPhotoChanged: (p0) => user.profile_image_main = p0,
                  ),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 100));
            case RouteNames.REGISTER3:
              return PageTransition(
                  child: Register3(user),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 100));
            case RouteNames.LOGIN:
              return PageTransition(
                  child: Login(),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 100));
            case RouteNames.MultipleChoiceQuestions:
              Question question = settings.arguments as Question;
              return PageTransition(
                  child: MultipleChoiceQuestion(question),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 100));
            case RouteNames.ScaleQuestions:
              Question question = settings.arguments as Question;
              return PageTransition(
                  child: ScaleQuestion(question),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 100));
            case RouteNames.MultiSelect2:
              Question question = settings.arguments as Question;
              return PageTransition(
                  child: MultiSelectQuestion(question),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 100));
            case RouteNames.MultiSelect5:
              Question question = settings.arguments as Question;
              return PageTransition(
                  child: MultiSelectQuestion5(question),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 100));
            case RouteNames.HOME:
              return PageTransition(
                  child: Home(),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 100));
            case RouteNames.Account:
              return PageTransition(
                  child: ProfileScreen(),
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 100));
            case RouteNames.Lessons:
              return PageTransition(
                  child: Lessons(),
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 100));
            case RouteNames.Recent:
              return PageTransition(
                  child: RecentLessons(),
                  type: PageTransitionType.leftToRight,
                  duration: Duration(milliseconds: 100));
            case RouteNames.Categories:
              return PageTransition(
                  child: CategoryScreen(),
                  type: PageTransitionType.leftToRight,
                  duration: Duration(milliseconds: 100));
            case RouteNames.Attributes:
              return PageTransition(
                  child: DatingAttributes(),
                  type: PageTransitionType.rightToLeft,
                  duration: Duration(milliseconds: 100));
            case RouteNames.Awards:
              return PageTransition(
                  child: AwardsScreen(),
                  type: PageTransitionType.rightToLeftWithFade,
                  duration: Duration(milliseconds: 100));
            case RouteNames.UPLOAD:
              return PageTransition(
                  child: Upload(),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 500));
          }
          return null;
        },
        theme: ThemeData(
          primaryColor: ColorCodes.mainColorLight,
          bottomAppBarColor: ColorCodes.mainColorDark,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                ColorCodes.mainColorLight,
              ), //button color
              foregroundColor: MaterialStateProperty.all<Color>(
                Color(0xffffffff),
              ), //text (and icon)
            ),
          ),
        ),
        routes: {
          TopNavigationScreen.id: (context) => TopNavigationScreen(),
          MatchedScreen.id: (context) => MatchedScreen(
                myProfilePhotoPath: (ModalRoute.of(context).settings.arguments
                    as Map)['my_profile_photo_path'],
                myUserId: (ModalRoute.of(context).settings.arguments
                    as Map)['my_user_id'],
                otherUserProfilePhotoPath: (ModalRoute.of(context)
                    .settings
                    .arguments as Map)['other_user_profile_photo_path'],
                otherUserId: (ModalRoute.of(context).settings.arguments
                    as Map)['other_user_id'],
              ),
          ChatScreen.id: (context) => ChatScreen(
                chatId: (ModalRoute.of(context).settings.arguments
                    as Map)['chat_id'],
                otherUserId: (ModalRoute.of(context).settings.arguments
                    as Map)['other_user_id'],
                myUserId: (ModalRoute.of(context).settings.arguments
                    as Map)['user_id'],
              ),
        },
      ),
    );
  }
}
