import 'package:flutter/material.dart';
import 'package:quizon/get_json.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizon',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Quizon'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<GetQuestions> futureQuestions;

  void initState(){
    super.initState();
    futureQuestions = fetchQuestions(); //don't call this in the build method ... can slow down the app
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Card(
                elevation: 10,
                child: FutureBuilder<GetQuestions>(
                future: futureQuestions,
                  builder: (context, snapshot) {
                    if (snapshot.hasData){
                      return Column(
                        
                        children: <Widget>[
                          Text(
                            snapshot.data.eventConductedBy,
                            style: Theme.of(context).textTheme.headline5,
                            //softWrap: true,
                          )
                        ],
                      );
                    }
                    else if (snapshot.hasError){
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator(semanticsValue: "Getting Text",);
                  }
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      OptionButtonState('A', "Hey", false),
                      OptionButtonState('B', "Hey", true),
                    ],
                  ),
                  SizedBox(width: 20.0, height:20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      OptionButtonState('C', "Hey", false),
                      OptionButtonState('D', "Hey", false),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Restart',
        child: Icon(Icons.restore, color: Colors.white,),
        backgroundColor: Colors.black,
        splashColor: Colors.white,
      ),
    );    
  }
}

class OptionButtonState extends StatelessWidget {

  // damn me!! this was soooo frustuating!!!

  final String buttonText, id;
  final bool correct;

  OptionButtonState(this.id, this.buttonText, this.correct);
  
  Color indicator(){
    if (correct){
      return Colors.green;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {return correct;},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
              backgroundColor: Colors.black,
              radius: 10,
              child: Text(id),
          ),
          SizedBox(height: 10, width: 10,),
          Text(buttonText, softWrap: true,),
        ],
      ),
      splashColor: indicator(),
      elevation: 5.0,
      color: Colors.white,
      textColor: Colors.black,
      padding: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}

class QuizonContol {
  List <String> questions;

  List<Map<String, List<Map<String, bool>>>> answers;
  
  // This part fetches all the question from the remote json file and postes them as questions one by one.
  
  /* this can wait....
  Future<GetQuestions> futureQuestions;
  
  void initState(){
    futureQuestions = fetchQuestions(); //don't call this in the build method ... can slow down the app

    GetQuestions.
  }*/

  // Let's create some demo and start playing first!
  void defineQandA(){
    questions = [
      'What is := operator called in Python 3.8?',
      'Which country with the largest population?',
      'What is the capital of Israel?'
      'Which on is the most secure instant Messaging App?'
      'Who is the current CEO of Alphabet?'
    ];

    answers = [
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
  }

  // but HOW??

  void startQuiz(){}
  void endQuiz(){}

  // I'm STUCK PLEASE HELP!!!
}
