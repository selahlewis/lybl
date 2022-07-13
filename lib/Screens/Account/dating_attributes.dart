import 'dart:convert';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/Lybl/utils/themes.dart';
import 'package:lybl_mobile/Models/User2.dart';
import 'package:lybl_mobile/Models/dating_attributes.dart';
import 'package:lybl_mobile/Models/romantic_gestures.dart';
import 'package:lybl_mobile/Screens/Widgets/input_dialog.dart';
import 'package:lybl_mobile/Screens/Widgets/rounded_icon_button.dart';
import 'package:lybl_mobile/Services/HttpServices/Endpoints.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/constants.dart';
import '../Home/home.dart';
import '../LevelUp/level_up_home.dart';

class DatingAttributes extends StatefulWidget {
  @override
  State<DatingAttributes> createState() => DatingAttributesState();
}

class DatingAttributesState extends State<DatingAttributes> {
  static final String path = "lib/src/pages/profile/profile10.dart";
  List attributesList = [];
  RangeValues _currentRangeValues;
  final TextEditingController myController = TextEditingController();
  double _FinancialSliderValue;
  double _InteliSliderValue;
  double _HumorSliderValue;
  double _ConfidenceSliderValue;

  bool ready = false;

  List<Romantic> romanticGesturesList = [];

  var gesture1 = ' ';
  var gesture2 = ' ';
  var gesture3 = ' ';
  var gesture4 = ' ';
  var gesture5 = ' ';

  String matchPref1 = ' ';

  String matchPref2 = ' ';

  String _chosenValue;
  String matchPrefValue1;
  String matchPrefValue2;
  String gestureValue1;
  String gestureValue2;
  String gestureValue3;
  String gestureValue4;
  String gestureValue5;

  List matchPrefList;

  List romanticAttList;

  var countryValue;

  var stateValue;

  var cityValue;

  User2 user;

  var dropdownValue;

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
          backgroundColor: kAccentColor,
          elevation: 0,
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        drawer: Container(
          width: 250,
          child: Drawer(
            child: ListView(
              children: [
                DrawerHeader(child: Text('Menu')),
                ListTile(
                  title: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.personal_video),
                      ),
                      Text('My Profile')
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.Account);
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.arrow_circle_up_rounded),
                      ),
                      Text('Level Up')
                    ],
                  ),
                  onTap: () {
                    //return LevelHome.route();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LevelHome()));
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.home),
                      ),
                      Text('Home')
                    ],
                  ),
                  onTap: () {
                    //return LevelHome.route();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Home()));
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.settings),
                      ),
                      Text('Settings')
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.Attributes);
                  },
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Text(
                        'My Dating Attributes',
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.8),
                      child: MaterialButton(
                        minWidth: 0,
                        elevation: 0.5,
                        color: Colors.white,
                        child: Text('Set your match preferences'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        onPressed: () {},
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
                            Text('Match with gender',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 50,
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>['F', 'M', 'O']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text('Age Preference ' +
                        _currentRangeValues.start.round().toString() +
                        '-' +
                        _currentRangeValues.end.round().toString()),
                    RangeSlider(
                      values: _currentRangeValues,
                      min: 18,
                      max: 99,
                      divisions: 81,
                      labels: RangeLabels(
                        _currentRangeValues.start.round().toString(),
                        _currentRangeValues.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    CSCPicker(
                      ///Enable disable state dropdown [OPTIONAL PARAMETER]
                      showStates: true,
                      defaultCountry: DefaultCountry.United_States,
                      disableCountry: true,

                      /// Enable disable city drop down [OPTIONAL PARAMETER]
                      showCities: true,

                      ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                      flagState: CountryFlag.DISABLE,

                      ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),

                      ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                      disabledDropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.shade300,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),

                      ///placeholders for dropdown search field
                      countrySearchPlaceholder: "Country",
                      stateSearchPlaceholder: "State",
                      citySearchPlaceholder: "City",

                      ///labels for dropdown
                      countryDropdownLabel: "*Country",
                      stateDropdownLabel: attributesList[0]['address_state'],
                      cityDropdownLabel: attributesList[0]['address_city'],

                      ///Default Country
                      //defaultCountry: DefaultCountry.India,

                      ///Disable country dropdown (Note: use it with default country)
                      //disableCountry: true,

                      ///selected item style [OPTIONAL PARAMETER]
                      selectedItemStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),

                      ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                      dropdownHeadingStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),

                      ///DropdownDialog Item style [OPTIONAL PARAMETER]
                      dropdownItemStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),

                      ///Dialog box radius [OPTIONAL PARAMETER]
                      dropdownDialogRadius: 10.0,

                      ///Search bar radius [OPTIONAL PARAMETER]
                      searchBarRadius: 10.0,

                      ///triggers once country selected in dropdown
                      onCountryChanged: (value) {
                        setState(() {
                          ///store value in country variable
                          countryValue = value;
                        });
                      },

                      ///triggers once state selected in dropdown
                      onStateChanged: (value) {
                        setState(() {
                          ///store value in state variable
                          stateValue = value;
                        });
                      },

                      ///triggers once city selected in dropdown
                      onCityChanged: (value) {
                        setState(() {
                          ///store value in city variable
                          cityValue = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
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
                        DropdownButton<String>(
                            focusColor: Colors.white,
                            value: matchPrefValue1,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.black,
                            items: matchPrefList
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              matchPref1.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                matchPrefValue1 = value;
                              });
                            }),
                      ],
                    ),
                    const SizedBox(height: 10.0),
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
                        DropdownButton<String>(
                            focusColor: Colors.white,
                            value: matchPrefValue2,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.black,
                            items: matchPrefList
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              matchPref2.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                matchPrefValue2 = value;
                              });
                            }),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Intimacy Preference',
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                        SizedBox(height: 5),
                        DropdownButton<String>(
                          focusColor: Colors.white,
                          value: _chosenValue,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: matchPrefList
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            matchPref1.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              _chosenValue = value;
                            });
                          },
                          alignment: AlignmentDirectional.centerStart,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0, width: 20),
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
                        DropdownButton<String>(
                            focusColor: Colors.white,
                            value: gestureValue1,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.black,
                            items: romanticAttList
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              gesture1.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                gestureValue1 = value;
                              });
                            },
                            isExpanded: true),
                      ],
                    ),
                    const SizedBox(height: 10.0),
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
                        DropdownButton<String>(
                            focusColor: Colors.white,
                            value: gestureValue2,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.black,
                            items: romanticAttList
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              gesture2,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                gestureValue2 = value;
                              });
                            },
                            isExpanded: true),
                      ],
                    ),
                    const SizedBox(height: 10.0),
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
                        DropdownButton<String>(
                            focusColor: Colors.white,
                            value: gestureValue3,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.black,
                            items: romanticAttList
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              gesture3,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                gestureValue3 = value;
                              });
                            },
                            isExpanded: true),
                      ],
                    ),
                    const SizedBox(height: 10.0),
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
                        DropdownButton<String>(
                            focusColor: Colors.white,
                            value: gestureValue4,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.black,
                            items: romanticAttList
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              gesture4,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                gestureValue4 = value;
                              });
                            },
                            isExpanded: true),
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
                        DropdownButton<String>(
                            focusColor: Colors.white,
                            value: gestureValue5,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.black,
                            items: romanticAttList
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              gesture5,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                gestureValue5 = value;
                              });
                            },
                            isExpanded: true),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text('Financial Stability Level ' +
                        _FinancialSliderValue.round().toString()),
                    Slider(
                      value: _FinancialSliderValue,
                      max: 10,
                      min: 1,
                      divisions: 10,
                      label: _FinancialSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _FinancialSliderValue = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Text('Intelligence Level ' +
                        _InteliSliderValue.round().toString()),
                    Slider(
                      value: _InteliSliderValue,
                      min: 1,
                      max: 10,
                      divisions: 10,
                      label: _InteliSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _InteliSliderValue = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Text('Humor Level ' + _HumorSliderValue.round().toString()),
                    Slider(
                      value: _HumorSliderValue,
                      max: 10,
                      min: 1,
                      divisions: 10,
                      label: _HumorSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _HumorSliderValue = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Text('Confidence Level ' +
                        _ConfidenceSliderValue.round().toString()),
                    Slider(
                      value: _ConfidenceSliderValue,
                      max: 10,
                      min: 1,
                      divisions: 10,
                      label: _ConfidenceSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _ConfidenceSliderValue = value;
                        });
                      },
                    ),
                    const SizedBox(height: 30.0),
                    MaterialButton(
                      child: Text("Save"),
                      color: Colors.pink,
                      onPressed: () async {
                        userDatingAttributes att = new userDatingAttributes();
                        // att.dating_attributes_id = 36;
                        att.user_id = user.id;
                        att.gender_looking = dropdownValue;
                        att.age_range_min = _currentRangeValues.start.toInt();
                        att.age_range_max = _currentRangeValues.end.toInt();
                        att.location_range_max_miles = 50;
                        att.address_line1 = '';
                        att.address_line2 = '';
                        att.address_city = cityValue;
                        att.address_state = stateValue;
                        att.match_preference1 = matchPrefValue1;
                        att.match_preference2 = matchPrefValue2;
                        att.intimacy_preference = 0;
                        att.romantic_gesture1 = gestureValue1;
                        att.romantic_gesture2 = gestureValue2;
                        att.romantic_gesture3 = gestureValue3;
                        att.romantic_gesture4 = gestureValue4;
                        att.romantic_gesture5 = gestureValue5;
                        att.financial_stability_index = _FinancialSliderValue;
                        att.intelligence_index = _InteliSliderValue;
                        att.humor_index = _HumorSliderValue;
                        att.confidence_index = _ConfidenceSliderValue;

                        Response response = await post(Endpoints.editAttributes,
                            body: datingToJson(att));
                        print(response.body);
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
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
            child: Text('Getting data....',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5)),
      );
    }
  }

  Future<void> getDatingAttributes(BuildContext context) async {
    getMatchPrefsList();
    getRomanticList();
    var data1 =
        context.read<SharedPreferences>().getString(SharedPrefNames.USER);
    user = User2.fromJson(json.decode(data1 ?? ''));
    Response response = await get(Endpoints.getDatingAttributes(user.id));
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
        _FinancialSliderValue = attributesList[0]['financial_stability_index'];
        _InteliSliderValue = attributesList[0]['intelligence_index'];
        _HumorSliderValue = attributesList[0]['humor_index'];
        _ConfidenceSliderValue = attributesList[0]['confidence_index'];
        _currentRangeValues = RangeValues(attributesList[0]['age_range_min'],
            attributesList[0]['age_range_max']);
        dropdownValue = attributesList[0]['gender_looking'];
      }
    });
  }

  getRomanceById(int gest_id) async {
    Response response = await get(Endpoints.getRomanceById(gest_id));
    var data = json.decode(response.body)['romantic_gestures'];
    // print(response.body);
    setState(() {
      gesture1 = data[0]['romantic_gesture_string'].toString();
      gestureValue1 = gesture1;
    });
  }

  getRomanceById2(int gest_id) async {
    Response response = await get(Endpoints.getRomanceById(gest_id));
    var data = json.decode(response.body)['romantic_gestures'];
    // print(response.body);
    setState(() {
      gesture2 = data[0]['romantic_gesture_string'].toString();
      gestureValue2 = gesture2;
    });
  }

  getRomanceById3(int gest_id) async {
    Response response = await get(Endpoints.getRomanceById(gest_id));
    var data = json.decode(response.body)['romantic_gestures'];
    // print(response.body);
    setState(() {
      gesture3 = data[0]['romantic_gesture_string'].toString();
      gestureValue3 = gesture3;
    });
  }

  getRomanceById4(int gest_id) async {
    Response response = await get(Endpoints.getRomanceById(gest_id));
    var data = json.decode(response.body)['romantic_gestures'];
    // print(response.body);
    setState(() {
      gesture4 = data[0]['romantic_gesture_string'].toString();
      gestureValue4 = gesture4;
    });
  }

  getRomanceById5(int gest_id) async {
    Response response = await get(Endpoints.getRomanceById(gest_id));
    var data = json.decode(response.body)['romantic_gestures'];
    // print(response.body);
    setState(() {
      gesture5 = data[0]['romantic_gesture_string'].toString();
      gestureValue5 = gesture5;
    });
  }

  getMatchPrefsById1(int id) async {
    Response response = await get(Endpoints.getMatchPrefsById(id));
    var data = json.decode(response.body)['Match_Prefs'];
    // print(response.body);
    setState(() {
      matchPref1 = data[0]['match_preference_string'].toString();
      matchPrefValue1 = matchPref1;
    });
  }

  getMatchPrefsById2(int id) async {
    Response response = await get(Endpoints.getMatchPrefsById(id));
    var data = json.decode(response.body)['Match_Prefs'];
    // print(response.body);
    setState(() {
      matchPref2 = data[0]['match_preference_string'].toString();
      matchPrefValue2 = matchPref2;
    });
  }

  getMatchPrefsList() async {
    Response response = await get(Endpoints.getAllMatchPrefs());
    var data = json.decode(response.body)['Match_Prefs'];
    print(response.request);
    setState(() {
      matchPrefList = data;
      print(matchPrefList[0]);
    });
  }

  getRomanticList() async {
    Response response = await get(Endpoints.getRomanticAttList());
    var data = json.decode(response.body)['romantic_gestures'];
    print(response.request);
    setState(() {
      romanticAttList = data;
    });
  }
}
