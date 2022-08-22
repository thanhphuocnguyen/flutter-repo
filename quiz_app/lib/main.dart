import 'package:flutter/material.dart';
import 'package:quiz_app/quiz.dart';
import 'package:quiz_app/result.dart';

void main() {
  runApp(MyApp(
    key: UniqueKey(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;

  final questions = [
    {
      "question": "What's your favourite color",
      "answers": [
        {"content": "Red", "score": 20},
        {"content": "Green", "score": 50},
        {"content": "Blue", "score": 99}
      ]
    },
    {
      "question": "What's your favourite animal",
      "answers": [
        {"content": "Dog", "score": 65},
        {"content": "Cat", "score": 54},
        {"content": "Mouse", "score": 12}
      ]
    },
    {
      "question": "What's your favourite super hero",
      "answers": [
        {"content": "Spiderman", "score": 32},
        {"content": "Batman", "score": 79},
        {"content": "Superman", "score": 98}
      ]
    }
  ];

  void _answerQuestion(int score) {
    if (_questionIndex < questions.length) {
      _totalScore += score;
      setState(() {
        _questionIndex++;
      });
    }
  }

  void _resetResult() {
    //do reset
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Quiz app"),
        ),
        body: _questionIndex < questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questionIndex: _questionIndex,
                questions: questions,
                key: UniqueKey(),
              )
            : Result(
                key: UniqueKey(),
                score: _totalScore,
                resetResult: _resetResult,
              ),
      ),
    );
  }
}
