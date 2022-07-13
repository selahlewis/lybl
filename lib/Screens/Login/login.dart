import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lybl_mobile/Helpers/MagicStrings.dart';

import 'package:lybl_mobile/Screens/Widgets/input_dialog.dart';
import 'package:lybl_mobile/Screens/login/logic.dart';

import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login();
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Container buttonContent = Container();
  String pureLogin = "Welcome";
  String postRegisterLogin = "Account Created";

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    buttonContent = Container(
      child: Text(
        'Sign In',
        style: TextStyle(
            fontFamily: "Avenir", color: ColorCodes.white, fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String welcomeText;

    return WillPopScope(
      onWillPop: () async {
        /* Do something here if you want */
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorCodes.white,
        body: Consumer<LoginLogic>(
          builder: (context, logic, child) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Center(
                      child: Form(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Spacer(
                            flex: 5,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                                width: 300, height: 300),
                            child:
                                Image.asset('assets/images/tempLoginImage.PNG'),
                          ),
                          Text(
                            pureLogin,
                            style: TextStyle(
                                fontFamily: "Avenir",
                                fontWeight: FontWeight.bold,
                                color: ColorCodes.mainColorDark,
                                fontSize: 40),
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints.tightFor(width: 350, height: 60),
                            child: Card(
                              elevation: 3,
                              shape: StadiumBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    prefixIcon: Icon(Icons.email),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(5),
                                  ),
                                  style: TextStyle(
                                      fontFamily: "Avenir",
                                      color: ColorCodes.mainColorDark,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints.tightFor(width: 350, height: 70),
                            child: Card(
                              elevation: 3,
                              shape: StadiumBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    prefixIcon: Icon(Icons.lock),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.all(5),
                                  ),
                                  style: TextStyle(
                                      fontFamily: "Avenir",
                                      color: ColorCodes.mainColorDark,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          ConstrainedBox(
                            constraints:
                                BoxConstraints.tightFor(width: 300, height: 50),
                            child: ElevatedButton(
                              onPressed: () => logic.login(
                                  usernameController.text.trim(),
                                  passwordController.text.trim(),
                                  context),
                              child: buttonContent,
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: ColorCodes.mainColorLight,
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => InputDialog(
                                    onSavePressed: (value) =>
                                        resetPassword(value.trim()),
                                    labelText:
                                        'Enter email address to reset password',
                                  ),
                                );
                              },
                              child: Text("Forgot password?")),
                          TextButton(
                              onPressed: () {
                                Navigator.popAndPushNamed(
                                    context, RouteNames.REGISTER);
                              },
                              child: Text("Signup?")),
                        ]),
                  )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void resetPassword(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("link has been sent to your email for password reset")));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message.toString()),
      ));
    });
  }
}
