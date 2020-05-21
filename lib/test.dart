import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
// Alright let's do this
void main(){
  //DefineQandA dqa = DefineQandA();
  //dqa.startQuiz();
  fetchQuestions();
}

class DefineQandA {

    final List <String> questions = [
      'What is := operator called in Python 3.8?',
      'Which country with the largest population?',
      'What is the capital of Israel?',
      'Which on is the most secure instant Messaging App?',
      'Who is the current CEO of Alphabet?',
    ];

    final List<Map<String, List<Map<String, bool>>>> answers = [
      {'a0' : [
        {'Walrus': true},
        {'Modulo': false},
        {'Undefined': false},
        {'NaN': false}
      ],
      },
      {'a1' : [
        {'India': false},
        {'China': true},
        {'USA': false},
        {'Russia': false}
      ]
      },
      {'a2' : [
        {'Judah': true},
        {'Galilee': false},
        {'Tel Aviv': false},
        {'Jerusalem': true}
      ]
      },
      {'a3' : [
        {'Telegram': false},
        {'Signal': true},
        {'WhatsApp': false},
        {'Snapchat': false}
      ]
      },
      {'a4' : [
        {'Larry Page': false},
        {'Sathya Nadella': false},
        {'Sundar Pachai': true},
        {'Bill Gates': false}
      ]
      }
    ];
  
  void startQuiz() {
    int score = 0;
    bool ret;

    for (String que in questions){
      ret = getSol(que, questions.indexOf(que));
      if (ret == true){
        score += 1;
      }
    }

    print('\n\nYour score is: $score');
  }

  bool getSol(String que, int index) {
    print(que);
    int ans, choice;
    List<Map<String, bool>> items = answers[index]['a'+index.toString()];
    for (Map<String, bool> item in items) {
      item.forEach((key, value) => print(items.indexOf(item).toString() + ' ' + key));
    }
    stdout.write("Enter  your choice: ");
    choice = int.parse(stdin.readLineSync());
    for (Map<String, bool> item in items) {
      item.forEach((key, value) {
        if (value == true) {
          ans = items.indexOf(item);
        }
      });
      if (choice == ans) {
        return true;
      }
    }
    return false;
  }
}

// Now this (above) is working and so lets dump it a go by the PODO (Plain Old Dart Object)

class GetQuestions {
    final String appName;
    final String eventConductedBy;
    final List<QuizQuestion> quizQuestions;

    GetQuestions({
        this.appName,
        this.eventConductedBy,
        this.quizQuestions,
    });

    // Can someone please explain what the heck is going on here...?
    /*
    From Reddit:
    Factory is a way of making a more flexible constructor. Typically in dart a constructor defines the fields and creates the object, no room for interpretation with the default constructor.
    Factory Constructor on the other hand can take any arguments, process them, and return an   object, either constructed, cached, re-used etc. The factory pattern is that of one that handles construction of objects, e.g. you call the factory, and it performs the construction and gives you the result.
    */
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

    // here too...??
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
    ); // and why didn't that "//Answer" special comment come up here??

    Map<String, dynamic> toJson() => {
        "Answers": answers,
        "isTrue": isTrue,
    };
}

Future<QuizQuestion> fetchQuestions() async {
    String link = "http://www.mocky.io/v2/5ebd2f5f31000018005b117f";  
    List<QuizQuestion> list;
    final response = await http.get(link);
    
    print(response.body);
    
    // hmm... is this code correct ?? cause this is not within any function in the class Future...
    // oh wait... fetchQuestions() is the function...
    if (response.statusCode == 200){ // status code == 200 implies okay
      var data = json.decode(response.body);
      var questions = data["Questions"] as List;
      list = questions.map<QuizQuestion>((json) => QuizQuestion.fromJson(json)).toList();
      print(list);
      return null;
    }
    else {
      throw Exception("Failed to fetch json");
    }
}

GetQuestions getQuestionsFromJson(String str) => GetQuestions.fromJson(json.decode(str));
String getQuestionsToJson(GetQuestions data) => json.encode(data.toJson());