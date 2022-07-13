import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/Models/User2.dart';
import 'package:lybl_mobile/Models/romantic_gestures.dart';
import 'package:lybl_mobile/Screens/Widgets/input_dialog.dart';
import 'package:lybl_mobile/Screens/Widgets/rounded_icon_button.dart';
import 'package:lybl_mobile/Screens/explore_page.dart';
import 'package:lybl_mobile/Services/HttpServices/Endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDetails extends StatefulWidget {
  final int otherid;
  final String photourl;
  const ProfileDetails(this.otherid, this.photourl);
  @override
  State<ProfileDetails> createState() => ProfileDetailsState();
}

class ProfileDetailsState extends State<ProfileDetails> {
  List attributesList = [];
  RangeValues _currentRangeValues = const RangeValues(18, 99);
  final TextEditingController myController = TextEditingController();
  double _currentSliderValue = 4;

  bool ready = false;

  List<Romantic> romanticGesturesList = [];

  var gesture1 = ' ';
  var gesture2 = ' ';
  var gesture3 = ' ';
  var gesture4 = ' ';
  var gesture5 = ' ';

  String matchPref1 = ' ';

  String matchPref2 = ' ';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getDatingAttributes(context));
  }

  @override
  Widget build(BuildContext context) {
    if (ready) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: widget.photourl.isNotEmpty
                            ? Image.network(widget.photourl,
                                fit: BoxFit.fitWidth)
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Match with gender: ',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          attributesList[0]['gender_looking'],
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Divider(color: Colors.black),
                    Text('Age Preference ' +
                        _currentRangeValues.start.round().toString() +
                        '-' +
                        _currentRangeValues.end.round().toString()),
                    const SizedBox(height: 10.0),
                    Divider(color: Colors.black),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('City',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          attributesList[0]['address_city'],
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Divider(color: Colors.black),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('State',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          attributesList[0]['address_state'],
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Divider(color: Colors.black),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Match Preference 1',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          matchPref1,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Divider(color: Colors.black),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Match Preference 2',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          matchPref2.toString(),
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Divider(color: Colors.black),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Romantic Gesture 1',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          gesture1,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Divider(color: Colors.black),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Romantic Gesture 2',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          gesture2,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Divider(color: Colors.black),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Romantic Gesture 3',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          gesture3,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Divider(color: Colors.black),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Romantic Gesture 4',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          gesture4,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Romantic Gesture 5',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          gesture5,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Divider(color: Colors.black),
                    Text('Financial Stability Level ' +
                        attributesList[0]['financial_stability_index']
                            .toString()),
                    const SizedBox(height: 10.0),
                    Divider(color: Colors.black),
                    Text('Intelligence Level ' +
                        attributesList[0]['intelligence_index'].toString()),
                    const SizedBox(height: 10.0),
                    Divider(color: Colors.black),
                    const SizedBox(height: 10.0),
                    Text('Humor Level ' +
                        attributesList[0]['humor_index'].toString()),
                    const SizedBox(height: 10.0),
                    Divider(color: Colors.black),
                    const SizedBox(height: 10.0),
                    Text('Confidence Level ' +
                        attributesList[0]['confidence_index'].toString()),
                    const SizedBox(height: 10.0),
                    Divider(color: Colors.black),
                    Text(
                      "Interests",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 5.0),
                    Wrap(
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: [
                        ChoiceChip(
                          label: Text("Technology"),
                          onSelected: (val) {},
                          selected: true,
                        ),
                        ChoiceChip(
                          label: Text("Coding"),
                          onSelected: (val) {},
                          selected: true,
                        ),
                        ChoiceChip(
                          label: Text("Tutoring"),
                          onSelected: (val) {},
                          selected: false,
                        ),
                        ChoiceChip(
                          label: Text("Video making"),
                          onSelected: (val) {},
                          selected: false,
                        ),
                        ChoiceChip(
                          label: Text("Gaming"),
                          onSelected: (val) {},
                          selected: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      var size = MediaQuery.of(context).size;
      return Center(
        child: Container(
            width: size.width,
            height: size.height,
            color: Color(0xFFF2F2F2),
            child: Text('getting data....',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5)),
      );
    }
  }

  Future<void> getDatingAttributes(BuildContext context) async {
    Response response =
        await get(Endpoints.getDatingAttributes(widget.otherid));
    print(response.request);
    var data = json.decode(response.body)['Dating Attributes'];

    print(response.body);
    setState(() {
      attributesList = data;
      if (attributesList.isNotEmpty) {
        ready = true;
        getRomanceById(attributesList[0]['romantic_gesture1']);
        getRomanceById2(attributesList[0]['romantic_gesture2']);
        getRomanceById3(attributesList[0]['romantic_gesture3']);
        getRomanceById4(attributesList[0]['romantic_gesture4']);
        getRomanceById5(attributesList[0]['romantic_gesture5']);
        getMatchPrefsById1(attributesList[0]['match_preference1']);
        getMatchPrefsById2(attributesList[0]['match_preference2']);
      }
    });
  }

  getRomanceById(int gest_id) async {
    Response response = await get(Endpoints.getRomanceById(gest_id));
    var data = json.decode(response.body)['romantic_gestures'];
    // print(response.body);
    setState(() {
      gesture1 = data[0]['romantic_gesture_string'].toString();
    });
  }

  getRomanceById2(int gest_id) async {
    Response response = await get(Endpoints.getRomanceById(gest_id));
    var data = json.decode(response.body)['romantic_gestures'];
    // print(response.body);
    setState(() {
      gesture2 = data[0]['romantic_gesture_string'].toString();
    });
  }

  getRomanceById3(int gest_id) async {
    Response response = await get(Endpoints.getRomanceById(gest_id));
    var data = json.decode(response.body)['romantic_gestures'];
    // print(response.body);
    setState(() {
      gesture3 = data[0]['romantic_gesture_string'].toString();
    });
  }

  getRomanceById4(int gest_id) async {
    Response response = await get(Endpoints.getRomanceById(gest_id));
    var data = json.decode(response.body)['romantic_gestures'];
    // print(response.body);
    setState(() {
      gesture4 = data[0]['romantic_gesture_string'].toString();
    });
  }

  getRomanceById5(int gest_id) async {
    Response response = await get(Endpoints.getRomanceById(gest_id));
    var data = json.decode(response.body)['romantic_gestures'];
    // print(response.body);
    setState(() {
      gesture5 = data[0]['romantic_gesture_string'].toString();
    });
  }

  getMatchPrefsById1(int id) async {
    Response response = await get(Endpoints.getMatchPrefsById(id));
    var data = json.decode(response.body)['Match_Prefs'];
    // print(response.body);
    setState(() {
      matchPref1 = data[0]['match_preference_string'].toString();
    });
  }

  getMatchPrefsById2(int id) async {
    Response response = await get(Endpoints.getMatchPrefsById(id));
    var data = json.decode(response.body)['Match_Prefs'];
    // print(response.body);
    setState(() {
      matchPref2 = data[0]['match_preference_string'].toString();
    });
  }
}
