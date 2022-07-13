import 'dart:convert';

import 'package:flutter/material.dart';
import '../../Helpers/MagicStrings.dart';
import 'package:lybl_mobile/Models/User2.dart';

import 'package:provider/provider.dart';

import 'logic.dart';

class Register3 extends StatefulWidget {
  final User2 user;
  Register3(this.user);

  @override
  _RegisterState3 createState() => _RegisterState3();
}

class _RegisterState3 extends State<Register3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorCodes.white,
        body: Consumer<RegisterLogic>(builder: (context, logic, child) {
          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              Spacer(
                flex: 1,
              ),
              FittedBox(
                fit: BoxFit.fill,
                child: Image.asset('assets/images/tempLoginImage.PNG'),
              ),
              Text(
                'Last Step!',
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
                        color: ColorCodes.mainColorDark),
                  ),
                  Spacer(
                    flex: 10,
                  ),
                ],
              ),
              Spacer(
                flex: 7,
              ),
              Text(
                "Birthday",
                style: TextStyle(fontSize: 25, color: ColorCodes.mainColorDark),
              ),
              Spacer(
                flex: 1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "${logic.selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(
                        fontSize: 30, color: ColorCodes.mainColorDark),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                      onPressed: () =>
                          logic.selectDate(context), // Refer step 3
                      child: Text(
                        'Select Date',
                        style: TextStyle(
                            fontFamily: "Avenir",
                            color: ColorCodes.white,
                            fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: ColorCodes.mainColorLight,
                      )),
                ],
              ),
              Spacer(
                flex: 7,
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 300, height: 60),
                child: ElevatedButton(
                  onPressed: () => logic.registerApiCall(widget.user, context),
                  child: !logic.isLoading
                      ? Container(
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontFamily: "Avenir",
                                color: ColorCodes.white,
                                fontSize: 20),
                          ),
                        )
                      : Container(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                          ColorCodes.white,
                        ))),
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
          );
        }));
  }

  // Future<GenericResponseObjectNullData> registerApiCall(
  //     String email,
  //     String password,
  //     String fName,
  //     String lName,
  //     String nName,
  //     DateTime birthday) async {
  //   setState(() {
  //     // buttonContent = Container(
  //     //     child: CircularProgressIndicator(
  //     //         valueColor: AlwaysStoppedAnimation<Color>(
  //     //   CustomColors.white,
  //     // )));
  //   });
  //
  //   var url = Uri.parse(GLOBALVARS().API_ENDPOINT + '/user/register');
  //
  //   //encode Map to JSON
  //   var body = json.encode(registerRequest(
  //       apiKey: GLOBALVARS().API_KEY,
  //       email: email,
  //       password: password,
  //       firebaseId: "tempFirebaseId",
  //       firstName: fName,
  //       lastName: lName,
  //       nickName: nName,
  //       birthday: birthday.millisecondsSinceEpoch));
  //
  //   print(body);
  //
  //   var response = await http.post(url,
  //       headers: {"Content-Type": "application/json"}, body: body);
  //
  //   print("${response.statusCode}");
  //   print("${response.body}");
  //
  //   if (response.statusCode == 200) {
  //     print("response status 200");
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //
  //     try {
  //       GenericResponseObjectNullData genericResponse =
  //           GenericResponseObjectNullData.fromJson(jsonDecode(response.body));
  //       print("after Generic Response Builder");
  //
  //       if (genericResponse.statusCode == 200) {
  //         print("genericResponse status 200");
  //         setState(() {
  //           // logic.buttonContent = Container(
  //           //   child: Text(
  //           //     'Register',
  //           //     style: TextStyle(
  //           //         fontFamily: "Avenir",
  //           //         color: CustomColors.white,
  //           //         fontSize: 20),
  //           //   ),
  //           // );
  //         });
  //
  //         return genericResponse;
  //       } else {
  //         if (genericResponse.statusCode == 409001) {}
  //         throw Exception('Failed to load');
  //       }
  //     } catch (e) {
  //       print(e);
  //       throw Exception();
  //     }
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load');
  //   }
  // }

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
