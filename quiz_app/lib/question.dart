import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionTitle;
  const Question(this.questionTitle, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Text(
          questionTitle,
          style: const TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ));
  }
}
