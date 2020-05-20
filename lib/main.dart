import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quizon/home.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
    routes: <String, WidgetBuilder> {
      '/home': (BuildContext context) => MyApp()
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  AnimationController _controller;

  startTIme() async {
    var _duration = Duration(seconds: 2,);
    _controller.forward();
    sleep(Duration(seconds: 1,));
    _controller.reset();
    _controller.dispose();
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState(){    
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    super.initState();
    startTIme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Center(
        child: RotationTransition(
          turns: Tween(begin: 1.0, end: 0.0,).animate(_controller),
          child: Image.asset('assets/quiz.png'),
        ),
      ),
    );
  }
}