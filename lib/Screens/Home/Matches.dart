import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lybl_mobile/Services/HttpServices/Endpoints.dart';

class Matches extends StatefulWidget {
  const Matches();

  @override
  State<StatefulWidget> createState() => MatcheState();
}

class MatcheState extends State<Matches> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    GetAllUsers();
    return Stack(
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [Text('Jessica'), Text('some more text')],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

Future<void> GetAllUsers() async {
  Response response = await get(Endpoints.getAllProfiles());
  print(response.statusCode);
  print(response.body);
  switch (response.statusCode) {
    case 200:
      print(response.body);
      break;
  }
}
