import 'package:flutter/material.dart';
import 'package:quiz_app/answer.dart';
import 'package:quiz_app/question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;
  const Quiz(
      {required this.questions,
      required this.questionIndex,
      required this.answerQuestion,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Question(
          questions[questionIndex]['question'] as String,
          key: UniqueKey(),
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
            answerText: answer["content"] as String,
            answerQuestion: () {
              answerQuestion(answer["score"] as int);
            },
            key: UniqueKey(),
          );
        }).toList()
      ],
    );
  }
}
