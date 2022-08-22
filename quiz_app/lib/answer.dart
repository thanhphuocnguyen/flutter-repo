import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final VoidCallback answerQuestion;

  const Answer({
    required this.answerText,
    required this.answerQuestion,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: answerQuestion,
        style: ElevatedButton.styleFrom(
          primary: (Colors.blue), //background color
          onPrimary: (Colors.white), //text color, side: use for OutlinedButton
        ),
        child: Text(answerText),
      ),
    );
  }
}
