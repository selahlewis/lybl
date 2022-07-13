import 'package:flutter/material.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import '../Models/User2.dart';

import 'login/login.dart';

class Register2 extends StatefulWidget {
  final User2 user;
  Register2(this.user);

  @override
  _RegisterState2 createState() => _RegisterState2();
}

class _RegisterState2 extends State<Register2> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final nickNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            controller: firstNameController,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              prefixIcon: Icon(Icons.person),
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
                            controller: lastNameController,
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              prefixIcon: Icon(Icons.person),
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
                            controller: nickNameController,
                            decoration: InputDecoration(
                              hintText: 'Nick Name (If any)',
                              prefixIcon: Icon(Icons.person),
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
                          User2 user = widget.user;
                          user.firstName = firstNameController.text;
                          user.nickName = nickNameController.text;
                          user.lastName = lastNameController.text;

                          if (user.firstName.isEmpty) {
                            _showMyDialog("Please enter a First Name");
                            return;
                          }
                          if (user.lastName.isEmpty) {
                            _showMyDialog("Please enter a Last Name");
                            return;
                          }
                          if (user.nickName.isEmpty) {
                            user.nickName = "none";
                          }
                          Navigator.pushNamed(context, RouteNames.REGISTER2,
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
        ));
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
