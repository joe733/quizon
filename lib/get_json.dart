import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<GetQuestions> fetchQuestions() async {
    final response = await http.get('http://www.mocky.io/v2/5ebd2f5f31000018005b117f');
    
    // hmm... is this code correct ?? cause this is not within any function in the class Future...
    // oh wait... fetchQuestions() is the function...
    if (response.statusCode == 200){ // status code == 200 implies okay
      return getQuestionsFromJson(response.body);
    }
    else {
      throw Exception("Failed to fetch json");
    }
}

GetQuestions getQuestionsFromJson(String str) => GetQuestions.fromJson(json.decode(str));

String getQuestionsToJson(GetQuestions data) => json.encode(data.toJson());

class GetQuestions {
    final String appName;
    final String eventConductedBy;
    final List<QuizQuestion> quizQuestions;

    GetQuestions({
        this.appName,
        this.eventConductedBy,
        this.quizQuestions,
    });

    factory GetQuestions.fromJson(Map<String, dynamic> json) => GetQuestions(
        appName: json["AppName"],
        eventConductedBy: json["Event Conducted By"],
        quizQuestions: List<QuizQuestion>.from(json["Quiz Questions"].map((x) => QuizQuestion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "AppName": appName,
        "Event Conducted By": eventConductedBy,
        "Quiz Questions": List<dynamic>.from(quizQuestions.map((x) => x.toJson())),
    };
}

class QuizQuestion {
    final String questions;
    final List<Answer> answers;

    QuizQuestion({
        this.questions,
        this.answers,
    });

    factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
        questions: json["Questions"],
        answers: List<Answer>.from(json["Answers"].map((x) => Answer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Questions": questions,
        "Answers": List<dynamic>.from(answers.map((x) => x.toJson())),
    };
}

class Answer {
    final String answers;
    final bool isTrue;

    Answer({
        this.answers,
        this.isTrue,
    });

    factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        answers: json["Answers"],
        isTrue: json["isTrue"],
    );

    Map<String, dynamic> toJson() => {
        "Answers": answers,
        "isTrue": isTrue,
    };
}