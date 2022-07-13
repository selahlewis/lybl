import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lybl_mobile/Models/Questions.dart';
import 'package:lybl_mobile/Screens/Questions/Scale/ScaleLogic.dart';
import '../../../Helpers/MagicStrings.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../Services/QuestionService.dart';
import 'package:provider/provider.dart';

class ScaleQuestion extends StatefulWidget {
  final Question question;

  ScaleQuestion(this.question);

  @override
  State<StatefulWidget> createState() => ScaleQuestionState();
}

class ScaleQuestionState extends State<ScaleQuestion> {
  double currentValue = 2;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Consumer<ScaleLogic>(
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
                Spacer(
                  flex: 1,
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
                Spacer(
                  flex: 1,
                ),
                Container(
                  child: Slider(
                    value: currentValue,
                    onChanged: (double value) {
                      setState(() {
                        currentValue = value;
                      });
                    },
                    min: double.parse(widget.question.response.first),
                    max: double.parse(widget.question.response.last),
                  ),
                ),
                Spacer(
                  flex: 1,
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
                            .updateQuestionAnswer(currentValue.toString(),
                                context, widget.question.id, ['living', '0']),
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
