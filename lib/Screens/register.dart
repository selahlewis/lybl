import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/Models/User2.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /* Do something here if you want */
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorCodes.white,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(
                      flex: 1,
                    ),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 300, height: 300),
                      child: Image.asset('assets/images/tempLoginImage.PNG'),
                    ),
                    Text(
                      'Welcome',
                      style: TextStyle(
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.bold,
                          color: ColorCodes.mainColorDark,
                          fontSize: 45),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(
                          flex: 10,
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorCodes.mainColorDark),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorCodes.mainColorLight),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorCodes.mainColorLight),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorCodes.mainColorLight),
                        ),
                        Spacer(
                          flex: 10,
                        ),
                      ],
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 350, height: 70),
                      child: Card(
                        elevation: 3,
                        shape: StadiumBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(5),
                            ),
                            style: TextStyle(
                                fontFamily: "Avenir",
                                color: ColorCodes.mainColorDark,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
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
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
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
                            controller: passwordConfirmController,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              prefixIcon: Icon(Icons.lock),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(5),
                            ),
                            style: TextStyle(
                                fontFamily: "Avenir",
                                color: ColorCodes.mainColorDark,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 4,
                    ),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 300, height: 60),
                      child: ElevatedButton(
                        onPressed: () {
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();
                          String passwordConfirm =
                              passwordConfirmController.text.trim();

                          if (!(EmailValidator.validate(email))) {
                            emailController.clear();
                            _showMyDialog("Email is not in the correct format");
                            return;
                          }

                          if (password.length < 6) {
                            passwordController.clear();
                            passwordConfirmController.clear();
                            _showMyDialog(
                                "Password needs to be longer than 6 characters");
                            return;
                          }

                          if (password != passwordConfirm) {
                            passwordConfirmController.clear();
                            _showMyDialog(
                                "Password and Password confirm does not match");
                            return;
                          }

                          User2 user = User2(
                              email: emailController.text.trim(),
                              birthday: DateTime.now(),
                              authTokenExpirationDate: DateTime.now());
                          user.password = passwordController.text.trim();

                          Navigator.pushNamed(context, RouteNames.REGISTER1,
                              arguments: user);
                        },
                        child: Icon(Icons.navigate_next),
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: ColorCodes.mainColorLight,
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 4,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(String error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorCodes.mainColorLight,
          title: Text(
            error,
            style: TextStyle(
                fontFamily: "Avenir", color: ColorCodes.white, fontSize: 18),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(
                    fontFamily: "Avenir",
                    color: ColorCodes.white,
                    fontSize: 15),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
