import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/Models/Questions.dart';
import 'package:lybl_mobile/Screens/Questions/MultiSelect/MultiSelectLogic.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../Services/QuestionService.dart';

class MultiSelectQuestion5 extends StatefulWidget {
  final Question question;
  MultiSelectQuestion5(this.question);

  @override
  State<StatefulWidget> createState() => MultiSelectQuestion5State();
}

class MultiSelectQuestion5State extends State<MultiSelectQuestion5> {
  List<bool> isChecked = [];
  List<String> selectons = [];

  checkBoxes(List<String> choices) {
    List<Widget> options = [];
    for (int i = 0; i < choices.length; i++) {
      isChecked.add(false);

      Widget choice = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .70,
            child: Text("${choices[i]}"),
          ),
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked[i],
            onChanged: (bool value) {
              setState(() {
                int length = selectons.length;

                if (value) {
                  if (length < 5) {
                    selectons.add(choices[i]);
                    isChecked[i] = value;
                  }
                } else {
                  int searchIndex = selectons.indexOf(choices[i]);
                  selectons.removeAt(searchIndex);
                  isChecked[i] = value;
                }
              });
            },
          )
        ],
      );
      options.add(choice);
    }

    return options;
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Consumer<MultiSelectLogic>(
        builder: (context, logic, child) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .1,
                      vertical: MediaQuery.of(context).size.height * .05),
                  child: new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width * .80,
                    lineHeight: 8.0,
                    percent: context.read<QuestionsService>().showProgress(),
                    progressColor: ColorCodes.mainColorDark,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    widget.question.question,
                    style: TextStyle(
                        color: ColorCodes.mainColorDark,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 15,
                ),
                Expanded(
                    child: ListView(
                  children: checkBoxes(widget.question.response),
                )),
                Container(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 300, height: 50),
                      child: ElevatedButton(
                        onPressed: () => context
                            .read<QuestionsService>()
                            .updateQuestionAnswer(json.encode(selectons),
                                context, widget.question.id, selectons),
                        child: FaIcon(
                          FontAwesomeIcons.arrowRight,
                          color: ColorCodes.white,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 20,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
