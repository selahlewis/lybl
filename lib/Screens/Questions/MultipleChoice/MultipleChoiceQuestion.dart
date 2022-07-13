import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/Models/Questions.dart';
import 'package:lybl_mobile/Screens/Questions/MultipleChoice/MultipleChoiceLogic.dart';
import 'package:lybl_mobile/Services/QuestionService.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class MultipleChoiceQuestion extends StatefulWidget {
  final Question question;
  MultipleChoiceQuestion(this.question);

  @override
  State<StatefulWidget> createState() => MultipleChoiceQuestionState();
}

class MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  String initialValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialValue = widget.question.response.first;
  }

  createRadio() {
    List<Widget> questions = [];
    widget.question.response.forEach((question) {
      questions.add(GestureDetector(
        onTap: () {
          //print(Provider.of<QuestionsLogic>(widget.context, listen: false).index);
          setState(() {
            initialValue = question;
          });
        },
        child: Card(
          margin: EdgeInsets.only(bottom: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            title: Text(question),
            leading: Radio<String>(
              activeColor: ColorCodes.mainColorLight,
              value: question,
              groupValue: initialValue,
              onChanged: (value) {},
            ),
          ),
        ),
      ));
    });

    return questions;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(body: Consumer<MultipleChoiceLogic>(
      builder: (context, logic, child) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                flex: 2,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                height: MediaQuery.of(context).size.height * .55,
                child: ListView(
                  children: createRadio(),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 300, height: 50),
                child: ElevatedButton(
                  onPressed: () => context
                      .read<QuestionsService>()
                      .updateQuestionAnswer(initialValue, context,
                          widget.question.id, ['gender', '0']),
                  child: FaIcon(
                    FontAwesomeIcons.arrowRight,
                    color: ColorCodes.white,
                  ),
                ),
              ),
              Container(
                height: 20,
              )
            ],
          ),
        );
      },
    ));
  }
}
