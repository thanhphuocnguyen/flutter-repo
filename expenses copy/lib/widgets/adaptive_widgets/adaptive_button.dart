import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final VoidCallback onSubmit;
  final bool isIOS;
  const AdaptiveButton({Key? key, required this.onSubmit, required this.isIOS})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: CupertinoButton(
              onPressed: onSubmit,
              alignment: Alignment.topRight,
              color: Theme.of(context).primaryColor,
              child: const Text(
                "Add transaction",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        : ElevatedButton(
            onPressed: onSubmit,
            style: ElevatedButton.styleFrom(
              textStyle: Theme.of(context).textTheme.titleSmall,
              primary: Theme.of(context).primaryColor,
            ),
            child: const Text(
              "Add transaction",
            ),
          );
  }
}
