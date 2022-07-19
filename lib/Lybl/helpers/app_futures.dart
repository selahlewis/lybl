import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:lybl_mobile/Lybl/models/lesson.dart';
import 'package:lybl_mobile/Lybl/models/lms_category.dart';
import 'package:lybl_mobile/Lybl/models/Token.dart';
import 'package:lybl_mobile/Lybl/models/User1.dart';
import 'package:lybl_mobile/Lybl/models/base/EventObject.dart';
import 'package:lybl_mobile/Lybl/ui/home_screen.dart';
import 'package:lybl_mobile/Lybl/utils/app_shared_preferences.dart';
import 'package:lybl_mobile/Lybl/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<EventObject> getTokenByLogin(String username, String password) async {
  var currentUrl =
      Uri.parse(APIConstants.API_BASE_URL + APIOperations.getTokenByLogin);

  try {
    final response = await http
        .post(currentUrl, body: {'username': username, 'password': password});
    print(response.statusCode);
    print(response.request);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString());
        print(responseJson['token'].toString());
        var result = responseJson['token'];

        // ignore: unnecessary_null_comparison
        if (result != null) {
          return new EventObject(
              id: EventConstants.LOGIN_USER_SUCCESSFUL, object: result);
        } else
          return new EventObject(
              id: EventConstants.LOGIN_USER_UN_SUCCESSFUL, object: null);
      } else
        return new EventObject(
            id: EventConstants.LOGIN_USER_UN_SUCCESSFUL, object: null);
    } else
      return new EventObject(object: null);
  } catch (Exception) {
    return EventObject(object: null);
  }
}

Future<EventObject> registerNewUser(String username, String password,
    String email, String firstname, String lastname) async {
  var currentUrl =
      Uri.parse(APIConstants.API_BASE_URL + APIOperations.getRegisterNewUser);

  try {
    final response = await http.post(currentUrl, body: {
      'users[0][username]=': username,
      'users[0][password]=': password,
      'users[0][firstname]=': firstname,
      'users[0][lastname]=': lastname,
      'users[0][email]=': email,
    });
    print(response.request);
    print(response.statusCode);
    // ignore: unnecessary_null_comparison
    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString());
        print(responseJson['token'].toString());
        var result = responseJson['token'];

        // ignore: unnecessary_null_comparison
        if (result != null) {
          return new EventObject(
              id: EventConstants.LOGIN_USER_SUCCESSFUL, object: result);
        } else
          return new EventObject(
              id: EventConstants.LOGIN_USER_UN_SUCCESSFUL, object: null);
      } else
        return new EventObject(
            id: EventConstants.LOGIN_USER_UN_SUCCESSFUL, object: null);
    } else
      return new EventObject(object: null);
  } catch (Exception) {
    return EventObject(object: null);
  }
}

Future<EventObject> postAnswer(
    String token, String useranswer, int num, int lessonid) async {
  var currentUrl = Uri.parse(APIConstants.API_BASE_URL +
      "webservice/rest/server.php?wsfunction=mod_lesson_process_page&lessonid=$lessonid&pageid=$num&review=0&moodlewsrestformat=json" +
      '&wstoken=' +
      token);
  final response = await http.post(currentUrl, body: {
    'data[0][name]=': '_qf__lesson_display_answer_form_essay',
    'data[0][value]=': '1',
    'data[1][name]=': 'answer_editor[text]',
    'data[1][value]=': useranswer,
    'data[2][name]=': 'answer_editor[format]',
    'data[2][value]=': '1',
    'data[3][name]=': 'attemptid',
    'data[3][value]=': '3',
  });
  print(currentUrl);
  print(response.body.toString());

  return EventObject(object: null);
}

Future<EventObject> updateAnswer(
    String token, String useranswer, int num) async {
  var currentUrl = Uri.parse(APIConstants.API_BASE_URL +
      "webservice/rest/server.php?wsfunction=mod_lesson_process_page&lessonid=15&pageid=$num&review=1&moodlewsrestformat=json" +
      '&wstoken=' +
      token);
  final response = await http.post(currentUrl, body: {
    'data[0][name]=': '_qf__essay_grading_form',
    'data[0][value]=': '1',
    'data[1][name]=': 'response_editor[text]',
    'data[1][value]=': useranswer,
    'data[2][name]=': 'response_editor[format]',
    'data[2][value]=': '1',
    'data[3][name]=': 'mode',
    'data[3][value]=': 'update',
    'data[4][name]=': 'attemptid',
    'data[4][value]=': '5',
  });
  print(currentUrl);
  print(response.body.toString());

  return EventObject(object: null);
}

Future<EventObject> fetchUserDetail(String token) async {
  var currentUrl = Uri.parse(APIConstants.API_BASE_URL +
      APIOperations.fetchUserDetail +
      '&wstoken=' +
      token);

  try {
    final response = await http.get(currentUrl);
    print(currentUrl);
    print(response.body.toString());

    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        final responseJson = json.decode(response.body);
        User1 user = User1.fromJson(responseJson);
        if (user != null) {
          return new EventObject(
              id: EventConstants.LOGIN_USER_SUCCESSFUL, object: user);
        } else
          return new EventObject(
              id: EventConstants.LOGIN_USER_UN_SUCCESSFUL, object: null);
      } else
        return new EventObject(
            id: EventConstants.LOGIN_USER_UN_SUCCESSFUL, object: null);
    } else
      return new EventObject(object: null);
  } catch (Exception) {
    return EventObject(object: null);
  }
}

Future<EventObject> registerUser(
    String name, String emailId, String password) async {
  return null;
}

Future<EventObject> changePassword(
    String emailId, String oldPassword, String newPassword) async {
  return null;
}

List<LmsCategory> parseCats(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<LmsCategory>((json) => LmsCategory.fromJson(json)).toList();
}

Future<List<LmsCategory>> fetchCats(String responseBody) async {
  return compute(parseCats, responseBody);
}

List<Lesson> parseLes(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Lesson>((json) => Lesson.fromJson(json)).toList();
}

Future<List<Lesson>> fetchLes(String responseBody) async {
  return compute(parseLes, responseBody);
}

Future<EventObject> fetchPages(String token, int pageNum, int lessonid) async {
  var currentUrl = Uri.parse(APIConstants.API_BASE_URL +
      "webservice/rest/server.php?wsfunction=mod_lesson_get_page_data&lessonid=$lessonid&pageid=$pageNum&moodlewsrestformat=json" +
      '&wstoken=' +
      token);
  try {
    final response = await http.get(currentUrl);
    print(response.body);
    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        final responseJson = await json.decode(response.body);
        final lessonList = responseJson['page'];

        if (responseJson != null) {
          return new EventObject(
              id: EventConstants.REQUEST_SUCCESSFUL, object: lessonList);
        } else
          return new EventObject(
              id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
      } else
        return new EventObject(
            id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
    } else
      return new EventObject(object: null);
  } catch (Exception) {
    return EventObject(object: null);
  }
}

Future<EventObject> fetchLessons(String token) async {
  var currentUrl = Uri.parse(APIConstants.API_BASE_URL +
      APIOperations.getLessons +
      '&wstoken=' +
      token);
  print(currentUrl);
  try {
    final response = await http.get(currentUrl);
    print(currentUrl);
    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        final responseJson = await json.decode(response.body);
        var lessonList = [];
        lessonList = responseJson['lessons'];
        print(lessonList.toString());
        if (lessonList != null) {
          return new EventObject(
              id: EventConstants.REQUEST_SUCCESSFUL, object: lessonList);
        } else
          return new EventObject(
              id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
      } else
        return new EventObject(
            id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
    } else
      return new EventObject(object: null);
  } catch (Exception) {
    return EventObject(object: null);
  }
}

Future<EventObject> fetchAllCourses(String token) async {
  var currentUrl = Uri.parse(APIConstants.API_BASE_URL +
      APIOperations.getAllCourses +
      '&wstoken=' +
      token);
  print(currentUrl);
  try {
    final response = await http.get(currentUrl);
    print(currentUrl);
    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        final responseJson = await json.decode(response.body);
        var lessonList = [];
        lessonList = responseJson['courses'];
        print(lessonList[0]["overviewfiles"][0]["fileurl"]);
        if (lessonList != null) {
          return new EventObject(
              id: EventConstants.REQUEST_SUCCESSFUL, object: lessonList);
        } else
          return new EventObject(
              id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
      } else
        return new EventObject(
            id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
    } else
      return new EventObject(object: null);
  } catch (Exception) {
    return EventObject(object: null);
  }
}

Future<EventObject> fetchRecentCourses(String token) async {
  var currentUrl = Uri.parse(APIConstants.API_BASE_URL +
      APIOperations.getRecentCourses +
      '&wstoken=' +
      token);
  print(currentUrl);
  try {
    final response = await http.get(currentUrl);
    print(currentUrl);
    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        final responseJson = await json.decode(response.body);
        var lessonList = [];
        lessonList = responseJson['courses'];
        print(lessonList[0]["overviewfiles"][0]["fileurl"]);
        if (lessonList != null) {
          return new EventObject(
              id: EventConstants.REQUEST_SUCCESSFUL, object: lessonList);
        } else
          return new EventObject(
              id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
      } else
        return new EventObject(
            id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
    } else
      return new EventObject(object: null);
  } catch (Exception) {
    return EventObject(object: null);
  }
}

Future<EventObject> fetchCategories(String token) async {
  var currentUrl = Uri.parse(APIConstants.API_BASE_URL +
      APIOperations.getCategories +
      '&wstoken=' +
      token);
  try {
    final response = await http.get(currentUrl);

    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        List<LmsCategory> categories = await fetchCats(response.body);
        if (categories != null) {
          return new EventObject(
              id: EventConstants.REQUEST_SUCCESSFUL, object: categories);
        } else
          return new EventObject(
              id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
      } else
        return new EventObject(
            id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
    } else
      return new EventObject(object: null);
  } catch (Exception) {
    return EventObject(object: null);
  }
}

Future<EventObject> fetchSingleLesson(String token, int lessonid) async {
  var currentUrl = Uri.parse(APIConstants.API_BASE_URL +
      'webservice/rest/server.php?wsfunction=mod_lesson_get_lesson&lessonid=$lessonid&moodlewsrestformat=json' +
      '&wstoken=' +
      token);
  try {
    final response = await http.get(currentUrl);

    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        final responseJson = await json.decode(response.body);
        var singleLesson = responseJson['lesson'];
        print(singleLesson);
        return new EventObject(
            id: EventConstants.REQUEST_SUCCESSFUL, object: singleLesson);
      } else
        return new EventObject(
            id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
    } else
      return new EventObject(
          id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
  } catch (Exception) {
    return EventObject(object: null);
  }
}

Future<EventObject> fetchCourses(String token, int courseId) async {
  var currentUrl = Uri.parse(APIConstants.API_BASE_URL +
      APIOperations.getCourses +
      "&value=" +
      courseId.toString() +
      '&moodlewsrestformat=json&wstoken=' +
      token);

  try {
    final response = await http.get(currentUrl);

    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        List<LmsCategory> categories = await fetchCats(response.body);
        if (categories != null) {
          return new EventObject(
              id: EventConstants.REQUEST_SUCCESSFUL, object: categories);
        } else
          return new EventObject(
              id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
      } else
        return new EventObject(
            id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
    } else
      return new EventObject(object: null);
  } catch (Exception) {
    return EventObject(object: null);
  }
}

//Fetch all pages to get the first page number then send it to the Home screen.
Future<EventObject> fetchAllPages(String token, int courseId) async {
  var _user = await AppSharedPreferences.getUserProfile();
  var userId = _user.userid;
  var enrolInCourse = Uri.parse(
      "http://jetclassroom.com/webservice/rest/server.php?wsfunction=enrol_manual_enrol_users&enrolments[0][roleid]=5&enrolments[0][userid]=$userId&enrolments[0][courseid]=$courseId&moodlewsrestformat=json&wstoken=bf0a0e3c43d280f4735915e033a77627");
  await http.get(enrolInCourse);

  var getLessonId = Uri.parse(APIConstants.API_BASE_URL +
      "webservice/rest/server.php?wsfunction=mod_lesson_get_lessons_by_courses&courseids[0]=$courseId&moodlewsrestformat=json" +
      '&wstoken=' +
      token);
  var lessonId;

  try {
    final response1 = await http.get(getLessonId);
    if (response1 != null) {
      final responseJson1 = await json.decode(response1.body);
      print(responseJson1);
      lessonId = responseJson1["lessons"][0]["id"];
      HomeScreenState.lessonids = lessonId;
      print(lessonId);
    }
    //Request to get all lesson pages based on the lesson ID.
    var getAllPagesUrl = Uri.parse(APIConstants.API_BASE_URL +
        "webservice/rest/server.php?wsfunction=mod_lesson_get_pages&lessonid=$lessonId&moodlewsrestformat=json" +
        '&wstoken=' +
        token);
    //Trigger a launch attempt of a course when you select it, important inorder for the course to start.
    var launchAttemptUrl = Uri.parse(APIConstants.API_BASE_URL +
        "webservice/rest/server.php?wsfunction=mod_lesson_launch_attempt&lessonid=$lessonId&moodlewsrestformat=json" +
        '&wstoken=' +
        token);
    final response = await http.get(getAllPagesUrl);
    await http.get(launchAttemptUrl);
    print(launchAttemptUrl);
    //Once the response is not null get the first page id number.
    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        final responseJson = await json.decode(response.body);
        final lessonList = responseJson['pages'];
        var firstPage = lessonList[0]['page'];
        int startPage = firstPage['id'];
        //Once we get the first page id we pass it into the EventObject to be used on the courses screen
        if (startPage != null) {
          return new EventObject(
              id: EventConstants.REQUEST_SUCCESSFUL, object: startPage);
        } else
          return new EventObject(
              id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
      } else
        return new EventObject(
            id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
    } else
      return new EventObject(object: null);
  } catch (Exception) {
    return EventObject(object: null);
  }
}

//Fetch all pages to get the first page number then send it to the Home screen.
Future<EventObject> fetchPagesList(String token, int lessonId) async {
  //Request to get all lesson pages based on the lesson ID.
  var getAllPagesUrl = Uri.parse(APIConstants.API_BASE_URL +
      "webservice/rest/server.php?wsfunction=mod_lesson_get_pages&lessonid=$lessonId&moodlewsrestformat=json" +
      '&wstoken=' +
      token);
  try {
    final response = await http.get(getAllPagesUrl);
    //Once the response is not null get the first page id number.
    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        final responseJson = await json.decode(response.body);
        final lessonList = responseJson['pages'];
        print(getAllPagesUrl);
        if (lessonList != null) {
          return new EventObject(
              id: EventConstants.REQUEST_SUCCESSFUL, object: lessonList);
        } else
          return new EventObject(
              id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
      } else
        return new EventObject(
            id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
    } else
      return new EventObject(object: null);
  } catch (Exception) {
    return EventObject(object: null);
  }
}

//Fetch all pages to get the first page number then send it to the Home screen.
Future<EventObject> getAnswersList(
    String token, int lessonId, int userId, int attNum) async {
  //Request to get all lesson pages based on the lesson ID.
  var getAnswersUrl = Uri.parse(APIConstants.API_BASE_URL +
      "webservice/rest/server.php?wsfunction=mod_lesson_get_user_attempt&lessonid=$lessonId&userid=$userId&lessonattempt=$attNum&moodlewsrestformat=json" +
      '&wstoken=' +
      token);
  try {
    final response = await http.get(getAnswersUrl);
    //Once the response is not null get the first page id number.
    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        final responseJson = await json.decode(response.body);
        final lessonList = responseJson['answerpages'];
        print(getAnswersUrl);
        if (lessonList != null) {
          return new EventObject(
              id: EventConstants.REQUEST_SUCCESSFUL, object: lessonList);
        } else
          return new EventObject(
              id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
      } else
        return new EventObject(
            id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
    } else
      return new EventObject(object: null);
  } catch (Exception) {
    return EventObject(object: null);
  }
}

//Fetch all pages to get the first page number then send it to the Home screen.
Future<EventObject> getAnswerNumbers(String token, int lessonId) async {
  //Request to get all lesson pages based on the lesson ID.
  var getAnswersUrl = Uri.parse(APIConstants.API_BASE_URL +
      "webservice/rest/server.php?wsfunction=mod_lesson_get_attempts_overview&lessonid=$lessonId&groupid=0&moodlewsrestformat=json" +
      '&wstoken=' +
      token);
  try {
    final response = await http.get(getAnswersUrl);
    //Once the response is not null get the first page id number.
    if (response != null) {
      if (response.statusCode == APIResponseCode.SC_OK &&
          response.body != null) {
        final responseJson = await json.decode(response.body);
        final lessonList = responseJson['data'];
        print(getAnswersUrl);
        if (lessonList != null) {
          return new EventObject(
              id: EventConstants.REQUEST_SUCCESSFUL, object: lessonList);
        } else
          return new EventObject(
              id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
      } else
        return new EventObject(
            id: EventConstants.REQUEST_UN_SUCCESSFUL, object: null);
    } else
      return new EventObject(object: null);
  } catch (Exception) {
    return EventObject(object: null);
  }
}

//Fetch all pages to get the first page number then send it to the Home screen.
Future<EventObject> finishAttempt(String token, int lessonId) async {
  //Trigger a Finish attempt of a course when you select it, important inorder for the course to start.
  var finishAttemptUrl = Uri.parse(APIConstants.API_BASE_URL +
      "webservice/rest/server.php?wsfunction=mod_lesson_finish_attempt&lessonid=$lessonId&moodlewsrestformat=json" +
      '&wstoken=' +
      token);
  try {
    http.get(finishAttemptUrl);
  } catch (Exception) {}
  return EventObject(object: null);
}
