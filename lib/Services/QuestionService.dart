import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lybl_mobile/Helpers/MagicStrings.dart';
import 'package:lybl_mobile/Models/QuestionAnswers.dart';
import 'package:lybl_mobile/Models/Questions.dart';
import 'package:lybl_mobile/Models/User2.dart';
import 'package:lybl_mobile/Models/romantic_gestures.dart';
import 'package:lybl_mobile/Services/HttpServices/Endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class QuestionsService {
  List<Question> questions = [];
  Question currentQuestion = Question();
  int index = 0;

  List<Romantic> romanticGesturesList;
  setQuestion(BuildContext context) async {
    await getQuestions();
    await getRomantic();
    print(index);
    print(questions.length);

    if (index <= (questions.length - 1)) {
      currentQuestion = questions[index];
      createQuestion(currentQuestion, context);
    } else {
      updateUser(context);
    }
  }

  createQuestion(Question question, BuildContext context) {
    print(question.type);

    switch (question.type) {
      case 'multiple_choice':
        index += 1;
        Navigator.pushNamed(context, RouteNames.MultipleChoiceQuestions,
            arguments: question);
        break;
      case 'scale':
        index += 1;
        Navigator.pushNamed(context, RouteNames.ScaleQuestions,
            arguments: question);
        break;
      case 'true_or_false':
        index += 1;
        Navigator.pushNamed(context, RouteNames.MultipleChoiceQuestions,
            arguments: question);
        break;

      case 'multi_select_2':
        index += 1;
        Navigator.pushNamed(context, RouteNames.MultiSelect2,
            arguments: question);
        break;
      case 'multi_select_5':
        index += 1;
        Navigator.pushNamed(context, RouteNames.MultiSelect5,
            arguments: question);
        break;
      default:
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.HOME, (route) => false);
    }
  }

  getQuestions() async {
    Response response = await get(Endpoints.getQuestions);
    print(Endpoints.getQuestions);
    var data = json.decode(response.body)['questions'];

    print(response.body);

    List<Question> quest = [];

    data.forEach((value) {
      value['response'] = json.decode(value['response']);
      quest.add(Question.fromJson(value));
    });

    questions = quest;
  }

  getRomantic() async {
    Response response = await get(Endpoints.getRomance());

    var data = json.decode(response.body)['romantic_gestures'];

    print(response.body);

    List<Romantic> romance = [];

    data.forEach((value) {
      // value['response'] = json.decode(value['response']);
      romance.add(Romantic.fromJson(value));
    });

    romanticGesturesList = romance;
  }

  showProgress() {
    print(questions.length);
    print(index);
    print(index / questions.length);
    return index / questions.length;
  }

  updateUser(BuildContext context) async {
    String data =
        context.read<SharedPreferences>().getString(SharedPrefNames.USER);
    String token =
        context.read<SharedPreferences>().getString(SharedPrefNames.TOKEN);
    User2 user = User2.fromJson(json.decode(data ?? ''));
    user.status = 'verified';
    print(Endpoints.updateUser);
    print(json.encode(user.toJson()));
    print(token ?? '');
    Response response = await post(Endpoints.updateUser,
        body: json.encode(user.toJson()),
        headers: {'Authorization': token ?? ''});

    if (response.statusCode == 200) {
      await get(Endpoints.updateattributes(user.id));
      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.HOME, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteNames.LOGIN, (route) => false);
    }
  }

  updateQuestionAnswer(
      String answer, BuildContext context, id, List answerList) async {
    SharedPreferences pref = context.read<SharedPreferences>();
    User2 user = userFromJson(pref.getString(SharedPrefNames.USER));
    String token =
        context.read<SharedPreferences>().getString(SharedPrefNames.TOKEN);
    print(answerList[0]);
    QuestionsAnswer ans =
        QuestionsAnswer(questionId: id, userId: user.id, answerString: answer);
    Response response = await post(Endpoints.createQuestionAnswers,
        body: questionsAnswerToJson(ans),
        headers: {'Authorization': token ?? ''});

    print(response.request);
    print(response.statusCode);
    print(questionsAnswerToJson(ans));
    switch (response.statusCode) {
      case 200:
        setQuestion(context);
        break;
    }
  }
}
