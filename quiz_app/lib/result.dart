import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final VoidCallback resetResult;
  const Result({Key? key, required this.score, required this.resetResult})
      : super(key: key);

  String get resultPhrase {
    var resultText = "You did it!! Your score is: $score";
    if (score > 150) {
      return resultText;
    }
    return 'Score: $score, try again.';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      Text(
        resultPhrase,
        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      TextButton(
          onPressed: resetResult,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Colors.red[300],
            ),
            foregroundColor: MaterialStateProperty.all(
              Colors.grey[850],
            ),
          ),
          child: const Text("Reset quiz"))
    ]));
  }
}
